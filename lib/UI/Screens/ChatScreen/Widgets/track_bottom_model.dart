import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/track_search_provider.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/glassmorphic_track_tile.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/track_loading.dart';

Widget trackSearchBottomSheet(Function(Track)? onTap) {
  return Consumer(
    builder: (context, ref, child) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          color: AppColors.darkSurfaceBlack.withValues(alpha: 0.85),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: TrackSearchContent(onTap: onTap),
          ),
        ),
      );
    },
  );
}

class TrackSearchContent extends ConsumerStatefulWidget {
  final Function(Track)? onTap;
  const TrackSearchContent({super.key, required this.onTap});

  @override
  ConsumerState<TrackSearchContent> createState() => _TrackSearchContentState();
}

class _TrackSearchContentState extends ConsumerState<TrackSearchContent> {
  final TextEditingController _searchController = TextEditingController();
  final userServices = UserServices();
  String _currentQuery = '';

  Timer? _debounce;
  Future<List<String>>? _recentSearchesFuture;

  @override
  void initState() {
    super.initState();
    _recentSearchesFuture = userServices.getRecentlySearched();
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
    final isSearching = searchAsyncValue.isLoading;
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            height: 5,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.divider.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Tracks',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.textPrimaryStandard,
                ),
              ),
            ],
          ),
        ),
        _buildSearchBar(isSearching),
        
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: _currentQuery.isEmpty
                ? _buildRecentSearches(key: const ValueKey('recents'))
                : _buildSearchResults(
                    key: ValueKey('results-${_currentQuery.hashCode}'),
                    searchAsyncValue: searchAsyncValue,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(bool isSearching) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white70,
            onChanged: _onSearchTextChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              // isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
              hintText: "Search tracks...",
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              prefixIcon: const Icon(Icons.search, color: Colors.white70),
              suffixIcon: _searchController.text.isNotEmpty
                  ? isSearching
                      ? Container(
                          padding: const EdgeInsets.all(15),
                          width: 20,
                          height: 20,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white70),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.clear,
                              color: Colors.white.withValues(alpha: 0.8)),
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
            onSubmitted: _onSearchSubmitted,
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults({
    Key? key,
    required AsyncValue<List<Track>> searchAsyncValue,
  }) {
    final previousTracks = searchAsyncValue.valueOrNull;

    return SingleChildScrollView(
      key: key,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              "Results for \"$_currentQuery\"",
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          searchAsyncValue.when(
            loading: () {
              if (previousTracks != null && previousTracks.isNotEmpty) {
                return Stack(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: previousTracks.length,
                      itemBuilder: (context, index) {
                        final track = previousTracks[index];
                        return Opacity(
                          opacity: 0.7,
                          child: _buildTrackTile(track),
                        );
                      },
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.2),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) => trackLoadingListItem(context),
              );
            },
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error searching tracks: $error',
                style: const TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ),
            data: (tracks) {
              if (tracks.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.music_off,
                        size: 40,
                        color: AppColors.textHint.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "No results found for '$_currentQuery'",
                        style: const TextStyle(color: Colors.white54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Try a different search term",
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return _buildTrackTile(track);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrackTile(Track track) {
    return GrassmorphicTrackTile(
      track: track,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(track);
        }
        Navigator.pop(context);
      },
      // trailing: 
      
    );
  }

  Widget _buildRecentSearches({Key? key}) {
    return FutureBuilder(
      key: key,
      future: _recentSearchesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            ),
          );
        }

        final recents = snapshot.data ?? [];
        if (recents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 48,
                  color: AppColors.textHint.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Search for tracks",
                  style: TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Try searching for your favorite artists or songs",
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: recents.length,
          itemBuilder: (context, index) {
            final query = recents[index];

            return ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 16.0),
              leading: const Icon(Icons.history, color: Colors.white54),
              title: Text(
                query,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.clear, color: Colors.white38, size: 20),
                onPressed: () async {
                  await userServices.deleteRecentlySearched(query);
                  if (mounted) {
                    setState(() {
                      _recentSearchesFuture = userServices.getRecentlySearched();
                    });
                  }
                },
              ),
              onTap: () {
                _searchController.text = query;
                _searchController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _searchController.text.length));
                _debounce?.cancel();
                setState(() {
                  _currentQuery = query;
                });
                userServices.recentlySearched(query);
              },
            );
          },
        );
      },
    );
  }

  void _onSearchTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1500), () {
      final trimmedValue = value.trim();

      if (_currentQuery != trimmedValue && mounted) {
        setState(() {
          _currentQuery = trimmedValue;
        });

        if (trimmedValue.isNotEmpty) {
          userServices.recentlySearched(trimmedValue);
        }
      }
    });
  }

  void _onSearchSubmitted(String value) {
    final trimmedValue = value.trim();
    _debounce?.cancel();

    if (_currentQuery != trimmedValue && mounted) {
      setState(() {
        _currentQuery = trimmedValue;
      });
    }

    if (trimmedValue.isNotEmpty) {
      userServices.recentlySearched(trimmedValue);
    }
  }
}