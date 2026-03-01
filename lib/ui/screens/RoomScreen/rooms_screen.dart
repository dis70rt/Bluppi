import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/create_room_sheet.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomMainScreen extends ConsumerWidget {
  const RoomMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoom = ref.watch(currentRoomProvider);
    if (currentRoom != null) {
      return RoomScreen();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Rooms'), actions: [
          MaterialButton(onPressed: () => CreateRoomBottomSheet.show(context), child: const Text('Create Room'))
        ],),
        body: Center(child: Text('Create Room')),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => ,
        //   backgroundColor: theme.colorScheme.secondary,
        //   child: const Icon(Icons.add, color: Colors.white),
        // ),
      ),
    );
  }
}
