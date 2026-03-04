import 'package:bluppi/domain/models/room_events_model.dart';

enum ChatMessageType { user, system }

class LiveChatBubble {
  final ChatMessageType type;
  final String? userId;
  final String? username;
  final String? displayName;
  final String? avatarUrl;
  final String message;
  
  final bool isHost;
  final bool isCurrentUser;

  LiveChatBubble({
    required this.type,
    this.userId,
    this.username,
    this.displayName,
    this.avatarUrl,
    required this.message,
    this.isHost = false,
    this.isCurrentUser = false,
  });

  // UI Helpers
  bool get isSystem => type == ChatMessageType.system;
  bool get isCurrentUserHost => isCurrentUser && isHost;
  bool get isOtherHost => !isCurrentUser && isHost;
  bool get isCurrentUserListener => isCurrentUser && !isHost;
  bool get isOtherListener => !isCurrentUser && !isHost;

  factory LiveChatBubble.system(String text) {
    return LiveChatBubble(
      type: ChatMessageType.system,
      message: text,
    );
  }

  factory LiveChatBubble.user({
    required LiveChatMessageModel msg,
    required JoinedMemberModel profile,
    required bool isHost,
    required bool isCurrentUser,
  }) {
    return LiveChatBubble(
      type: ChatMessageType.user,
      userId: msg.userId,
      message: msg.text,
      username: profile.username,
      displayName: profile.displayName,
      avatarUrl: profile.avatarUrl,
      isHost: isHost,
      isCurrentUser: isCurrentUser,
    );
  }
}