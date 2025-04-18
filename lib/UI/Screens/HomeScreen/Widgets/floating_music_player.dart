import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:synqit/Provider/music_provider/current_track_provider.dart';
import 'package:synqit/Provider/music_provider/music_player_provider.dart';
import 'dart:ui';

import 'package:synqit/Provider/music_provider/music_player_state.dart';

class FloatingMusicPlayer extends ConsumerWidget {
  const FloatingMusicPlayer({super.key});

  String _formatDuration(Duration? d) {
    if (d == null || d.inMilliseconds <= 0) return '00:00';
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(musicPlayerProvider);
    final currentTrack = ref.watch(currentTrackProvider);
    final playerNotifier = ref.read(musicPlayerProvider.notifier);

    if (currentTrack == null) {
      return const SizedBox.shrink();
    }

    final position = playerState.position;
    final duration = playerState.duration;
    final bufferedPosition = playerState.bufferedPosition;
    final bool hasDuration = duration != null && duration.inMilliseconds > 0;

    double progress =
        hasDuration ? (position.inMilliseconds / duration.inMilliseconds) : 0.0;
    progress = progress.clamp(0.0, 1.0);

    double sliderValue = playerState.isSeeking
        ? (hasDuration
            ? (playerState.position.inMilliseconds / duration.inMilliseconds)
            : 0.0)
        : progress;
    sliderValue = sliderValue.clamp(0.0, 1.0);

    double bufferedProgress = hasDuration
        ? (bufferedPosition.inMilliseconds / duration.inMilliseconds)
        : 0.0;
    bufferedProgress = bufferedProgress.clamp(0.0, 1.0);

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Material(
              color: Colors.black.withOpacity(0.5),
              elevation: 0,
              child: Container(
                height: 70,
                // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(

                        color: Colors.white.withOpacity(0.1), width: 1
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: CachedNetworkImage(
                                imageUrl: currentTrack.thumbnailUrl ?? '',
                                placeholder: (context, url) => Container(
                                  width: 45,
                                  height: 45,
                                  color: Colors.grey[700],
                                  child: const Icon(Icons.music_note,
                                      color: Colors.white70, size: 24),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 45,
                                  height: 45,
                                  color: Colors.grey[700],
                                  child: const Icon(Icons.error_outline,
                                      color: Colors.redAccent, size: 24),
                                ),
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentTrack.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    currentTrack.artistName,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (hasDuration)
                              Text(
                                '${_formatDuration(position)} / ${_formatDuration(duration)}',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 11),
                              ),
                            const SizedBox(width: 8),
                            _buildPlayPauseButton(context, playerState,
                                playerNotifier, currentTrack != null),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0.0, elevation: 1.0),
                          overlayShape:
                              const RoundSliderOverlayShape(overlayRadius: 10.0),
                          thumbColor: Colors.white,
                          activeTrackColor: Colors.white.withOpacity(0.8),
                          inactiveTrackColor: Colors.white.withOpacity(0.3),
                          overlayColor: Colors.white.withAlpha(0x29),
                          trackShape: const RectangularSliderTrackShape(),
                          activeTickMarkColor: Colors.transparent,
                          inactiveTickMarkColor: Colors.transparent,
                        ),
                        child: Slider(
                          value: sliderValue,
                          min: 0.0,
                          max: 1.0,
                          onChanged: hasDuration &&
                                  playerState.status != PlayerStatus.error
                              ? (value) {}
                              : null,
                          onChangeStart: hasDuration &&
                                  playerState.status != PlayerStatus.error
                              ? (_) {}
                              : null,
                          onChangeEnd: hasDuration &&
                                  playerState.status != PlayerStatus.error
                              ? (value) {
                                  final seekPosition = duration * value;
                                  playerNotifier.seek(seekPosition);
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayPauseButton(
      BuildContext context,
      MusicPlayerState playerState,
      MusicPlayerNotifier playerNotifier,
      bool isTrackLoaded) {
    switch (playerState.status) {
      case PlayerStatus.loading:
        return Container(
          width: 42,
          height: 42,
          padding: const EdgeInsets.all(10.0),
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );

      case PlayerStatus.playing:
        return IconButton(
          icon: const Icon(Icons.pause_circle_filled_rounded,
              color: Colors.white),
          iconSize: 40.0,
          padding: EdgeInsets.zero,
          tooltip: 'Pause',
          onPressed: playerNotifier.pause,
        );

      case PlayerStatus.paused:
      case PlayerStatus.completed:
      case PlayerStatus.ready:
      case PlayerStatus.initial:
      case PlayerStatus.error:
      default:
        return IconButton(
          icon:
              const Icon(Icons.play_circle_filled_rounded, color: Colors.white),
          iconSize: 40.0,
          padding: EdgeInsets.zero,
          tooltip: 'Play',
          onPressed:
              isTrackLoaded && !playerState.isPlaying && !playerState.isLoading
                  ? playerNotifier.play
                  : null,
        );
    }
  }
}
