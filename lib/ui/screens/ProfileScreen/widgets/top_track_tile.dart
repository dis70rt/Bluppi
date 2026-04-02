import 'package:bluppi/application/controllers/playback_controller.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/top_track_entry_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class TopTrackTile extends ConsumerWidget {
  final TopTrackEntryModel track;
  final int rank;

  const TopTrackTile({
    super.key,
    required this.track,
    required this.rank,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final queue = ref.watch(queueProvider);

    final isCurrentTrack = queue.currentTrack?.id == track.trackId;
    final isPlaying = isCurrentTrack && player.status == PlaybackStatus.playing;
    final isLoading = isCurrentTrack &&
        (player.status == PlaybackStatus.loading ||
            player.status == PlaybackStatus.buffering);

    return InkWell(
      onTap: () {
        ref.read(trackActionControllerProvider.notifier).playOrToggleTrack(
          trackId: track.trackId,
          isCurrentTrack: isCurrentTrack,
          onError: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg)),
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(10),
      splashColor: BluppiColors.primary.withAlpha(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            // Rank number
            SizedBox(
              width: 28,
              child: isPlaying || isLoading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: Lottie.asset(
                        'assets/animations/music_playing.json',
                        repeat: true,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      "$rank",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: rank <= 3
                            ? BluppiColors.primary
                            : BluppiColors.textSecondary,
                      ),
                    ),
            ),
            const SizedBox(width: 12),

            // Album art
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: track.imageSmall,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 48,
                  height: 48,
                  color: BluppiColors.surfaceRaised,
                  child: const Icon(
                    Icons.music_note,
                    color: BluppiColors.textDisabled,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Track info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    style: TextStyle(
                      color: isCurrentTrack
                          ? BluppiColors.primary
                          : BluppiColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    track.artist,
                    style: const TextStyle(
                      color: BluppiColors.textSecondary,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Play count
            Text(
              "${track.playCount} plays",
              style: const TextStyle(
                color: BluppiColors.textDisabled,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
