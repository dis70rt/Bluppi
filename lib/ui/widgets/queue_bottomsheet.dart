import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/core/constants/colors.dart';

class QueueBottomSheet extends ConsumerWidget {
  const QueueBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueState = ref.watch(queueProvider);
    final queueNotifier = ref.read(queueProvider.notifier);

    const int maxPreviousToShow = 3;
    const int maxNextToShow = 10;

    final int startIndexPrevious =
        (queueState.currentIndex - maxPreviousToShow).clamp(0, queueState.items.length);
    final int endIndexPrevious =
        queueState.currentIndex.clamp(0, queueState.items.length);
    final List<QueueItem> previousItems =
        queueState.items.sublist(startIndexPrevious, endIndexPrevious);

    final QueueItem? currentItem = queueState.currentItem;

    final int startIndexNext =
        (queueState.currentIndex + 1).clamp(0, queueState.items.length);
    final int endIndexNext = (queueState.currentIndex + 1 + maxNextToShow)
        .clamp(0, queueState.items.length);
    final List<QueueItem> nextItems =
        queueState.items.sublist(startIndexNext, endIndexNext);

    final bool isVisualEndOfQueue = queueState.items.isNotEmpty &&
        queueState.currentIndex != -1 &&
        startIndexNext >= queueState.items.length;

    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: BluppiColors.surface.withAlpha((0.85 * 255).toInt()),
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
                    color: BluppiColors.divider.withAlpha((0.7 * 255).toInt()),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Queue (${queueState.items.length})',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: BluppiColors.textPrimary,
                      ),
                    ),
                    if (queueState.items.isNotEmpty)
                      Row(
                        children: [
                          IconButton(
                            onPressed: () =>
                                _showClearQueueDialog(context, queueNotifier),
                            icon: const Icon(
                              Icons.clear_all,
                              color: BluppiColors.textSecondary,
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
                color: BluppiColors.divider,
              ),
              if (queueState.items.isEmpty)
                const _EmptyQueueView()
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (previousItems.isNotEmpty) ...[
                          _SectionHeader(
                            title: 'Previous (${previousItems.length})',
                            color: BluppiColors.textSecondary,
                          ),
                          ...previousItems.asMap().entries.map((entry) {
                            final index = startIndexPrevious + entry.key;
                            final item = entry.value;
                            return _QueueTrackTile(
                              item: item,
                              index: index,
                              isCurrent: false,
                              queueNotifier: queueNotifier,
                            );
                          }),
                        ],
                        if (previousItems.isNotEmpty &&
                            (currentItem != null ||
                                nextItems.isNotEmpty ||
                                isVisualEndOfQueue))
                          const SizedBox(height: 12),
                        if (currentItem != null) ...[
                          const _SectionHeader(
                            title: 'Now Playing',
                            color: BluppiColors.accent,
                          ),
                          _QueueTrackTile(
                            item: currentItem,
                            index: queueState.currentIndex,
                            isCurrent: true,
                            queueNotifier: queueNotifier,
                          ),
                        ],
                        if (currentItem != null &&
                            (nextItems.isNotEmpty || isVisualEndOfQueue))
                          const SizedBox(height: 12),
                        if (nextItems.isNotEmpty) ...[
                          _SectionHeader(
                            title: 'Next in Queue (${nextItems.length})',
                            color: BluppiColors.textSecondary,
                          ),
                          ...nextItems.asMap().entries.map((entry) {
                            final index = startIndexNext + entry.key;
                            final item = entry.value;
                            return _QueueTrackTile(
                              item: item,
                              index: index,
                              isCurrent: false,
                              queueNotifier: queueNotifier,
                            );
                          }),
                        ],
                        if (isVisualEndOfQueue)
                          const _EndOfQueueView(),
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
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 16, top: 16, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(color: color),
      ),
    );
  }
}

class _QueueTrackTile extends StatelessWidget {
  final QueueItem item;
  final int index;
  final bool isCurrent;
  final QueueNotifier queueNotifier;

  const _QueueTrackTile({
    required this.item,
    required this.index,
    required this.isCurrent,
    required this.queueNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('queue_${item.track.id}_$index'),
      direction: isCurrent ? DismissDirection.none : DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: BluppiColors.error.withAlpha((0.8 * 255).toInt()),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ),
      confirmDismiss: isCurrent
          ? null
          : (direction) async {
              return await _showRemoveTrackDialog(context, item.track.title);
            },
      onDismissed: (direction) {
        queueNotifier.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed "${item.track.title}" from queue'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: ListTile(
        leading: item.track.imageLarge.isNotEmpty
            ? Image.network(item.track.imageLarge, width: 45, height: 45, fit: BoxFit.cover)
            : const Icon(Icons.music_note, size: 45),
        title: Text(
          item.track.title,
          style: TextStyle(
            color: isCurrent ? BluppiColors.accent : BluppiColors.textPrimary,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          item.track.artist,
          style: TextStyle(
            color: BluppiColors.textSecondary,
          ),
        ),
        trailing: isCurrent
            ? const Icon(Icons.play_arrow, color: BluppiColors.accent)
            : PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: BluppiColors.textSecondary, size: 16),
                iconSize: 16,
                padding: EdgeInsets.zero,
                onSelected: (value) => _handleTrackAction(
                  context,
                  value,
                  item,
                  index,
                  queueNotifier,
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
                        Icon(Icons.remove_circle_outline, size: 16, color: BluppiColors.error),
                        SizedBox(width: 8),
                        Text('Remove', style: TextStyle(color: BluppiColors.error)),
                      ],
                    ),
                  ),
                ],
              ),
        onTap: () {
          if (!isCurrent) {
            queueNotifier.jumpToIndex(index);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class _EmptyQueueView extends StatelessWidget {
  const _EmptyQueueView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music,
              size: 64,
              color: BluppiColors.textSecondary.withAlpha((0.5 * 255).toInt()),
            ),
            const SizedBox(height: 16),
            Text(
              'Queue is empty.',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: BluppiColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some tracks to get started!',
              style: theme.textTheme.bodySmall?.copyWith(
                color: BluppiColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EndOfQueueView extends StatelessWidget {
  const _EndOfQueueView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 20.0,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.playlist_play,
              color: BluppiColors.textSecondary.withAlpha((0.5 * 255).toInt()),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'End of queue.',
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: BluppiColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'More tracks will be recommended automatically.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: BluppiColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _handleTrackAction(
  BuildContext context,
  String action,
  QueueItem item,
  int index,
  QueueNotifier queueNotifier,
) {
  switch (action) {
    case 'play_next':
      queueNotifier.removeAt(index);
      queueNotifier.playNext(item.track);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Moved "${item.track.title}" to play next'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      break;
    case 'remove':
      queueNotifier.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed "${item.track.title}" from queue'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      break;
  }
}

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
          child: const Text('Clear', style: TextStyle(color: BluppiColors.error)),
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
          child: const Text('Remove', style: TextStyle(color: BluppiColors.error)),
        ),
      ],
    ),
  );

  return result ?? false;
}