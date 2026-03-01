import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart';
import 'package:bluppi/application/providers/music/queue_provider.dart';

class RoomPlaybackControls extends ConsumerWidget {
  final bool isHost;

  const RoomPlaybackControls({
    super.key,
    required this.isHost,
  });

  String _formatDuration(Duration? d) {
    if (d == null || d.inMilliseconds <= 0) return '00:00';
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    final playerNotifier = ref.read(playerProvider.notifier);
    final queueState = ref.watch(queueProvider);
    final track = queueState.currentTrack;

    if (track == null) return const SizedBox.shrink();

    final duration = Duration(milliseconds: track.durationMs);
    final position = playerState.position;
    final hasDuration = duration.inMilliseconds > 0;
    double progress = hasDuration ? (position.inMilliseconds / duration.inMilliseconds) : 0.0;
    progress = progress.clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Smart Seeking Bar (Visible to everyone, interactive for host)
        Row(
          children: [
            Text(
              _formatDuration(position),
              style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 12),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 20,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4.0,
                    // Hide thumb if not host to make it look like a pure progress bar
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: isHost ? 6.0 : 0.0,
                      disabledThumbRadius: 0.0,
                    ),
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: isHost ? 14.0 : 0.0,
                    ),
                    thumbColor: Colors.white,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withAlpha(76),
                    overlayColor: Colors.white.withAlpha(41),
                    trackShape: const RoundedRectSliderTrackShape(),
                  ),
                  child: Slider(
                    value: progress,
                    min: 0.0,
                    max: 1.0,
                    // Disable dragging if not host
                    onChanged: (isHost && hasDuration) ? (value) {
                      // Call your seek method here if available, e.g.:
                      // playerNotifier.seek(Duration(milliseconds: (value * duration.inMilliseconds).toInt()));
                    } : null,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatDuration(duration),
              style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 12),
            ),
          ],
        ),
        
        // Playback Controls (Host Only)
        if (isHost) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                iconSize: 44.0,
                onPressed: playerNotifier.previous,
              ),
              const SizedBox(width: 16),
              _buildPlayPauseButton(playerState, playerNotifier),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                iconSize: 44.0,
                onPressed: playerNotifier.next,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPlayPauseButton(PlayerState state, PlaybackNotifier notifier) {
    switch (state.status) {
      case PlaybackStatus.loading:
      case PlaybackStatus.buffering:
        return const SizedBox(
          width: 60,
          height: 60,
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      case PlaybackStatus.playing:
        return IconButton(
          icon: const Icon(Icons.pause_circle_filled_rounded, color: Colors.white),
          iconSize: 60.0,
          padding: EdgeInsets.zero,
          onPressed: notifier.pause,
        );
      case PlaybackStatus.paused:
      case PlaybackStatus.completed:
      case PlaybackStatus.idle:
      case PlaybackStatus.error:
        return IconButton(
          icon: const Icon(Icons.play_circle_filled_rounded, color: Colors.white),
          iconSize: 60.0,
          padding: EdgeInsets.zero,
          onPressed: notifier.play,
        );
    }
  }
}