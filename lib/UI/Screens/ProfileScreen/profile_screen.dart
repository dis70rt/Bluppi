import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/firebase_services.dart';
import 'package:synqit/Provider/user_provider.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/app_bar.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/follow_row.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/following_stats.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/profile_bio.dart';
import 'package:synqit/Utils/datetime.dart';

import 'Widgets/music_player.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final firebaseServices = FirebaseServices();
    return user.when(
      data: (user) {
        if (user == null) return const Center(child: Text('No user logged in'));
        return Scaffold(
          backgroundColor: const Color(0XFF181818),
          body: Stack(
            children: [
              profileAppBar(user.profilePic, context, ref),
              Positioned(
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
              ),
              Positioned(
                bottom: 225,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: RefreshIndicator(
                    onRefresh: () => refresh(),
                    // color: Spotify.primary,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          profileBio(
                            user.name,
                            user.bio,
                            user.profilePic,
                          ),
                          const SizedBox(height: 20),
                          Center(child: followRow()),
                          const SizedBox(height: 20),
                          followingStats(
                              user.followers, user.following, user.following),
                          const SizedBox(height: 40),
                          FutureBuilder(
                            future: firebaseServices.getLastPlayedSong(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Skeletonizer(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                formatTrackPlayedAt(
                                                        Timestamp.now())
                                                    .toString(),
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
                                        // MiniMusicPlayer(
                                        //     track: Track.empty()),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                  child:
                                      Text('Error fetching last played song'),
                                );
                              }
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text('No last played song found'),
                                );
                              }
                              final Track track = snapshot.data!['track'];
                              final playedAt = snapshot.data!['lastPlayed'];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          formatTrackPlayedAt(playedAt)
                                              .toString(),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) =>
          Center(child: Text('Error: ${error.toString()}')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> refresh() async {
    // ignore: unused_local_variable
    final refresh = ref.refresh(userProvider);
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
                  color: Colors.black.withOpacity(0.3),
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
                      children: [
                        Icon(Icons.play_arrow, size: 40)
                      ],
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
