import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/track_search_provider.dart';
import 'package:synqit/Provider/user_provider/user_search_provider.dart';
import 'package:synqit/UI/Screens/SearchScreen/search_navigation_screen.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/title_track.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/track_loading.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
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
    final userSearchAsyncValue = ref.watch(userSearchProvider(_currentQuery));
    final isSearching =
        searchAsyncValue.isLoading || userSearchAsyncValue.isLoading;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: _buildSearchBar(isSearching),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
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
                      userSearchAsyncValue: userSearchAsyncValue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults({
    Key? key,
    required AsyncValue<List<Track>> searchAsyncValue,
    required AsyncValue<UserSearchResult> userSearchAsyncValue,
  }) {
    final previousUserData = userSearchAsyncValue.valueOrNull;
    final previousTracks = searchAsyncValue.valueOrNull;

    return SingleChildScrollView(
      key: key,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          userSearchAsyncValue.when(
            loading: () {
              if (previousUserData != null &&
                  previousUserData.users.isNotEmpty) {
                final users = previousUserData.users.where((user) {
                  return user["id"] != userServices.auth.currentUser!.uid;
                }).toList();

                return Stack(
                  children: [
                    _buildUsersSection(users),
                    Container(
                      height: 150,
                      color: Colors.black.withValues(alpha: 0.3),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return _buildUsersSectionLoading();
            },
            error: (error, _) =>
                _buildErrorSection('Error searching users: $error'),
            data: (usersResult) {
              if (usersResult.count == 0) return const SizedBox.shrink();
              final users = usersResult.users.where((user) {
                return user["id"] != userServices.auth.currentUser!.uid;
              }).toList();
              return _buildUsersSection(users);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Popular Tracks",
              style: TextStyle(
                  color: AppColors.textPrimary,
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
                          child: trackListItem(context, track, ref),
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
                  itemBuilder: (context, index) =>
                      trackLoadingListItem(context));
            },
            error: (error, _) =>
                _buildErrorSection('Error searching tracks: $error'),
            data: (tracks) {
              if (tracks.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "No results found for '$_currentQuery'",
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return trackListItem(context, track, ref);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUsersSection(List<dynamic> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Accounts",
            style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: users.length,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                final user = users[index];
                return Container(
                  margin: const EdgeInsets.only(right: 25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => ref
                            .read(searchNavigationProvider.notifier)
                            .goToUserProfile(user["username"]),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Colors.primaries[index % Colors.primaries.length],
                          child: user["profile_pic"] != null
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: user["profile_pic"]!,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.white.withValues(alpha: 0.6),
                                  size: 30,
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "@${user["username"]}",
                        style: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 10),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user["name"]!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildUsersSectionLoading() {
    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Accounts",
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) => userLoadingListItem(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection(String message) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.redAccent),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRecentSearches({Key? key}) {
    return FutureBuilder(
      key: key,
      future: _recentSearchesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Skeletonizer(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => const Skeletonizer(
                  child: ListTile(
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
                icon: const Icon(Icons.clear, color: Colors.white38, size: 20),
                onPressed: () async {
                  await userServices.deleteRecentlySearched(query);
                  if (mounted) {
                    setState(() {});
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
                userServices.recentlySearched(query);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSearchBar(bool isSearching) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
      ),
      child: Center(
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white70,
          onChanged: _onSearchTextChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 0),
            hintText: "Search tracks or people...",
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            prefixIcon: InkWell(
              borderRadius: BorderRadius.circular(30),
              child: const Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => ref.read(mainScreenIndexProvider.notifier).state = 0,
            ),
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
