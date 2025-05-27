import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Provider/chat_provider/socket_provider.dart';
import 'package:synqit/UI/Screens/ChatScreen/chatting_screen.dart';

class MessageButton extends ConsumerWidget {
  final UserModel otherUser;

  const MessageButton({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    // final chatState = ref.watch(socketProvider);

    return GestureDetector(
      onTap: () async {
        if (currentUserId.isEmpty) return;

        final navigator = Navigator.of(context);
        final messenger = ScaffoldMessenger.of(context);

        final conversationId = await _getOrCreateConversation(
            ref, currentUserId, otherUser.id, otherUser.username);

        log("Conversation ID: $conversationId");

        if (conversationId != null) {
          navigator.push(
            MaterialPageRoute(
              builder: (context) => ChattingScreen(
                conversationId: conversationId,
                user: otherUser,
              ),
            ),
          );
        } else {
          messenger.showSnackBar(
              const SnackBar(content: Text('Failed to create conversation')));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.message, size: 16, color: Colors.white),
            // SizedBox(width: 8),
            // Text(
            //   'Message',
            //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            // ),
          ],
        ),
      ),
    );
  }

  Future<String?> _getOrCreateConversation(WidgetRef ref, String currentUserId,
      String otherId, String otherName) async {
    final socketNotifier = ref.read(socketProvider.notifier);
    final conversations = ref.read(socketProvider).conversations;

    for (final conversation in conversations) {
      final participants = conversation.participants;
      if (participants.length == 2 &&
          participants.contains(currentUserId) &&
          participants.contains(otherId)) {
        return conversation.conversationId;
      }
    }

    final conversationId =
        await socketNotifier.checkConversationExists([currentUserId, otherId]);
    if (conversationId != null) {
      return conversationId;
    }

    try {
      final newConversation = await socketNotifier.createConversation(
        participants: [currentUserId, otherId],
        conversationName: otherName,
        isGroup: false,
      );
      return newConversation?.conversationId;
    } catch (e) {
      log('Error creating conversation: $e');
      return null;
    }
  }
}
