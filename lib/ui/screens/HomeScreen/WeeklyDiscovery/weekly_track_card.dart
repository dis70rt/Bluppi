import 'package:bluppi/application/controllers/playback_controller.dart';
  import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/track_summary_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyTrackCard extends ConsumerWidget {
  final TrackSummaryModel track;

  const WeeklyTrackCard({super.key, required this.track});

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    final currentQueueItem = ref.watch(queueProvider).currentItem;
    final isCurrentTrack = currentQueueItem?.track.id == track.id;

    return GestureDetector(
      onTap: () {
        ref.read(trackActionControllerProvider.notifier).playOrToggleTrack(
            trackId: track.id,
            isCurrentTrack: isCurrentTrack,
            onError: (errorMessage) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMessage)),
              );
            },
          );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 100,
        decoration: BoxDecoration(
          color: BluppiColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: BluppiColors.divider.withAlpha(255),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 180,
                child: Opacity(
                  opacity: 0.3,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: CachedNetworkImage(
                      imageUrl: track.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: track.imageUrl,
                        width: 76,
                        height: 76,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            track.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: BluppiColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            track.artist,
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
