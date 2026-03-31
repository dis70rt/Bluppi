import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/core/utils/date_format.dart';
import 'package:bluppi/domain/models/activity_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class ActivityBottomSheet extends ConsumerStatefulWidget {
  final ActivityModel activity;

  const ActivityBottomSheet({super.key, required this.activity});

  @override
  ConsumerState<ActivityBottomSheet> createState() =>
      _ActivityBottomSheetState();
}

class _ActivityBottomSheetState extends ConsumerState<ActivityBottomSheet> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAndPlayPreview();
  }

  Future<void> _initAndPlayPreview() async {
    if (widget.activity.previewUrl != null &&
        widget.activity.previewUrl!.isNotEmpty) {
      try {
        await _audioPlayer.setUrl(widget.activity.previewUrl!);
        _audioPlayer.play();

        _audioPlayer.playerStateStream.listen((state) {
          if (mounted) {
            setState(() {
              _isPlaying = state.playing;
            });
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Container(
          color: BluppiColors.surface,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 14),
                    height: 5,
                    width: 48,
                    decoration: BoxDecoration(
                      color: BluppiColors.divider.withAlpha(150),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.activity.friendName,
                        style: const TextStyle(
                          color: BluppiColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: -0.3,
                        ),
                      ),
                      if (widget.activity.lastSeen != null) ...[
                        const Text(
                          ' · ',
                          style: TextStyle(color: BluppiColors.textSecondary),
                        ),
                        Text(
                          formatTimeAgo(widget.activity.lastSeen),
                          style: const TextStyle(
                            color: BluppiColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(40),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () => {
                                context.pop(),
                                context.push('/u/${widget.activity.friendUsername}')
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: BluppiColors.surfaceRaised,
                                backgroundImage: CachedNetworkImageProvider(
                                  widget.activity.friendAvatarUrl,
                                ),
                              ),
                            ),
                          ),
                          if (widget.activity.status == 'online')
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: BluppiColors.surface,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      if (widget.activity.trackTitle != null)
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: BluppiColors.surfaceRaised,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                                bottomLeft: Radius.circular(8),
                              ),
                              border: Border.all(
                                color: BluppiColors.divider.withAlpha(120),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(30),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.activity.trackCoverUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: widget.activity.trackCoverUrl!,
                                          width: 48,
                                          height: 48,
                                          fit: BoxFit.cover,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (_isPlaying) {
                                              _audioPlayer.pause();
                                            } else {
                                              _audioPlayer.play();
                                            }
                                          },
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withAlpha(100),
                                            ),
                                            child: AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              child: Icon(
                                                _isPlaying
                                                    ? Icons.pause_rounded
                                                    : Icons.play_arrow_rounded,
                                                key: ValueKey<bool>(_isPlaying),
                                                color: Colors.white,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  GestureDetector(
                                    onTap: () {
                                      if (_isPlaying) {
                                        _audioPlayer.pause();
                                      } else {
                                        _audioPlayer.play();
                                      }
                                    },
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: Icon(
                                        _isPlaying
                                            ? Icons.stop_circle_rounded
                                            : Icons.play_circle_fill_rounded,
                                        key: ValueKey<bool>(_isPlaying),
                                        color: BluppiColors.primary,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.activity.trackTitle!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: BluppiColors.textPrimary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            letterSpacing: -0.2,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          widget.activity.trackArtist ??
                                              'Unknown',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: BluppiColors.textSecondary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}