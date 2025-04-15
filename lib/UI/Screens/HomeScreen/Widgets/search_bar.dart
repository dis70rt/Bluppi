import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/lasfm_track_search_provider.dart';

import 'package:synqit/Provider/lastfm_track_state.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  void _performSearch(String query) {
    final trimmedQuery = query.trim();

    ref
        .read(trackNotifierProvider.notifier)
        .searchAndSuggestTracks(trimmedQuery);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(trackNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onTap: () => Navigator.maybePop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          searchBar(),
          Expanded(
            child: _buildBodyContent(searchState),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(TrackState searchState) {
    if (searchState is TrackLoading) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }

    if (searchState is TrackError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error: ${searchState.message}',
            style: const TextStyle(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (searchState is TrackInitial) {
      return const Center(
        child: Text("Enter a search term to begin",
            style: TextStyle(color: Colors.white54)),
      );
    }

    if (searchState is TrackSuccess) {
      if (searchState.searchResults.isEmpty) {
        if (_searchController.text.trim().isNotEmpty) {
          return Center(
            child: Text(
                "No results found for '${_searchController.text.trim()}'",
                style: const TextStyle(color: Colors.white54)),
          );
        } else {
          return const Center(
            child: Text("Enter a search term to begin",
                style: TextStyle(color: Colors.white54)),
          );
        }
      }

      return ListView.builder(
        itemCount: searchState.searchResults.length,
        itemBuilder: (context, index) {
          final track = searchState.searchResults[index];

          return _buildTrackListItem(track);
        },
      );
    }

    return const Center(
        child: Text("Something went wrong.",
            style: TextStyle(color: Colors.orangeAccent)));
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15.0),
              border:
                  Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white70,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                hintText: "Search tracks or artists...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 12.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.8),
                    size: 24,
                  ),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear,
                            color: Colors.white.withOpacity(0.8)),
                        onPressed: () {
                          _searchController.clear();

                          _performSearch('');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) {
                _performSearch(value);
              },
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrackListItem(Track track) {
    final imageUrl = track.artworkUrl100;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.2),
        backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
            ? NetworkImage(imageUrl)
            : null,
        child: (imageUrl == null || imageUrl.isEmpty)
            ? Icon(Icons.music_note, color: Colors.white.withOpacity(0.6))
            : null,
      ),
      title: Text(
        track.trackName,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        track.artistName,
        style: TextStyle(color: Colors.white.withOpacity(0.8)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        log("Tapped: ${track.trackName} by ${track.artistName}");
      },
    );
  }
}
