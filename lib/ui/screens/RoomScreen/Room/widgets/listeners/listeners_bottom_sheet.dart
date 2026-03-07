import 'dart:ui';
import 'package:bluppi/application/providers/room/room_listeners_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/room_events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomListenersBottomSheet extends ConsumerWidget {
  final String roomId;

  const RoomListenersBottomSheet({super.key, required this.roomId});

  static Future<void> show(BuildContext context, {required String roomId}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,      
      backgroundColor: Colors.transparent,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.65,
        child: RoomListenersBottomSheet(roomId: roomId),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final roomState = ref.watch(roomEventsProvider(roomId));
    final listeners = roomState.joinedMembers;

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Listeners (${roomState.totalMembers})',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: BluppiColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: BluppiColors.textSecondary,
                        size: 24,
                      ),
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ),

              const Divider(
                height: 16,
                thickness: 0.8,
                indent: 24,
                endIndent: 24,
                color: BluppiColors.divider,
              ),

              Expanded(
                child: listeners.isEmpty
                    ? const _EmptyListenersView()
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount: listeners.length,
                        itemBuilder: (context, index) {
                          final member = listeners[index];
                          return _ListenerTile(member: member);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListenerTile extends StatelessWidget {
  final JoinedMemberModel member;

  const _ListenerTile({required this.member});

  @override
  Widget build(BuildContext context) {
    final String displayName = member.displayName;
    final String initial = displayName.isNotEmpty
        ? displayName.substring(0, 1).toUpperCase()
        : '?';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 4.0,
      ),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: BluppiColors.divider,

        child: /* member.profileImageUrl == null ? */ Text(
          initial,
          style: const TextStyle(
            color: BluppiColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ) /* : null */,
      ),
      title: Text(
        displayName,
        style: const TextStyle(
          color: BluppiColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        'Listening',
        style: TextStyle(
          color: BluppiColors.accent.withAlpha((0.8 * 255).toInt()),
          fontSize: 12,
        ),
      ),
      trailing: const Icon(
        Icons.headphones_rounded,
        color: BluppiColors.textSecondary,
        size: 20,
      ),
    );
  }
}

class _EmptyListenersView extends StatelessWidget {
  const _EmptyListenersView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.headset_off_rounded,
            size: 64,
            color: BluppiColors.textSecondary.withAlpha((0.5 * 255).toInt()),
          ),
          const SizedBox(height: 16),
          Text(
            'No listeners yet.',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: BluppiColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Invite friends to join the room!',
            style: theme.textTheme.bodySmall?.copyWith(
              color: BluppiColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
