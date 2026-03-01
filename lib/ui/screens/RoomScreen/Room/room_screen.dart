import 'package:bluppi/application/providers/party/sync_history_provider.dart';
import 'package:bluppi/application/providers/party/sync_provider.dart';
import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/listeners.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/live_chat_feed.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/room_header.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/track_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoomScreen extends ConsumerWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoom = ref.watch(currentRoomProvider);
    ref.read(clockDisciplineProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 80,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentRoom!.name.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ],
          ),
          centerTitle: true,
          leadingWidth: 85,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButton(
              onPressed: () {
                // TODO: Leave Room Implementation
                ref.invalidate(clockDisciplineProvider);
                ref.invalidate(clockHistoryProvider);
                ref.read(currentRoomProvider.notifier).leaveRoom();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Leave',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.push('/network-diagnostics'),
              icon: const Icon(Icons.info_outline, color: Colors.blueGrey),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoomHeader(
                roomCode: currentRoom.code,
                hostUserId: currentRoom.hostUserId,
              ),
              CurrentRoomTrack(isHost: true),
              RoomListeners(),
              LiveChatFeed(),
            ],
          ),
        ),
      ),
    );
  }
}
