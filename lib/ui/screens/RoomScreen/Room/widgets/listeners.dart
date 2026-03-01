import 'package:bluppi/application/providers/room/room_listeners_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomListeners extends ConsumerWidget {
  const RoomListeners({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listenerIds = ref.watch(roomListenersProvider);
    final int count = listenerIds.length;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
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
    );
  }
}
