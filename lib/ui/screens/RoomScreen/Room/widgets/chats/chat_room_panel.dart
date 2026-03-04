import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/chats/live_chat_feed.dart';
import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/chats/live_chat_input.dart';
import 'package:flutter/material.dart';

class RoomChatPanel extends StatelessWidget {
  final String roomId;
  const RoomChatPanel({required this.roomId, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LiveChatFeed(roomId: roomId),
        LiveChatInput(roomId: roomId),
      ],
    );
  }
}