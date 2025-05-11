import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/firebase_services.dart';
import 'package:synqit/Provider/track_search_provider.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/title_track.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/track_loading.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final firebaseServices = FirebaseServices();
  String _currentQuery = '';

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsyncValue = ref.watch(trackSearchProvider(_currentQuery));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading:
        centerTitle: true,

        title: _buildSearchBar(),
        // const Text(
        //   "Search",
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: 20,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildBodyContent(searchAsyncValue),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(AsyncValue<List<Track>> searchAsyncValue) {
    if (_currentQuery.isEmpty) {
      // return const Center(
      //   child: Text(
      //     "Enter a search term to begin",
      //     style: TextStyle(color: Colors.white54),
      //   ),
      // );
      return FutureBuilder(
        future: firebaseServices.getRecentlySearched(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Skeletonizer(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => const Skeletonizer(
                    child: ListTile(
                      // contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.history, color: Colors.white54),
                      title: Text(
                        "Recent Searches",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      trailing: Icon(Icons.clear, color: Colors.white38),
                    ),
                  ),
                ),
              ),
            );
          }

          final recents = snapshot.data ?? [];
          if (recents.isEmpty) {
            return const Center(
              child: Text(
                "What are you looking for?",
                style: TextStyle(color: Colors.white54),
              ),
            );
          }

          return ListView.builder(
            itemCount: recents.length,
            itemBuilder: (context, index) {
              final query = recents[index];

              return ListTile(
                contentPadding: const EdgeInsets.only(left: 16.0),
                leading: const Icon(Icons.history, color: Colors.white54),
                title: Text(
                  query,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                trailing: IconButton(
                  icon:
                      const Icon(Icons.clear, color: Colors.white38, size: 20),
                  onPressed: () async {
                    await firebaseServices.deleteRecentlySearched(query);
                    if (mounted) {
                      setState(() {
                        // Setting state forces the FutureBuilder to re-fetch the data.
                      });
                    }
                  },
                ),
                onTap: () {
                  _searchController.text = query;
                  _debounce?.cancel();
                  _searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _searchController.text.length));

                  if (mounted) {
                    setState(() {
                      _currentQuery = query;
                    });
                  }
                  firebaseServices.recentlySearched(query);
                },
              );
            },
          );
        },
      );
    }

    return searchAsyncValue.when(
      loading: () => ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return trackLoadingListItem(context);
          }),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error searching tracks: $error',
            style: const TextStyle(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (tracks) {
        if (tracks.isEmpty) {
          return Center(
            child: Text(
              "No results found for '$_currentQuery'",
              style: const TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            final track = tracks[index];

            return trackListItem(context, track, ref);
          },
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        // borderRadius: BorderRadius.circular(15.0),
        border:
            Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2))),
      ),
      child: Center(
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white70,
          decoration: InputDecoration(
            border: InputBorder.none,
            // isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 0),
            hintText: "Search tracks or artists...",
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            prefixIcon: InkWell(
              borderRadius: BorderRadius.circular(30),
              child: const Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => ref.read(mainScreenIndexProvider.notifier).state = 0,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon:
                        Icon(Icons.clear, color: Colors.white.withOpacity(0.8)),
                    onPressed: () {
                      _searchController.clear();
                      _debounce?.cancel();

                      if (mounted) {
                        setState(() {
                          _currentQuery = '';
                        });
                      }
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              final trimmedValue = value.trim();

              if (_currentQuery != trimmedValue && mounted) {
                setState(() {
                  _currentQuery = trimmedValue;
                });
              }
            });
          },
          onSubmitted: (value) {
            final trimmedValue = value.trim();
            if (_currentQuery != trimmedValue && mounted) {
              setState(() {
                _currentQuery = trimmedValue;
              });
            }
            firebaseServices.recentlySearched(trimmedValue);
            _debounce?.cancel();
          },
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
