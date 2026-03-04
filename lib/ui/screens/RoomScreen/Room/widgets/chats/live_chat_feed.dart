import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/chats/chat_bubbles.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[chats.length - 1 - index];

          if (chat.isSystem) {
            return SystemMessageBubble(message: chat.message);
          }

          if (chat.isCurrentUser) {
            return CurrentUserMessageBubble(message: chat.message);
          }

          return OtherUserMessageBubble(chat: chat);
        },
      ),
    );
  }
}
