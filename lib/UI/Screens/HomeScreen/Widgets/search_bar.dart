import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/firebase_services.dart';
import 'package:synqit/Provider/track_search_provider.dart';
import 'package:synqit/Provider/user_search_provider.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/search_navigation_screen.dart';
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
    final userSearchAsyncValue = ref.watch(userSearchProvider(_currentQuery));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: _buildSearchBar(),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildBodyContent(searchAsyncValue, userSearchAsyncValue),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent(AsyncValue<List<Track>> searchAsyncValue,
      AsyncValue<UserSearchResult> userSearchAsyncValue) {
    if (_currentQuery.isEmpty) {
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
                  firebaseServices.recentlySearched(query);
                },
              );
            },
          );
        },
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          userSearchAsyncValue.when(
            loading: () => SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeletonizer(
                    enabled: true,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Loading",
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) =>
                          userLoadingListItem(context),
                    ),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error searching users: $error',
                style: const TextStyle(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ),
            data: (usersResult) {
              if (usersResult.count == 0) {
                return const SizedBox.shrink();
              }
              //TODO: Remove Client Side Filtering
              final users = usersResult.users.where((user) {
                return user["id"] != firebaseServices.auth.currentUser!.uid;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                                  onTap: () => ref
                                      .read(searchNavigationProvider.notifier)
                                      .goToUserProfile(user["username"]),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.primaries[
                                        index % Colors.primaries.length],
                                    child: user["avatar_url"] != null
                                        ? ClipOval(
                                            child: Image.network(
                                              user["avatar_url"]!,
                                              fit: BoxFit.cover,
                                              width: 60,
                                              height: 60,
                                            ),
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.white
                                                .withValues(alpha: 0.6),
                                            size: 30,
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "@${user["username"]}",
                                  style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 10),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  user["name"]!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
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
            loading: () => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return trackLoadingListItem(context);
                }),
            error: (error, stackTrace) => Padding(
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

  Widget _buildSearchBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        // border: Border(
        //     bottom: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
      ),
      child: Center(
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white70,
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
                ? IconButton(
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
