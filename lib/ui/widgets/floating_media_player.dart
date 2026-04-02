import 'dart:ui';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/ui/widgets/queue_bottomsheet.dart';
import 'package:bluppi/ui/widgets/track_like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart';

class FloatingMusicPlayer extends ConsumerStatefulWidget {
  const FloatingMusicPlayer({super.key});
  @override
  ConsumerState<FloatingMusicPlayer> createState() => _FloatingMusicPlayerState();
}

class _FloatingMusicPlayerState extends ConsumerState<FloatingMusicPlayer> {
  bool isExpanded = false;
  bool isMinimized = false;
  bool _snappedRight = false;

  bool get _canControl {
    final currentRoom = ref.read(currentRoomProvider);
    final currentUser = ref.read(userProvider).value;
    if (currentRoom == null) return true;
    return currentRoom.hostUserId == currentUser?.id;
  }

  void _guardedAction(VoidCallback action) {
    if (!_canControl) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Only the host can control playback.")),
      );
      return;
    }
    action();
  }

  String _formatDuration(Duration? d) {
    if (d == null || d.inMilliseconds <= 0) return '00:00';
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
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

    final double miniSize = 73.0;
    final double collapsedHeight = 73.0;
    final double expandedHeight = 152.0;
    final double fullWidth = MediaQuery.of(context).size.width - 24.0; // 12px padding each side

    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            final v = details.primaryVelocity ?? 0;
            if (v.abs() > 200) {
              setState(() {
                isMinimized = true;
                isExpanded = false;
                _snappedRight = v > 0;
              });
            }
          },
          onTap: () {
            if (isMinimized) {
              setState(() => isMinimized = false);
            } else {
              setState(() => isExpanded = !isExpanded);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            height: isMinimized ? miniSize : (isExpanded ? expandedHeight : collapsedHeight),
            margin: isMinimized
                ? (_snappedRight
                    ? EdgeInsets.only(left: fullWidth - miniSize)
                    : EdgeInsets.only(right: fullWidth - miniSize))
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(isMinimized ? 16.0 : 12.0),
              border: Border.all(
                color: Colors.white.withAlpha(25),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isMinimized ? 15.0 : 11.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: isMinimized
                    ? _buildMinimizedView(track, playerState, playerNotifier)
                    : _buildFullView(track, playerState, playerNotifier, progress, position, duration, hasDuration),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Minimized square view ───────────────────────────────────────────
  Widget _buildMinimizedView(
    dynamic track,
    PlayerState playerState,
    PlaybackNotifier playerNotifier,
  ) {
    return Container(
      color: Colors.black.withAlpha(90),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Hero(
              tag: 'player_art_${track.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: CachedNetworkImage(
                  imageUrl: track.imageLarge,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 45, height: 45,
                    color: Colors.grey[700],
                    child: const Icon(Icons.music_note, color: Colors.white54, size: 24),
                  ),
                ),
              ),
            ),
            _buildPlayPauseOverlay(playerState, playerNotifier),
          ],
        ),
      ),
    );
  }

  // ─── Full-width bar view (collapsed + expanded) ──────────────────────
  Widget _buildFullView(
    dynamic track,
    PlayerState playerState,
    PlaybackNotifier playerNotifier,
    double progress,
    Duration position,
    Duration duration,
    bool hasDuration,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Top row: art + title + controls ──
        SizedBox(
          height: 70.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'player_art_${track.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: CachedNetworkImage(
                      imageUrl: track.imageLarge,
                      placeholder: (context, url) => Container(
                        width: 45, height: 45,
                        color: Colors.grey[700],
                        child: const Icon(Icons.music_note, color: Colors.white70, size: 24),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 45, height: 45,
                        color: Colors.grey[700],
                        child: const Icon(Icons.error_outline, color: Colors.redAccent, size: 24),
                      ),
                      width: 45, height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        track.artist,
                        style: TextStyle(
                          color: Colors.white.withAlpha(179),
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                TrackLikeButton(trackId: track.id),
                const SizedBox(width: 4),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isExpanded
                      ? IconButton(
                          key: const ValueKey('queue'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              useRootNavigator: false,
                              backgroundColor: Colors.transparent,
                              scrollControlDisabledMaxHeightRatio: 0.65,
                              sheetAnimationStyle: AnimationStyle(
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300),
                              ),
                              builder: (context) => QueueBottomSheet(),
                            );
                          },
                          icon: const Icon(Icons.more_vert),
                        )
                      : _buildPlayPauseButton(playerState, playerNotifier, size: 40.0),
                ),
              ],
            ),
          ),
        ),

        // ── Thin progress bar (collapsed only) ──
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isExpanded ? 0 : 1,
          child: isExpanded
              ? const SizedBox.shrink()
              : SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 1.0,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0, elevation: 0.0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                    activeTrackColor: Colors.white.withAlpha(204),
                    inactiveTrackColor: Colors.white.withAlpha(76),
                    thumbColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                    trackShape: const RoundedRectSliderTrackShape(),
                  ),
                  child: Slider(value: progress, min: 0.0, max: 1.0, onChanged: null),
                ),
        ),

        // ── Expanded controls ──
        ClipRect(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuart,
            height: isExpanded ? 80.0 : 0,
            padding: const EdgeInsets.only(top: 10),
            child: isExpanded
                ? Column(
                    children: [
                      SizedBox(
                        height: 14,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4.0,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0, elevation: 3.0),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 15.0),
                            thumbColor: Colors.white,
                            activeTrackColor: Colors.white.withAlpha(204),
                            inactiveTrackColor: Colors.white.withAlpha(76),
                            overlayColor: Colors.white.withAlpha(41),
                            trackShape: const RoundedRectSliderTrackShape(),
                          ),
                          child: Slider(
                            value: progress, min: 0.0, max: 1.0,
                            onChanged: hasDuration ? (value) { /* TODO: seeking */ } : null,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatDuration(position),
                                  style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 12)),
                              IconButton(
                                icon: const Icon(Icons.skip_previous, color: Colors.white),
                                iconSize: 40.0,
                                padding: EdgeInsets.zero,
                                tooltip: 'Previous',
                                onPressed: () => _guardedAction(playerNotifier.previous),
                              ),
                              const SizedBox(width: 8),
                              _buildPlayPauseButton(playerState, playerNotifier, size: 40.0),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.skip_next, color: Colors.white),
                                iconSize: 40.0,
                                padding: EdgeInsets.zero,
                                tooltip: 'Next',
                                onPressed: () => _guardedAction(playerNotifier.next),
                              ),
                              Text(_formatDuration(duration),
                                  style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        ),
      ],
    );
  }

  // ─── Mini overlay play/pause icon ────────────────────────────────────
  Widget _buildPlayPauseOverlay(PlayerState state, PlaybackNotifier notifier) {
    if (state.status == PlaybackStatus.loading || state.status == PlaybackStatus.buffering) {
      return const SizedBox(
        width: 28, height: 28,
        child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white),
      );
    }
    final isPlaying = state.status == PlaybackStatus.playing;
    return GestureDetector(
      onTap: () {
        if (isPlaying) {
          _guardedAction(notifier.pause);
        } else {
          _guardedAction(notifier.play);
        }
      },
      child: Icon(
        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        color: Colors.white,
        size: 34.0,
      ),
    );
  }

  // ─── Standard play/pause button ──────────────────────────────────────
  Widget _buildPlayPauseButton(PlayerState state, PlaybackNotifier notifier, {double size = 40.0}) {
    switch (state.status) {
      case PlaybackStatus.loading:
      case PlaybackStatus.buffering:
        return Container(
          key: const ValueKey('loading'),
          width: size, height: size,
          padding: const EdgeInsets.all(10.0),
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      case PlaybackStatus.playing:
        return IconButton(
          key: const ValueKey('pause'),
          icon: const Icon(Icons.pause_circle_filled_rounded, color: Colors.white),
          iconSize: size,
          padding: EdgeInsets.zero,
          tooltip: 'Pause',
          onPressed: () => _guardedAction(notifier.pause),
        );
      case PlaybackStatus.paused:
      case PlaybackStatus.completed:
      case PlaybackStatus.idle:
      case PlaybackStatus.error:
        return IconButton(
          key: const ValueKey('play'),
          icon: const Icon(Icons.play_circle_filled_rounded, color: Colors.white),
          iconSize: size,
          padding: EdgeInsets.zero,
          tooltip: 'Play',
          onPressed: () => _guardedAction(notifier.play),
        );
    }
  }
}