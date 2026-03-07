import 'package:bluppi/application/providers/room/room_listeners_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/listeners/listeners_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomListeners extends ConsumerWidget {
  final String roomId;
  const RoomListeners({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listenerState = ref.watch(roomEventsProvider(roomId));
    final int count = listenerState.totalMembers;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => RoomListenersBottomSheet.show(context, roomId: roomId),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.headset, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                '$count ${count == 1 ? 'Listener' : 'Listeners'}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
