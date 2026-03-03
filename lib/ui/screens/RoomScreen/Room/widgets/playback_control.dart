import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart';
import 'package:bluppi/application/providers/party/playback_stream_provider.dart';
import 'package:bluppi/domain/models/playback_stream_model.dart';

class RoomPlaybackControls extends ConsumerWidget {
  final bool isHost;
  final String roomId; // ADDED: Needs to know which room to control

  const RoomPlaybackControls({
    super.key,
    required this.isHost,
    required this.roomId,
  });

  String _formatDuration(Duration? d) {
    if (d == null || d.inMilliseconds <= 0) return '00:00';
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. THE AUTHORITATIVE SERVER STATE (For the buttons and track info)
    final serverState = ref.watch(playbackStreamProvider(roomId));
    final serverNotifier = ref.read(playbackStreamProvider(roomId).notifier);

    // 2. THE LOCAL UI STATE (For the smooth 60fps progress bar and buffering spinner)
    final localPlayerState = ref.watch(playerProvider);

    if (serverState == null) return const SizedBox.shrink();

    final track = serverState.track;
    final duration = Duration(milliseconds: track.durationMs);
    
    // We read the local audio player's position because it is already perfectly 
    // synced by our Go server, and it updates smoothly for the UI slider.
    final position = localPlayerState.position;
    
    final hasDuration = duration.inMilliseconds > 0;
    double progress = hasDuration ? (position.inMilliseconds / duration.inMilliseconds) : 0.0;
    progress = progress.clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- SMART SEEKING BAR ---
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
                    // Note: Disabled dragging for everyone in party mode unless you add a SeekCommand to your Go Server
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 0.0,
                      disabledThumbRadius: 0.0,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 0.0,
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
                    onChanged: null, // Seeking disabled in party mode by default
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
        
        // --- PLAYBACK CONTROLS (Host Only) ---
        if (isHost) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                iconSize: 44.0,
                onPressed: () {
                  ref.read(playerProvider.notifier).previous();
                },
              ),
              const SizedBox(width: 16),
              _buildPlayPauseButton(serverState, localPlayerState, serverNotifier),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                iconSize: 44.0,
                onPressed: () {
                  ref.read(playerProvider.notifier).next();
                },
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPlayPauseButton(
    PlaybackStateModel serverState, 
    PlayerState localState, 
    PlaybackStreamNotifier serverNotifier
  ) {
    // 1. Check local state first: If just_audio is downloading the buffer, show the spinner.
    // The UI stays locked until the BufferReady command fires and the server responds.
    if (localState.status == PlaybackStatus.loading || localState.status == PlaybackStatus.buffering) {
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
    }

    // 2. Check Authoritative Server State: Show Play or Pause based on the Go Server
    if (serverState.isPlaying) {
      return IconButton(
        icon: const Icon(Icons.pause_circle_filled_rounded, color: Colors.white),
        iconSize: 60.0,
        padding: EdgeInsets.zero,
        onPressed: serverNotifier.pause, // Push intent to server
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.play_circle_filled_rounded, color: Colors.white),
        iconSize: 60.0,
        padding: EdgeInsets.zero,
        onPressed: serverNotifier.play, // Push intent to server
      );
    }
  }
}