import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/music_provider/music_player_provider.dart';

class MiniMusicPlayer extends ConsumerWidget {
  final Track track;
  const MiniMusicPlayer({super.key, required this.track});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(musicPlayerProvider);
    final playerNotifier = ref.read(musicPlayerProvider.notifier);

    // final isCurrentTrack = playerState.currentTrack?.id == track.id &&
    //     playerState.status != PlayerStatus.initial &&
    //     playerState.status != PlayerStatus.error;

    // if (playerState.currentTrack?.id != track.id &&
    //     playerState.status != PlayerStatus.loading &&
    //     track.name.isNotEmpty &&
    //     track.artist.name.isNotEmpty) {}

    double progress = 0.0;
    // if (isCurrentTrack &&
    //     playerState.duration != null &&
    //     playerState.duration!.inMilliseconds > 0) {
    //   progress = (playerState.position.inMilliseconds /
    //           playerState.duration!.inMilliseconds)
    //       .clamp(0.0, 1.0);
    // }

    IconData playPauseIcon = Icons.play_arrow;
    playPauseAction() => playerNotifier.loadTrack(track);

    // if (isCurrentTrack) {
    //   if (playerState.status == PlayerStatus.loading) {
    //     playPauseIcon = Icons.hourglass_empty;
    //     playPauseAction = null;
    //   } else if (playerState.status == PlayerStatus.playing) {
    //     playPauseIcon = Icons.pause;
    //     playPauseAction = playerNotifier.pause;
    //   } else if (playerState.status == PlayerStatus.paused ||
    //       playerState.status == PlayerStatus.completed
    //       // playerState.status == PlayerStatus.loaded
    //       ) {
    //     playPauseIcon = Icons.play_arrow;
    //     playPauseAction = playerNotifier.play;
    //   } else if (playerState.status == PlayerStatus.error) {
    //     playPauseIcon = Icons.error_outline;
    //     playPauseAction = () => playerNotifier.loadTrack(track);
    //   }
    // }

    return Container(
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: track.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: track.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.grey.shade900),
                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade800),
                    )
                  : Container(color: Colors.grey.shade900),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
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
                            child: CachedNetworkImage(
                              imageUrl: track.imageUrl,
                              errorWidget: (_, __, ___) => const Icon(
                                  Icons.music_note,
                                  color: Colors.white54),
                              placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white54,
                                      ))),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // isCurrentTrack
                                //     ? playerState.currentTrack?.name ??
                                //         track.name
                                    // : 
                                    track.trackName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                // isCurrentTrack
                                //     ? playerState.currentTrack?.artist.name ??
                                //         track.artist.name
                                //     : 
                                    track.artistName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              // if (isCurrentTrack && playerState.hasError)
                              //   Text(
                              //     playerState.errorMessage ??
                              //         'An error occurred',
                              //     style: TextStyle(
                              //         fontSize: 10, color: Colors.red[300]),
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!playerState.hasError)
                          Visibility(
                            visible: !playerState.isLoading,
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: CircularProgressIndicator(
                                value: playerState.isLoading ? null : progress,
                                strokeWidth: 2.5,
                                backgroundColor: Colors.white38,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          ),
                        if (playerState.isLoading)
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        else
                          IconButton(
                            iconSize: 30,
                            icon: Icon(
                              playPauseIcon,
                              color: Colors.white,
                            ),
                            onPressed: playPauseAction,
                          ),
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
