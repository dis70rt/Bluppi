import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/MusicProvider/queue_provider.dart';
import 'package:synqit/Provider/MusicProvider/queue_manager_provider.dart';
import 'package:synqit/Provider/MusicProvider/music_player_provider.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/glassmorphic_track_tile.dart';

Widget queueBottomSheet() {
  return Consumer(
    builder: (context, ref, child) {
      final queueState = ref.watch(queueProvider);
      final queueNotifier = ref.read(queueProvider.notifier);
      final queueActions = ref.read(queueActionsProvider);
      final playerNotifier = ref.read(musicPlayerProvider.notifier);

      final theme = Theme.of(context);

      const int maxPreviousToShow = 3;
      const int maxNextToShow = 10;

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Queue (${queueState.items.length})',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppColors.textPrimaryStandard,
                        ),
                      ),
                      if (queueState.items.isNotEmpty)
                        Row(
                          children: [
                            // IconButton(
                            //   onPressed: () =>
                            //       _shuffleQueue(queueState, queueNotifier),
                            //   icon: const Icon(
                            //     Icons.shuffle,
                            //     color: AppColors.textSecondary,
                            //     size: 20,
                            //   ),
                            //   tooltip: 'Shuffle Queue',
                            // ),
                            IconButton(
                              onPressed: () =>
                                  _showClearQueueDialog(context, queueNotifier),
                              icon: const Icon(
                                Icons.clear_all,
                                color: AppColors.textSecondary,
                                size: 20,
                              ),
                              tooltip: 'Clear Queue',
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 0.8,
                  indent: 24,
                  endIndent: 24,
                  color: AppColors.divider,
                ),
                if (queueState.items.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.queue_music,
                            size: 64,
                            color: AppColors.textHint.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Queue is empty.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.textHint,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add some tracks to get started!',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
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
                            _buildSectionHeader(
                              theme,
                              'Previous (${previousItems.length})',
                              AppColors.textSecondary,
                            ),
                            ...previousItems.asMap().entries.map((entry) {
                              final index = startIndexPrevious + entry.key;
                              final track = entry.value;
                              return _buildQueueTrackTile(
                                track: track,
                                index: index,
                                isCurrent: false,
                                isPrevious: true,
                                queueState: queueState,
                                playerNotifier: playerNotifier,
                                queueActions: queueActions,
                                context: context,
                              );
                            }),
                          ],
                          if (previousItems.isNotEmpty &&
                              (currentItem != null ||
                                  nextItems.isNotEmpty ||
                                  isVisualEndOfQueue))
                            const SizedBox(height: 12),
                          if (currentItem != null) ...[
                            _buildSectionHeader(
                              theme,
                              'Now Playing',
                              AppColors.accent,
                            ),
                            _buildQueueTrackTile(
                              track: currentItem,
                              index: queueState.currentIndex,
                              isCurrent: true,
                              isPrevious: false,
                              queueState: queueState,
                              playerNotifier: playerNotifier,
                              queueActions: queueActions,
                              context: context,
                            ),
                          ],
                          if (currentItem != null &&
                              (nextItems.isNotEmpty || isVisualEndOfQueue))
                            const SizedBox(height: 12),
                          if (nextItems.isNotEmpty) ...[
                            _buildSectionHeader(
                              theme,
                              'Next in Queue (${nextItems.length})',
                              AppColors.textSecondary,
                              showRecommendationCount: true,
                              recommendationCount: nextItems.where((track) {
                                final index =
                                    startIndexNext + nextItems.indexOf(track);
                                return queueState.autoRecommendedIndices
                                    .contains(index);
                              }).length,
                            ),
                            ...nextItems.asMap().entries.map((entry) {
                              final index = startIndexNext + entry.key;
                              final track = entry.value;
                              return _buildQueueTrackTile(
                                track: track,
                                index: index,
                                isCurrent: false,
                                isPrevious: false,
                                queueState: queueState,
                                playerNotifier: playerNotifier,
                                queueActions: queueActions,
                                context: context,
                              );
                            }),
                          ],
                          if (isVisualEndOfQueue)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 20.0,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.playlist_play,
                                      color: AppColors.textHint
                                          .withValues(alpha: 0.5),
                                      size: 32,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'End of queue.',
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        fontStyle: FontStyle.italic,
                                        color: AppColors.textHint,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'More tracks will be recommended automatically.',
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: AppColors.textHint,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
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

Widget _buildSectionHeader(
  ThemeData theme,
  String title,
  Color color, {
  bool showRecommendationCount = false,
  int recommendationCount = 0,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 24.0, right: 16, top: 16, bottom: 8),
    child: Row(
      children: [
        Text(
          title,
          style: theme.textTheme.labelLarge?.copyWith(color: color),
        ),
        if (showRecommendationCount && recommendationCount > 0) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              '$recommendationCount auto',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.accent,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _buildQueueTrackTile({
  required Track track,
  required int index,
  required bool isCurrent,
  required bool isPrevious,
  required QueueState queueState,
  required MusicPlayerNotifier playerNotifier,
  required QueueActions queueActions,
  required BuildContext context,
}) {
  final isRecommended = queueState.autoRecommendedIndices.contains(index);

  return Dismissible(
    key: Key('queue_${track.trackId}_$index'),
    direction: isCurrent ? DismissDirection.none : DismissDirection.endToStart,
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: Colors.red.withValues(alpha: 0.8),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 24,
      ),
    ),
    confirmDismiss: isCurrent
        ? null
        : (direction) async {
            return await _showRemoveTrackDialog(context, track.trackName);
          },
    onDismissed: (direction) {
      queueActions.removeTrack(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed "${track.trackName}" from queue'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    },
    child: GrassmorphicTrackTile(
      track: track,
      onTap: () {
        if (!isCurrent) {
          playerNotifier.playTrackAtIndex(index);
          Navigator.of(context).pop();
        }
      },
      isCurrent: isCurrent,
      trailing: _buildTrackActions(
        context: context,
        track: track,
        index: index,
        isCurrent: isCurrent,
        isRecommended: isRecommended,
        queueActions: queueActions,
      ),
    ),
  );
}

Widget _buildTrackActions({
  required BuildContext context,
  required Track track,
  required int index,
  required bool isCurrent,
  required bool isRecommended,
  required QueueActions queueActions,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (isRecommended)
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.auto_fix_high,
            size: 12,
            color: AppColors.accent,
          ),
        ),
      if (isCurrent)
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: const Icon(
            Icons.play_arrow,
            color: AppColors.accent,
            size: 16,
          ),
        ),
      if (!isCurrent)
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.textSecondary,
            size: 16,
          ),
          iconSize: 16,
          padding: EdgeInsets.zero,
          onSelected: (value) => _handleTrackAction(
            context,
            value,
            track,
            index,
            queueActions,
          ),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'play_next',
              child: Row(
                children: [
                  Icon(Icons.skip_next, size: 16),
                  SizedBox(width: 8),
                  Text('Play Next'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'remove',
              child: Row(
                children: [
                  Icon(Icons.remove_circle_outline,
                      size: 16, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Remove', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
    ],
  );
}

void _handleTrackAction(
  BuildContext context,
  String action,
  Track track,
  int index,
  QueueActions queueActions,
) {
  switch (action) {
    case 'play_next':
      queueActions.removeTrack(index);
      queueActions.addTrackNext(track);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Moved "${track.trackName}" to play next'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      break;
    case 'remove':
      queueActions.removeTrack(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed "${track.trackName}" from queue'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      break;
  }
}

// void _shuffleQueue(QueueState queueState, QueueNotifier queueNotifier) {
//   if (queueState.items.length <= 1) return;

//   final currentIndex = queueState.currentIndex;
//   if (currentIndex == -1 || currentIndex >= queueState.items.length - 1) return;

//   final tracksToShuffle = queueState.items.sublist(currentIndex + 1);
//   tracksToShuffle.shuffle();

//   final newItems = [
//     ...queueState.items.sublist(0, currentIndex + 1),
//     ...tracksToShuffle,
//   ];

//   queueNotifier.clear();
//   for (int i = 0; i < newItems.length; i++) {
//     queueNotifier.add(newItems[i]);
//   }
//   queueNotifier.syncIndex(currentIndex);
// }

Future<void> _showClearQueueDialog(
  BuildContext context,
  QueueNotifier queueNotifier,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Clear Queue'),
      content: const Text('Are you sure you want to clear the entire queue?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Clear', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  if (result == true) {
    queueNotifier.clear();
  }
}

Future<bool> _showRemoveTrackDialog(
  BuildContext context,
  String trackName,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Remove Track'),
      content: Text('Remove "$trackName" from queue?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Remove', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  return result ?? false;
}
