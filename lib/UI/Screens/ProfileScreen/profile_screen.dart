import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Models/last_track_model.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/auth_provider.dart';
import 'package:synqit/Provider/user_provider.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/app_bar.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/follow_row.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/following_stats.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/music_player.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/profile_bio.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    // final spotifyService =
    //     SpotifyService(ref.read(authProvider).value!.accessToken);
    return user.when(
      data: (user) {
        if (user == null) return const Center(child: Text('No user logged in'));
        return Scaffold(
          backgroundColor: const Color(0XFF181818),
          body: Stack(
            children: [
              profileAppBar(user.profilePic, context),
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
                bottom: 150,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          profileBio(
                            user.name,
                            "I'm not perfect, but every day I try to grow into someone I'm proud of.",
                            user.profilePic,
                          ),
                          const SizedBox(height: 20),
                          Center(child: followRow()),
                          const SizedBox(height: 20),
                          followingStats(
                              user.followers, user.following, user.following),
                          const SizedBox(height: 40),
                          // FutureBuilder(
                          //   future: spotifyService.getLastPlayedSong(),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Center(
                          //         child: Skeletonizer(
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     horizontal: 24),
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     const Text(
                          //                       "Last Played",
                          //                       textAlign: TextAlign.left,
                          //                       style: TextStyle(
                          //                         fontSize: 12,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: Colors.white54,
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       formatTrackPlayedAt(
                          //                               DateTime.now()
                          //                                   .toIso8601String())
                          //                           .toString(),
                          //                       textAlign: TextAlign.left,
                          //                       style: const TextStyle(
                          //                         fontSize: 12,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: Colors.white54,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //               MiniMusicPlayer(
                          //                   track: LastTrack.defaultTrack()),
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //     if (snapshot.hasError) {
                          //       return const Center(
                          //         child:
                          //             Text('Error fetching last played song'),
                          //       );
                          //     }
                          //     if (!snapshot.hasData) {
                          //       return const Center(
                          //         child: Text('No last played song found'),
                          //       );
                          //     }
                          //     final LastTrack track = snapshot.data!;
                          //     return Column(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 24),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               const Text(
                          //                 "Last Played",
                          //                 textAlign: TextAlign.left,
                          //                 style: TextStyle(
                          //                   fontSize: 12,
                          //                   fontWeight: FontWeight.w600,
                          //                   color: Colors.white54,
                          //                 ),
                          //               ),
                          //               Text(
                          //                 formatTrackPlayedAt(track.playedAt)
                          //                     .toString(),
                          //                 textAlign: TextAlign.left,
                          //                 style: const TextStyle(
                          //                   fontSize: 12,
                          //                   fontWeight: FontWeight.w600,
                          //                   color: Colors.white54,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         MiniMusicPlayer(track: track),
                          //       ],
                          //     );
                          //   },
                          // ),
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
    final refresh = ref.refresh(userProvider);
  }

  String formatTrackPlayedAt(String playedAt) {
    final dateTime = DateTime.tryParse(playedAt);
    if (dateTime == null) return playedAt;

    final now = DateTime.now();

    final isToday = dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;

    if (isToday) {
      return DateFormat.jm().format(dateTime);
    } else {
      return DateFormat('d MMMM yyyy').format(dateTime);
    }
  }
}
