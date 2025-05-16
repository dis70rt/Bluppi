import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:synqit/Provider/music_provider/current_track_provider.dart';
import 'package:synqit/Provider/music_provider/music_player_provider.dart';
import 'dart:ui';

import 'package:synqit/Provider/music_provider/music_player_state.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/queue_bottomsheet.dart';

final _isExpandedProvider = StateProvider.autoDispose<bool>((ref) => false);

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
    final isExpanded = ref.watch(_isExpandedProvider);
    final expansionNotifier = ref.read(_isExpandedProvider.notifier);

    if (currentTrack == null) {
      return const SizedBox.shrink();
    }

    final position = playerState.position;
    final duration = playerState.duration;
    // final bufferedPosition = playerState.bufferedPosition;
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

    // double bufferedProgress = hasDuration
    //     ? (bufferedPosition.inMilliseconds / duration.inMilliseconds)
    //     : 0.0;
    // bufferedProgress = bufferedProgress.clamp(0.0, 1.0);

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
              child: InkWell(
                onTap: () {
                  expansionNotifier.update((state) => !state);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: isExpanded ? 150.0 : 70.0,
                  padding:
                      EdgeInsets.symmetric(vertical: isExpanded ? 12.0 : 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.1), width: 1)),
                  child: Column(
                    mainAxisAlignment: isExpanded
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: CachedNetworkImage(
                                  imageUrl: currentTrack.imageUrl,
                                  placeholder: (context, url) => Container(
                                    width: 45,
                                    height: 45,
                                    color: Colors.grey[700],
                                    child: const Icon(Icons.music_note,
                                        color: Colors.white70, size: 24),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
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
                                      currentTrack.trackName,
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
                              // if (hasDuration &&
                              //     !isExpanded) // Show time only when minimized
                              //   Text(
                              //     '${_formatDuration(position)} / ${_formatDuration(duration)}',
                              //     style: TextStyle(
                              //         color: Colors.white.withOpacity(0.6),
                              //         fontSize: 11),
                              //   ),

                              const SizedBox(width: 8),
                              if (!isExpanded)
                                _buildPlayPauseButton(context, playerState,
                                    playerNotifier, currentTrack != null),
                              if (isExpanded)
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          sheetAnimationStyle: AnimationStyle(
                                            curve: Curves.easeInOut,
                                            duration: const Duration(
                                                milliseconds: 300),
                                          ),

                                          builder: (context) {
                                            return queueBottomSheet();
                                          });
                                    },
                                    icon: const Icon(Icons.more_vert))
                            ],
                          ),
                        ),
                      ),
                      if (isExpanded) const SizedBox(height: 10),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 100),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: SizedBox(
                          height: 1,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 1.0,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 0.0, elevation: 0.0),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 0.0),
                              activeTrackColor: Colors.white.withOpacity(0.8),
                              inactiveTrackColor: Colors.white.withOpacity(0.3),
                              thumbColor: Colors.transparent,
                              overlayColor: Colors.transparent,
                              trackShape: const RoundedRectSliderTrackShape(),
                            ),
                            child: Slider(
                              value: sliderValue,
                              min: 0.0,
                              max: 1.0,
                              onChanged: null, // Disable interaction
                              onChangeStart: null,
                              onChangeEnd: null,
                            ),
                          ),
                        ),

                        secondChild: SizedBox(
                          height: 14,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4.0,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 5.0, elevation: 3.0),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 15.0),
                              thumbColor: Colors.white,
                              activeTrackColor: Colors.white.withOpacity(0.8),
                              inactiveTrackColor: Colors.white.withOpacity(0.3),
                              overlayColor: Colors.white.withAlpha(0x29),
                              trackShape: const RoundedRectSliderTrackShape(),
                            ),
                            child: Slider(
                              value: sliderValue,
                              min: 0.0,
                              max: 1.0,
                              onChanged: isExpanded &&
                                      hasDuration &&
                                      playerState.status != PlayerStatus.error
                                  ? (value) {}
                                  : null,
                              onChangeStart: isExpanded &&
                                      hasDuration &&
                                      playerState.status != PlayerStatus.error
                                  ? (_) {}
                                  : null,
                              onChangeEnd: isExpanded &&
                                      hasDuration &&
                                      playerState.status != PlayerStatus.error
                                  ? (value) {
                                      final seekPosition = duration * value;
                                      playerNotifier.seek(seekPosition);
                                    }
                                  : null,
                            ),
                          ),
                        ),

                        // SizedBox(
                        //   height: isExpanded ? 14 : 1,
                        //   child: SliderTheme(
                        //     data: SliderTheme.of(context).copyWith(
                        //       trackHeight: isExpanded ? 4.0 : 2.0,
                        //       thumbShape: isExpanded
                        //           ? const RoundSliderThumbShape(
                        //               enabledThumbRadius: 5.0, elevation: 3.0)
                        //           : const RoundSliderThumbShape(
                        //               enabledThumbRadius: 0.0, elevation: 1.0),
                        //       overlayShape: isExpanded
                        //           ? const RoundSliderOverlayShape(
                        //               overlayRadius: 15.0)
                        //           : const RoundSliderOverlayShape(
                        //               overlayRadius: 10.0),
                        //       thumbColor: Colors.white,
                        //       activeTrackColor: Colors.white.withOpacity(0.8),
                        //       inactiveTrackColor: Colors.white.withOpacity(0.3),
                        //       overlayColor: Colors.white.withAlpha(0x29),
                        //       trackShape: const RoundedRectSliderTrackShape(),
                        //       activeTickMarkColor: Colors.transparent,
                        //       inactiveTickMarkColor: Colors.transparent,
                        //     ),
                        //     child: Slider(
                        //       value: sliderValue,
                        //       min: 0.0,
                        //       max: 1.0,
                        //       onChanged: isExpanded &&
                        //               hasDuration &&
                        //               playerState.status != PlayerStatus.error
                        //           ? (value) {}
                        //           : null,
                        //       onChangeStart: isExpanded &&
                        //               hasDuration &&
                        //               playerState.status != PlayerStatus.error
                        //           ? (_) {}
                        //           : null,
                        //       onChangeEnd: isExpanded &&
                        //               hasDuration &&
                        //               playerState.status != PlayerStatus.error
                        //           ? (value) {
                        //               final seekPosition = duration * value;
                        //               playerNotifier.seek(seekPosition);
                        //             }
                        //           : null,
                        //     ),
                        //   ),
                        // ),
                      ),
                      if (isExpanded)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 6.0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(position),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12),
                              ),
                              IconButton(
                                icon: const Icon(Icons.skip_previous,
                                    color: Colors.white),
                                iconSize: 40.0,
                                padding: EdgeInsets.zero,
                                tooltip: 'Previous',
                                onPressed: () => ref
                                    .read(musicPlayerProvider.notifier)
                                    .skipToPrevious(),
                              ),
                              const SizedBox(width: 8),
                              _buildPlayPauseButton(context, playerState,
                                  playerNotifier, currentTrack != null),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.skip_next,
                                    color: Colors.white),
                                iconSize: 40.0,
                                padding: EdgeInsets.zero,
                                tooltip: 'Next',
                                onPressed: () => ref
                                    .read(musicPlayerProvider.notifier)
                                    .skipToNext(),
                              ),
                              Text(
                                _formatDuration(duration),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
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
