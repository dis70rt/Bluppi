import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Provider/ChatProvider/conversation_provider.dart';
import 'package:synqit/Utils/snackbar.dart';

class MessageButton extends ConsumerStatefulWidget {
  final UserModel otherUser;

  const MessageButton({super.key, required this.otherUser});

  @override
  ConsumerState<MessageButton> createState() => _MessageButtonState();
}

class _MessageButtonState extends ConsumerState<MessageButton> {
  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Container(
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: IconButton(
          onPressed: () => _onpressed(currentUserId),
          icon: const Icon(Icons.message, size: 16, color: Colors.white)),
    );
  }

  void _onpressed(String currentUserId) async {
    if (currentUserId.isEmpty) return;

    final conversationId =
        await ref.read(conversationProvider.notifier).getOrCreateConversation(
      participants: [currentUserId, widget.otherUser.id],
      conversationName: widget.otherUser.name,
      isGroup: false,
    );

    if (!mounted) return;

    if (conversationId != null) {
      context.pushNamed(
        'chat',
        pathParameters: {'conversationId': conversationId},
        extra: widget.otherUser,
      );
    } else {
      showSnackBar(
          context: context,
          message: 'Failed to create conversation',
          icon: const Icon(Icons.voice_over_off_rounded));
    }
  }
}
