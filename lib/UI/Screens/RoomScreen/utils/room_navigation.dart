import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Provider/RoomProvider/room_provider.dart';
import 'package:bluppi/UI/Screens/RoomScreen/listening_room.dart';
import 'package:bluppi/UI/Screens/RoomScreen/room_screen.dart';

class RoomNavigationContainer extends ConsumerWidget {
  const RoomNavigationContainer({
    super.key,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInRoom = ref.watch(roomProvider).isInRoom;
    ref.listen<RoomState>(roomProvider, (previous, current) {
      // This handles internal navigation when room state changes
      // No need to use context.go() anymore
    });
    
    return isInRoom ? const ListeningScreen() : const RoomScreen();
  }
}