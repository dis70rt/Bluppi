import 'package:bluppi/generated/rooms.pb.dart' as proto;

enum RoomEventType {
  userJoined,
  userLeft,
  roomEnded,
  unknown,
}

class RoomEventModel {
  final RoomEventType type;
  final String roomId;
  final int listenerCount;
  final String targetUserId;

  RoomEventModel({
    required this.type,
    required this.roomId,
    required this.listenerCount,
    required this.targetUserId,
  });

  /// Converts a gRPC protobuf `RoomEvent` message to a `RoomEventModel`.
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
      default:
        eventType = RoomEventType.unknown;
    }

    return RoomEventModel(
      type: eventType,
      roomId: protoEvent.roomId,
      listenerCount: protoEvent.listenerCount,
      targetUserId: protoEvent.targetUserId,
    );
  }
}