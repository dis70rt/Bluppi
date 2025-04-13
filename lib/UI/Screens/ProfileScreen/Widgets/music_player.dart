import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:synqit/Data/Models/last_track_model.dart';

class MiniMusicPlayer extends StatelessWidget {
  final LastTrack track;

  const MiniMusicPlayer({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background image or placeholder
            Positioned.fill(
              child: track.imageUrl != null && track.imageUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: track.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(color: Colors.grey.shade900),
            ),
            // Blur effect over the background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: track.imageUrl != null && track.imageUrl!.isNotEmpty
                      ? Colors.black.withOpacity(0.5)
                      : Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            // Content
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Track details (album art, track name, artist)
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: Colors.grey.shade900,
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: track.imageUrl ?? '',
                            errorWidget: (_, __, ___) =>
                                const Icon(Icons.music_note),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            track.artist.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Circular progress with play/pause button (default is pause)
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular progress indicator
                        const CircularProgressIndicator(
                          // Set your progress value here if available; using 0.0 for example.
                          value: 0.0,
                          strokeWidth: 2,
                          backgroundColor: Colors.white38,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        // Play/Pause button (default to pause)
                        IconButton(
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Handle play/pause toggling here
                          },
                        ),
                      ],
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
