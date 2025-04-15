import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/track_search_provider.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/title_track.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/track_loading.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

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
          _buildSearchBar(),
          Expanded(
            child: _buildBodyContent(searchAsyncValue),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(AsyncValue<List<Track>> searchAsyncValue) {
    if (_currentQuery.isEmpty) {
      return const Center(
        child: Text(
          "Enter a search term to begin",
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return searchAsyncValue.when(
      loading: () => ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return trackLoadingListItem(context);
        }
      ),
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

            return trackListItem(context, track);
          },
        );
      },
    );
  }

  Widget _buildSearchBar() {
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
                _debounce?.cancel();
                final trimmedValue = value.trim();
                if (_currentQuery != trimmedValue && mounted) {
                  setState(() {
                    _currentQuery = trimmedValue;
                  });
                }
              },
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      ),
    );
  }
}
