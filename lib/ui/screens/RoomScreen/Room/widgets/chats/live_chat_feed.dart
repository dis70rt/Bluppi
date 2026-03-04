import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/application/providers/room/live_chat_provider.dart';

class LiveChatFeed extends ConsumerWidget {
  final String roomId;
  const LiveChatFeed({required this.roomId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(liveChatProvider(roomId));

    return Expanded(
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(top: 20, bottom: 8, left: 16, right: 16),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[chats.length - 1 - index];

          if (chat.isSystem) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  chat.message,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Align(
              alignment: chat.isCurrentUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: chat.isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        chat.displayName ?? chat.username ?? 'Unknown',
                        style: TextStyle(
                          color: chat.isCurrentUser
                              ? Colors.blue[200]
                              : Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (chat.isHost) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: chat.isCurrentUser
                          ? Colors.blueAccent
                          : Colors.white24,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: chat.isCurrentUser
                            ? const Radius.circular(16)
                            : Radius.zero,
                        bottomRight: chat.isCurrentUser
                            ? Radius.zero
                            : const Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      chat.message,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
