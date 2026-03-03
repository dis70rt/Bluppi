import 'dart:developer';

import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/room/search_room_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/create_room_sheet.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/room_screen.dart';
import 'package:bluppi/ui/screens/RoomScreen/room_tile.dart';
import 'package:bluppi/domain/models/room_summary_model.dart';
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
    final displayRooms = isInitialLoading 
        ? List.generate(6, (index) => _getDummyRoom()) 
        : roomsState.rooms;

    // 3. Construct the body based on the state
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
    } else if (!isInitialLoading && displayRooms.isEmpty) {
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
              log('Triggering next page fetch...');
              roomsNotifier.fetchNextPage();
            }
            return false;
          },
          child: Skeletonizer(
            enabled: isInitialLoading,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: displayRooms.length + (roomsState.nextPageToken.isNotEmpty && !isInitialLoading ? 1 : 0),
              itemBuilder: (context, index) {
                // Bottom loading spinner
                if (index == displayRooms.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                // Room Tile
                return RoomTile(
                  room: displayRooms[index],
                  onTap: () {
                    if (isInitialLoading) return; // Prevent tapping dummy skeleton tiles
                    // TODO: Implement your join logic here
                    ref.read(currentRoomProvider.notifier).joinRoom(displayRooms[index].id);
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

  // Helper to generate a dummy room for Skeletonizer to draw over
  RoomSummaryModel _getDummyRoom() {
    return RoomSummaryModel(
      id: 'dummy_id',
      name: 'Loading Room Name...',
      hostUserId: 'dummy_host',
      hostUsername: 'Loading Host...',
      trackId: '',
      trackTitle: 'Loading Track Title...',
      trackArtist: 'Loading Artist...',
      artworkUrl: '', 
      listenerCount: 0,
      isLive: true,
      isPublic: true,
    );
  }
}