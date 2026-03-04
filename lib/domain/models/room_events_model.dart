import 'package:bluppi/generated/rooms.pb.dart' as proto;

enum RoomEventType {
  userJoined,
  userLeft,
  roomEnded,
  liveChatMessage,
  unknown,
}

class RoomEventModel {
  final RoomEventType type;
  final String roomId;
  final JoinedMemberModel? joinedMember;
  final LeftMemberModel? leftMember;
  final LiveChatMessageModel? liveChatMessage;

  RoomEventModel({
    required this.type,
    required this.roomId,
    this.joinedMember,
    this.leftMember,
    this.liveChatMessage,
  });

  factory RoomEventModel.fromProto(proto.RoomEvent protoEvent) {
    RoomEventType eventType;
    switch (protoEvent.type) {
      case proto.RoomEventType.ROOM_EVENT_TYPE_USER_JOINED:
        eventType = RoomEventType.userJoined;
        break;
      case proto.RoomEventType.ROOM_EVENT_TYPE_USER_LEFT:
        eventType = RoomEventType.userLeft;
        break;
      case proto.RoomEventType.ROOM_EVENT_TYPE_ROOM_ENDED:
        eventType = RoomEventType.roomEnded;
        break;
      case proto.RoomEventType.ROOM_EVENT_TYPE_LIVE_CHAT_MESSAGE:
        eventType = RoomEventType.liveChatMessage;
        break;
      default:
        eventType = RoomEventType.unknown;
    }

    return RoomEventModel(
      type: eventType,
      roomId: protoEvent.roomId,
      joinedMember: protoEvent.hasJoinedMember()
          ? JoinedMemberModel.fromProto(protoEvent.joinedMember)
          : null,
      leftMember: protoEvent.hasLeftMember()
          ? LeftMemberModel.fromProto(protoEvent.leftMember)
          : null,
      liveChatMessage: protoEvent.hasLiveChatMessage()
          ? LiveChatMessageModel.fromProto(protoEvent.liveChatMessage)
          : null,
    );
  }
}

class JoinedMemberModel {
  final String userId;
  final String username;
  final String displayName;
  final String avatarUrl;

  JoinedMemberModel({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
  });

  factory JoinedMemberModel.fromProto(proto.JoinedMember protoMember) {
    return JoinedMemberModel(
      userId: protoMember.userId,
      username: protoMember.username,
      displayName: protoMember.displayName,
      avatarUrl: protoMember.avatarUrl,
    );
  }
}

class LeftMemberModel {
  final String userId;

  LeftMemberModel({required this.userId});

  factory LeftMemberModel.fromProto(proto.LeftMember protoMember) {
    return LeftMemberModel(userId: protoMember.userId);
  }
}

class LiveChatMessageModel {
  final String userId;
  final String text;

  LiveChatMessageModel({required this.userId, required this.text});

  factory LiveChatMessageModel.fromProto(proto.LiveChatMessage protoMsg) {
    return LiveChatMessageModel(
      userId: protoMsg.userId,
      text: protoMsg.text,
    );
  }
}