import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/user_provider/user_provider.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/app_bar.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/edit_row.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/follow_button.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/following_stats.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/profile_bio.dart';
import 'package:synqit/Utils/datetime.dart';

import 'Widgets/music_player.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final UserModel? user;
  const ProfileScreen({super.key, this.user});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  UserModel? viewedUser;
  bool isRefreshing = false;
  final UserServices userServices = UserServices();

  @override
  void initState() {
    viewedUser = widget.user;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeUserStats();
    });
    super.initState();
  }

  void _initializeUserStats() {
    final userToDisplay = widget.user ?? ref.read(userProvider).value;
    if (userToDisplay != null) {
      ref.read(followStatsProvider(userToDisplay.id).notifier).loadStats(
          followers: userToDisplay.followers,
          following: userToDisplay.following,
          playlists: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(userProvider);

    return currentUserAsync.when(
      data: (currentUser) {
        if (currentUser == null) {
          return const Center(child: Text('No user logged in'));
        }

        final bool isOwnProfile =
            widget.user == null || widget.user!.id == currentUser.id;

        if (!isOwnProfile && viewedUser == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.red,));
        }

        final UserModel displayedUser =
            isOwnProfile ? currentUser : viewedUser!;

        return Scaffold(
          backgroundColor: AppColors.backgroundDark,
          body: Stack(
            children: [
              profileAppBar(
                  displayedUser.profilePic, context, ref, isOwnProfile),
              _buildProfileBackground(context),
              _buildProfilePicture(displayedUser, context),
              _buildProfileContent(displayedUser, isOwnProfile, currentUser.id),
            ],
          ),
        );
      },
      error: (error, stackTrace) =>
          Center(child: Text('Error: ${error.toString()}')),
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.yellow,)),
    );
  }

  Widget _buildProfileBackground(BuildContext context) {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture(UserModel user, BuildContext context) {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).primaryColor, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: user.profilePic != null
                ? CachedNetworkImage(
                    imageUrl: user.profilePic!,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade800,
                      child: const Icon(Icons.error,
                          size: 50, color: Colors.white70),
                    ),
                  )
                : Container(
                    color: Colors.grey.shade800,
                    child: const Icon(Icons.person,
                        size: 50, color: Colors.white70),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(
      UserModel user, bool isOwnProfile, String currentUserId) {
    return Positioned(
      top: 130,
      left: 0,
      right: 0,
      bottom: 0,
      child: RefreshIndicator(
        onRefresh: () =>
            isOwnProfile ? _refreshCurrentUser() : _refreshViewedUser(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              profileBio(user.name, user.bio, user.username, isOwnProfile),
              const SizedBox(height: 20),
              Center(
                  child: isOwnProfile
                      ? editRow()
                      : FollowButton(followeeId: user.id, username: user.username)),
              const SizedBox(height: 20),
              // followingStats(user.followers, user.following, user.following),
              FollowingStatsWidget(userId: user.id),
              const SizedBox(height: 40),
              _buildLastPlayed(user.id),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastPlayed(String userId) {
    return FutureBuilder(
      future: userServices.getLastPlayedSong(uid: userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Skeletonizer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Last Played",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white54,
                          ),
                        ),
                        Text(
                          formatTrackPlayedAt(DateTime.now()).toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  miniPlayerLoading()
                ],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching last played song'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('No last played song found'),
          );
        }

        final Track track = snapshot.data!['track'];
        final playedAt = DateTime.parse(snapshot.data!['lastPlayed']);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Last Played",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    formatTrackPlayedAt(playedAt).toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            MiniMusicPlayer(track: track),
          ],
        );
      },
    );
  }

  Future<void> _refreshCurrentUser() async {
    try {
    ref.refresh(userProvider.notifier).refresh();
    _initializeUserStats();
  } catch (e) {
    log('Error refreshing current user: $e');
  }
  }

  Future<void> _refreshViewedUser() async {
    setState(() => isRefreshing = true);

    try {
      if (widget.user != null) {
        final updatedUser =
            await userServices.getUserByUsername(widget.user!.username);
        setState(() => viewedUser = updatedUser);
      }
    } catch (e) {
      log('Error refreshing user data: $e');
    } finally {
      setState(() => isRefreshing = false);
    }
  }

  Widget miniPlayerLoading() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.grey.shade700,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Unknown Track",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Unknown Artist",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [Icon(Icons.play_arrow, size: 40)],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
