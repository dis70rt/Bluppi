import 'package:bluppi/generated/rooms.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class RoomModel {
  final String id;
  final String name;
  final String code;
  final int status;
  final int visibility;
  final String hostUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoomModel({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.visibility,
    required this.hostUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Converts a gRPC protobuf `Room` message to a `RoomModel`.
  factory RoomModel.fromProto(proto.Room pRoom) {
    return RoomModel(
      id: pRoom.id,
      name: pRoom.name,
      code: pRoom.code,
      status: pRoom.status.value,
      visibility: pRoom.visibility.value,
      hostUserId: pRoom.hostUserId,
      createdAt: pRoom.createdAt.toDateTime(),
      updatedAt: pRoom.updatedAt.toDateTime(),
    );
  }

  /// Converts a `RoomModel` to a gRPC protobuf `Room` message.
  proto.Room toProto() {
    return proto.Room(
      id: id,
      name: name,
      code: code,
      status: proto.RoomStatus.valueOf(status) ?? proto.RoomStatus.ROOM_STATUS_UNSPECIFIED,
      visibility: proto.RoomVisibility.valueOf(visibility) ?? proto.RoomVisibility.ROOM_VISIBILITY_UNSPECIFIED,
      hostUserId: hostUserId,
      createdAt: Timestamp.fromDateTime(createdAt),
      updatedAt: Timestamp.fromDateTime(updatedAt),
    );
  }

  /// Creates a `RoomModel` from a JSON map.
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      status: json['status'],
      visibility: json['visibility'],
      hostUserId: json['hostUserId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  /// Converts a `RoomModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'status': status,
      'visibility': visibility,
      'hostUserId': hostUserId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}