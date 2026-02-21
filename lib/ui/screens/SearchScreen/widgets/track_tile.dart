import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/application/providers/music/track_provider.dart';
import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:bluppi/domain/models/search_track_model.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart';
import 'package:bluppi/domain/models/track_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

// TODO: outertune check

class TrackTile extends ConsumerWidget {
  final SearchTrackModel track;
  const TrackTile({super.key, required this.track});

  Future<void> _onTap(WidgetRef ref, PlayerState player, bool isCurrentTrack) async {
  final playback = ref.read(playerProvider.notifier);
  final queue = ref.read(queueProvider.notifier);

  if (!isCurrentTrack) {
    final TrackModel fullTrack = await ref.read(trackProvider(track.id).future);
    queue.setQueue([fullTrack], QueueSource.user);
    return;
  }

  if (player.status == PlaybackStatus.playing) {
    playback.pause();
  } else {
    playback.play();
  }
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final player = ref.watch(playerProvider);
    final queue = ref.watch(queueProvider);

    final isCurrentTrack = queue.currentTrack?.id == track.id;
    final isPlaying = isCurrentTrack && player.status == PlaybackStatus.playing;
    final isLoading =
        isCurrentTrack &&
        (player.status == PlaybackStatus.loading ||
            player.status == PlaybackStatus.buffering);

    return Dismissible(
  key: Key(track.id.toString()),
  direction: DismissDirection.startToEnd,
  background: Container(
    color: Colors.greenAccent,
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Icon(Icons.queue_music_rounded, color: Colors.white),
      ),
    ),
  ),
  confirmDismiss: (direction) async {
    final trackRepo = ref.read(trackServiceProvider);
    final fullTrack = await trackRepo.getTrack(track.id);

    if (!context.mounted) return false;

    ref.read(queueProvider.notifier).addToBack(fullTrack, QueueSource.user);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.queue_music_outlined, color: Colors.green),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                "${track.title} added to Queue",
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );
    return false;
  },
      child: InkWell(
        onTap: () => _onTap(ref, player, isCurrentTrack),
        splashColor: theme.colorScheme.primary.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
                        Expanded(
                          child: Text(
                            track.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isPlaying
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
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
      ),
    );
  }
}
