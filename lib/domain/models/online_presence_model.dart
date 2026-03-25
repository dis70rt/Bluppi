import 'package:bluppi/generated/presences.pb.dart' as proto;

class PresenceEvent {
  final String userId;
  final String status;
  final DateTime lastSeen;

  PresenceEvent({
    required this.userId,
    required this.status,
    required this.lastSeen,
  });

  factory PresenceEvent.fromProto(proto.PresenceUpdate protoUpdate) {
    return PresenceEvent(
      userId: protoUpdate.userId,
      status: protoUpdate.status,
      lastSeen: protoUpdate.lastSeen.toDateTime(),
    );
  }
}