import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/room/search_room_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/create_room_sheet.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/room_screen.dart';
import 'package:bluppi/ui/screens/RoomScreen/room_tile.dart';
import 'package:bluppi/ui/screens/RoomScreen/room_tile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoomMainScreen extends ConsumerWidget {
  const RoomMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoom = ref.watch(currentRoomProvider);
    final roomsState = ref.watch(listRoomsProvider);
    final roomsNotifier = ref.read(listRoomsProvider.notifier);

    // 1. Route to active room if already inside one
    if (currentRoom != null) {
      return const RoomScreen();
    }

    // 2. Determine loading state and data payload
    final isInitialLoading = roomsState.isLoading && roomsState.rooms.isEmpty;

    Widget body;

    if (roomsState.errorMessage != null && roomsState.rooms.isEmpty) {
      // STATE: Error
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${roomsState.errorMessage}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: roomsNotifier.refresh,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (!isInitialLoading && roomsState.rooms.isEmpty) {
      // STATE: Empty
      body = RefreshIndicator(
        onRefresh: roomsNotifier.refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 150),
            Center(
              child: Text(
                "No active rooms right now.\nBe the first to create one!",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else {
      // STATE: Populated / Skeleton Loading
      body = RefreshIndicator(
        onRefresh: roomsNotifier.refresh,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            final isNearBottom = scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200;
            if (!roomsState.isLoading && roomsState.nextPageToken.isNotEmpty && isNearBottom) {
              roomsNotifier.fetchNextPage();
            }
            return false;
          },
          child: Skeletonizer(
            enabled: isInitialLoading,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: isInitialLoading
                ? 6
                : roomsState.rooms.length + (roomsState.nextPageToken.isNotEmpty && !isInitialLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (isInitialLoading) {
                  return const RoomTileSkeleton();
                }
                
                // Bottom loading spinner
                if (index == roomsState.rooms.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                // Room Tile
                return RoomTile(
                  room: roomsState.rooms[index],
                  onTap: () {
                    if (isInitialLoading) return; // Prevent tapping dummy skeleton tiles
                    // TODO: Implement your join logic here
                    ref.read(currentRoomProvider.notifier).joinRoom(roomsState.rooms[index].id);
                  },
                );
              },
            ),
          ),
        ),
      );
    }

    // 4. Return the complete UI
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rooms'),
          actions: [
            MaterialButton(
              onPressed: () => CreateRoomBottomSheet.show(context),
              child: const Text('Create Room'),
            )
          ],
        ),
        body: body,
      ),
    );
  }  
}