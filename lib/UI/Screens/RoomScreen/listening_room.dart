import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Provider/RoomProvider/room_service_provider.dart';
import 'package:bluppi/UI/Screens/HomeScreen/Widgets/floating_music_player.dart';

class ListeningScreen extends ConsumerWidget {
  const ListeningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomState = ref.watch(roomProvider);
    final room = roomState.currentRoom!;

    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
        centerTitle: true,
        actions: [
          TextButton(
            child: const Text(
              "Leave",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            onPressed: () {
              ref.read(roomProvider.notifier).leaveRoom();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FloatingMusicPlayer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [               
                Text(
                  room.description.isNotEmpty ? room.description : 'No description provided for this room.',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      room.inviteOnly ? Icons.lock_outline : Icons.public,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      room.inviteOnly ? 'Invite Only' : 'Public Room',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Host: ${room.members[0].userId.substring(0, 6)}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.headset_mic_outlined, color: AppColors.accent, size: 20),
                      const SizedBox(width: 8),
                      Text("${roomState.memberCount} Listening", style: TextStyle(color: Colors.grey[300], fontSize: 14)),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 28,
                        width: 64.0, 
                        child: Stack(
                          children: List.generate(3, (index) {
                            return Positioned(
                              left: index * 18.0,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.primary.withAlpha(100 + index * 50),
                                child: Icon(Icons.person, size: 16, color: Colors.white.withValues(alpha: 0.8)),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.person_add_alt_1, size: 18),
                    label: const Text("Invite"),
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.waves,
                      size: 60,
                      color: AppColors.accent.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enjoy the vibe!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border(top: BorderSide(color: Colors.grey[700]!))
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Live chat placeholder...",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.accent),
                  onPressed: () {
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}