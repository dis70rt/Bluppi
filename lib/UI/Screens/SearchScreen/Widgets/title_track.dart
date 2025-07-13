import 'dart:developer';
import 'package:bluppi/Provider/RoomProvider/room_provider.dart';
import 'package:bluppi/UI/Widgets/playback_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Data/Models/track_model.dart';
import 'package:bluppi/Provider/MusicProvider/audio_streaming_provider.dart';
import 'package:bluppi/Provider/MusicProvider/current_track_provider.dart';
import 'package:bluppi/Provider/MusicProvider/music_player_provider.dart';
import 'package:bluppi/Provider/MusicProvider/queue_provider.dart';

Widget trackListItem(BuildContext context, Track track, WidgetRef ref) {
  final playerNotifier = ref.read(musicPlayerProvider.notifier);
  final imageUrl = track.imageUrl;
  // final previewUrl = track.previewUrl;
  const double avatarSize = 50.0;
  final currentTrack = ref.watch(currentTrackProvider);
  bool isCurrent =
      currentTrack != null && track.trackId == currentTrack.trackId;

  return Dismissible(
    key: Key(track.trackId.toString()),
    direction: DismissDirection.startToEnd,

    // dismissThresholds: const {
    //     DismissDirection.startToEnd: 0.4,
    // },

    background: Container(
      color: Spotify.primary,
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(Icons.queue_music_rounded, color: Colors.white),
        ),
      ),
    ),

    confirmDismiss: (direction) async {
      ref.read(queueProvider.notifier).add(track);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          dismissDirection: DismissDirection.down,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              const Icon(Icons.queue_music_outlined, color: Spotify.primary),
              const SizedBox(width: 8),
              Flexible(
                  child: Text("${track.trackName} added to Queue",
                      style: const TextStyle(color: Colors.white70)))
            ],
          ),
          duration: const Duration(seconds: 5),
        ),
      );

      return false;
    },
    // onDismissed: (direction) {
    //   log("Track dismissed: ${track.trackName}");
    // },
    child: ListTile(
      leading: SizedBox(
        width: avatarSize,
        height: avatarSize,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.white.withValues(alpha: 0.2),
            child: imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: avatarSize,
                    height: avatarSize,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white54),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      log("Failed to load image: $imageUrl, Error: $error");
                      return Icon(
                        Icons.music_note,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: avatarSize * 0.6,
                      );
                    },
                  )
                : Icon(
                    Icons.music_note,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: avatarSize * 0.6,
                  ),
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCurrent)
            Lottie.asset('assets/animations/music_playing.json', height: 20),
          Flexible(
            child: Text(
              track.trackName,
              style: TextStyle(
                  color: isCurrent
                      ? AppColors.accent
                      : AppColors.textPrimaryStandard,
                  fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Text(
        track.artistName,
        style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      // trailing: Icon(Icons.favorite_border, color: Colors.white.withValues(alpha: 0.8)),
      onTap: () async {
        if(!ref.read(roomProvider).canCommand) {
          showPlaybackDialog(context);
        } else {
            if (track.audioUrl == null || track.audioUrl!.isEmpty) {
            final streamService = ref.read(audioStreamingServiceProvider);
            try {
              final streamData = await streamService.getAudioStreamData(track);
              if (streamData['audioUrl'] != null) {
                final enrichedTrack = track.copyWith(
                  audioUrl: streamData['audioUrl'],
                  videoId: streamData['videoId'] ?? track.videoId,
                );
                playerNotifier.loadTrack(enrichedTrack);
                return;
              }
            } catch (e) {
              log("Failed to get audio URL: $e");
            }
          }
          playerNotifier.loadTrack(track);
        }
      },
    ),
  );
}
