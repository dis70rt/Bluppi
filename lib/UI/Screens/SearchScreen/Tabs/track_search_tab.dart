import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Provider/MusicProvider/paginated_search_provider.dart';
import 'package:bluppi/UI/Screens/SearchScreen/Widgets/title_track.dart';
import 'package:bluppi/UI/Screens/SearchScreen/Widgets/track_loading.dart';

class TracksSearchTab extends ConsumerStatefulWidget {
  final String query;

  const TracksSearchTab({super.key, required this.query});

  @override
  ConsumerState<TracksSearchTab> createState() => _TracksSearchTabState();
}

class _TracksSearchTabState extends ConsumerState<TracksSearchTab> {
  final _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paginatedSearchProvider.notifier).searchTracks(widget.query, refresh: true);
    });
  }
  
  @override
  void didUpdateWidget(TracksSearchTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(paginatedSearchProvider.notifier).searchTracks(widget.query, refresh: true);
      });
    }
  }
  
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(paginatedSearchProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paginatedSearchProvider);

    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        if (state.tracks.isEmpty && state.isLoading)
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => trackLoadingListItem(context)
          ),
          
        if (state.tracks.isEmpty && !state.isLoading)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "No results found for '${widget.query}'",
              style: const TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
          ),
          
        if (state.tracks.isNotEmpty)
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.tracks.length,
            itemBuilder: (context, index) {
              final track = state.tracks[index];
              return trackListItem(context, track, ref);
            },
          ),
          
        if (state.isLoading && state.tracks.isNotEmpty)
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => trackLoadingListItem(context)
          ),
          
        SizedBox(height: 100)
      ],
    );
  }
}