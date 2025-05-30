import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/music_provider/current_track_provider.dart';
import 'package:synqit/Provider/music_provider/music_player_provider.dart';
import 'package:synqit/Provider/music_provider/queue_provider.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/track_preview_player.dart';

Widget trackListItem(BuildContext context, Track track, WidgetRef ref) {
  final playerNotifier = ref.read(musicPlayerProvider.notifier);
  final imageUrl = track.imageUrl;
  final previewUrl = track.previewUrl;
  const double avatarSize = 50.0;
  final currentTrack = ref.watch(currentTrackProvider);
  bool isCurrent = currentTrack != null && track.trackId == currentTrack.trackId;

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
              Flexible(child: Text("${track.trackName} added to Queue", style: const TextStyle(color: Colors.white70)))
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
          if(isCurrent)
          Lottie.asset('assets/animations/music_playing.json', height: 20),
          Flexible(
            child: Text(
              track.trackName,
              style: TextStyle(color: isCurrent ? AppColors.accent : AppColors.textPrimaryStandard, fontWeight: FontWeight.w600),
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
      trailing: TrackPreviewPlayer(
        previewUrl: previewUrl,
      ),
      onTap: () {
        playerNotifier.loadTrack(track);
      },
    ),
  );
}
