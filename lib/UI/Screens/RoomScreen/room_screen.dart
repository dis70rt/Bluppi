import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Provider/RoomProvider/room_provider.dart';
import 'package:bluppi/UI/Screens/RoomScreen/Widgets/create_room_widget.dart';
import 'package:bluppi/UI/Screens/RoomScreen/Widgets/join_room_widget.dart';

class RoomScreen extends ConsumerWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final roomState = ref.watch(roomProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (roomState.isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            // Top buttons section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CreateRoomWidget(),
                  const SizedBox(height: 16),
                  JoinRoomWidget()
                ],
              ),
            ),

            // Error message
            if (roomState.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: Colors.red.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${roomState.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            size: 16, color: Colors.red),
                        onPressed: () =>
                            ref.read(roomProvider.notifier).clearError(),
                      )
                    ],
                  ),
                ),
              ),

            // Available rooms section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Public Rooms',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.grey),
                    onPressed: () =>
                        ref.read(roomProvider.notifier).fetchAvailableRooms(),
                  ),
                ],
              ),
            ),

            // Rooms list
            Expanded(
              child: roomState.availableRooms.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.music_note,
                              size: 48, color: Colors.grey[600]),
                          const SizedBox(height: 10),
                          Text(
                            'No public rooms available',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Create a room or join with a room code',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: roomState.availableRooms.length,
                      itemBuilder: (context, index) {
                        final room = roomState.availableRooms[index];
                        final isHost = room.hostUserId == userId;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: CircleAvatar(
                              backgroundColor:
                                  isHost ? AppColors.accent : Colors.grey[800],
                              child: Icon(
                                room.inviteOnly ? Icons.lock : Icons.headset,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    room.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (isHost)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'HOST',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Text(
                              room.description.isNotEmpty
                                  ? room.description
                                  : 'No description',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                await ref.read(roomProvider.notifier).joinRoom(
                                      room.id,
                                      userId,
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Join'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
