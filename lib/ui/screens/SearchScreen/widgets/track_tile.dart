import 'package:audio_service/audio_service.dart';
import 'package:bluppi/application/providers/music/stream_provider.dart';
import 'package:bluppi/application/providers/music/track_provider.dart';
import 'package:bluppi/domain/models/search_track_model.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart';
import 'package:bluppi/domain/models/track_model.dart';
import 'package:bluppi/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class TrackTile extends ConsumerWidget {
  final SearchTrackModel track;
  const TrackTile({super.key, required this.track});

  Future<void> _onTap(WidgetRef ref, PlayerState player) async {
    final notifier = ref.read(playerProvider.notifier);
    final isCurrentTrack = player.currentTrack?.id == track.id;


    if (!isCurrentTrack) {
      final TrackModel fullTrack = await ref.read(trackProvider(track.id).future);
      final streamRepo = ref.read(streamRepositoryProvider);

      final audioUrl = await streamRepo.getStreamURL(
        fullTrack.artist,
        fullTrack.title,
        fullTrack.id,
      );
      // TODO: Maybe put more data in the extras, like the full track info, to avoid fetching it again in the player screen
      // TODO: Implementation for getting the full audio url is remaining;
      final mediaItem = MediaItem(
      id: fullTrack.id,
      title: fullTrack.title,
      artist: fullTrack.artist,
      artUri: Uri.parse(fullTrack.imageLarge),
      duration: Duration(milliseconds: fullTrack.durationMs),
      extras: {
        'audioUrl': audioUrl,
      },
    );

    await audioHandler.playMediaItem(mediaItem);
      return;
    }

    if (player.status == PlaybackStatus.playing) {
      notifier.pause();
    } else {
      notifier.play();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final player = ref.watch(playerProvider);

    final isCurrentTrack = player.currentTrack?.id == track.id;
    final isPlaying = isCurrentTrack && player.status == PlaybackStatus.playing;
    final isLoading =
        isCurrentTrack &&
        (player.status == PlaybackStatus.loading ||
            player.status == PlaybackStatus.buffering);

    return InkWell(
      onTap: () => _onTap(ref, player),
      splashColor: theme.colorScheme.primary.withAlpha(30),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: track.imageSmall,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      width: 44,
                      height: 44,
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                    errorWidget: (_, _, _) => Container(
                      width: 44,
                      height: 44,
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.music_note),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isPlaying || isLoading)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Lottie.asset(
                            'assets/animations/music_playing.json',
                            repeat: true,
                            fit: BoxFit.cover,
                          ),
                        ),
                      SizedBox(width: isPlaying ? 6 : 0),
                      Text(
                        track.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isPlaying
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    track.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.inverseSurface.withAlpha(120),
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
