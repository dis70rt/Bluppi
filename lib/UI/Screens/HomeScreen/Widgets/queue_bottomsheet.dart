import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/music_provider/queue_provider.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/glassmorphic_track_tile.dart';

Widget queueBottomSheet() {
  return Consumer(
    builder: (context, ref, child) {
      final queueState = ref.watch(queueProvider);
      final queueNotifier = ref.read(queueProvider.notifier);

      final theme = Theme.of(context);

      const int maxPreviousToShow = 1;
      const int maxNextToShow = 3;

      final int startIndexPrevious =
          (queueState.currentIndex - maxPreviousToShow)
              .clamp(0, queueState.items.length);
      final int endIndexPrevious =
          queueState.currentIndex.clamp(0, queueState.items.length);
      final List<Track> previousItems =
          queueState.items.sublist(startIndexPrevious, endIndexPrevious);

      final Track? currentItem = queueState.current;

      final int startIndexNext =
          (queueState.currentIndex + 1).clamp(0, queueState.items.length);
      final int endIndexNext = (queueState.currentIndex + 1 + maxNextToShow)
          .clamp(0, queueState.items.length);
      final List<Track> nextItems =
          queueState.items.sublist(startIndexNext, endIndexNext);

      final bool isVisualEndOfQueue = queueState.items.isNotEmpty &&
          queueState.currentIndex != -1 &&
          startIndexNext >= queueState.items.length;

      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          color: AppColors.darkSurfaceBlack.withValues(alpha: 0.85),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 14),
                    height: 5,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColors.divider.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  child: Center(
                    child: Text(
                      'Queue',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: AppColors.textPrimaryStandard,
                      ),
                    ),
                  ),
                ),
                const Divider(
                    height: 1,
                    thickness: 0.8,
                    indent: 24,
                    endIndent: 24,
                    color: AppColors.divider),
                if (queueState.items.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                        'Queue is empty.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: AppColors.textHint),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (previousItems.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24.0, right: 16, top: 16, bottom: 8),
                              child: Text('Previous',
                                  style: theme.textTheme.labelLarge?.copyWith(
                                      color: AppColors.textSecondary)),
                            ),
                            ...previousItems
                                .map((track) => GrassmorphicTrackTile(
                                      track: track,
                                      onTap: () {
                                        queueNotifier.playTrack(track);
                                      },
                                      isCurrent: false,
                                    )),
                          ],
                          if (previousItems.isNotEmpty &&
                              (currentItem != null ||
                                  nextItems.isNotEmpty ||
                                  isVisualEndOfQueue))
                            const SizedBox(height: 12),
                          if (currentItem != null) ...[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24.0, right: 16, top: 8, bottom: 8),
                              child: Text('Now Playing',
                                  style: theme.textTheme.labelLarge
                                      ?.copyWith(color: AppColors.accent)),
                            ),
                            GrassmorphicTrackTile(
                              track: currentItem,
                              onTap: () {
                                queueNotifier.playTrack(currentItem);
                              },
                              isCurrent: true,
                            ),
                          ],
                          if (currentItem != null &&
                              (nextItems.isNotEmpty || isVisualEndOfQueue))
                            const SizedBox(height: 12),
                          if (nextItems.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24.0, right: 16, top: 8, bottom: 8),
                              child: Text('Next in Queue',
                                  style: theme.textTheme.labelLarge?.copyWith(
                                      color: AppColors.textSecondary)),
                            ),
                            ...nextItems.map((track) => GrassmorphicTrackTile(
                                  track: track,
                                  onTap: () {
                                    queueNotifier.playTrack(track);
                                  },
                                  isCurrent: false,
                                )),
                          ],
                          if (isVisualEndOfQueue)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 20.0),
                              child: Center(
                                child: Text(
                                  'End of queue.',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.textHint),
                                ),
                              ),
                            ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
