import 'package:bluppi/application/providers/music/search_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/ui/screens/SearchScreen/widgets/search_bar.dart';
import 'package:bluppi/ui/screens/SearchScreen/widgets/track_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final ScrollController _scrollController;
  late final ProviderSubscription _searchListener;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    _searchListener = ref.listenManual(
      searchTrackProvider,
      (prev, next) {
        final prevQuery = prev?.value?.query;
        final nextQuery = next.value?.query;

        if (prevQuery != nextQuery &&
            _scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      },
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final state = ref.read(searchTrackProvider).value;
    if (state == null) return;

    if (!state.hasMore || state.isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    if (maxScroll - currentScroll <= 200) {
      ref.read(searchTrackProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _searchListener.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final searchAsync = ref.watch(searchTrackProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            userAsync.when(
              data: (user) => CircleAvatar(
                radius: 18,
                backgroundImage:
                    CachedNetworkImageProvider(user!.profilePic),
              ),
              loading: () =>
                  const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
              error: (_, _) =>
                  const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
            ),
            const SizedBox(width: 16),
            const Text(
              'Search',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 12),

            Expanded(
              child: searchAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),

                error: (e, _) => Center(
                  child: Text(
                    'Something went wrong\n$e',
                    textAlign: TextAlign.center,
                  ),
                ),

                data: (state) {
                  if (state.query.isEmpty) {
                    return const Center(
                      child: Text('Start typing to search'),
                    );
                  }

                  if (state.results.isEmpty) {
                    return const Center(
                      child: Text('No results found'),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: state.results.length +
                        ((state.isLoadingMore && state.hasMore) ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.results.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return TrackTile(
                        track: state.results[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
