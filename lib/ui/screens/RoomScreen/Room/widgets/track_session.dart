import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart'; 
import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/playback_control.dart';

class CurrentRoomTrack extends ConsumerStatefulWidget {
  final bool isHost;

  const CurrentRoomTrack({
    super.key,
    required this.isHost,
  });

  @override
  ConsumerState<CurrentRoomTrack> createState() => _CurrentRoomTrackState();
}

class _CurrentRoomTrackState extends ConsumerState<CurrentRoomTrack>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  
  // 1. Add a state variable to track if the card is expanded
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    // 10 seconds for a full 360-degree rotation (adjust as needed)
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTrack = ref.watch(queueProvider).currentTrack;
    final playerState = ref.watch(playerProvider);

    // Sync rotation with playback state
    if (playerState.status == PlaybackStatus.playing) {
      if (!_rotationController.isAnimating) {
        _rotationController.repeat();
      }
    } else {
      if (_rotationController.isAnimating) {
        _rotationController.stop();
      }
    }

    if (currentTrack == null) {
      return const _EmptyTrackState();
    }

    final imageUrl = currentTrack.imageLarge.isNotEmpty
        ? currentTrack.imageLarge
        : 'https://via.placeholder.com/400';

    // 2. Wrap the entire card in a GestureDetector
    return GestureDetector(
      onTap: () {
        // Toggle the expanded state on tap
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(120),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(30),
                  width: 1.0,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // Left Side: Rotating Circular Image
                      RotationTransition(
                        turns: _rotationController,
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(80),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(
                                color: Colors.white12,
                                child: const Icon(
                                  Icons.music_note,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Middle/Right: Title and Artist aligned left
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTrack.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              currentTrack.artist,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(179),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      
                      // Optional: A small chevron icon to indicate it's tappable
                      Icon(
                        _isExpanded 
                            ? Icons.keyboard_arrow_up_rounded 
                            : Icons.keyboard_arrow_down_rounded,
                        color: Colors.white54,
                      ),
                    ],
                  ),
                  
                  // 3. Wrap the Playback Controls in an AnimatedSize widget
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: _isExpanded
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 16),
                              RoomPlaybackControls(isHost: widget.isHost),
                            ],
                          )
                        : const SizedBox(
                            width: double.infinity, 
                            height: 0,
                          ), // Shrinks to 0 height when collapsed
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyTrackState extends StatelessWidget {
  const _EmptyTrackState();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withAlpha(20),
              width: 1.0,
            ),
          ),
          child: const Center(
            child: Text(
              "No track playing",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}