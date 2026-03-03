import 'package:bluppi/generated/rooms.pb.dart' as proto;

class RoomSummaryModel {
  final String id;
  final String name;
  final String trackId;
  final String trackTitle;
  final String trackArtist;
  final String artworkUrl;
  final String hostUserId;
  final String hostUsername;
  final int listenerCount;
  final bool isLive;
  final bool isPublic;

  RoomSummaryModel({
    required this.id,
    required this.name,
    required this.trackId,
    required this.trackTitle,
    required this.trackArtist,
    required this.artworkUrl,
    required this.hostUserId,
    required this.hostUsername,
    required this.listenerCount,
    required this.isLive,
    required this.isPublic,
  });

  /// Converts a gRPC protobuf `RoomSummary` message to a `RoomSummaryModel`.
  factory RoomSummaryModel.fromProto(proto.RoomSummary p) {
    return RoomSummaryModel(
      id: p.roomId,
      name: p.roomName,
      trackId: p.trackId,
      trackTitle: p.trackTitle,
      trackArtist: p.trackArtist,
      artworkUrl: p.artworkUrl,
      hostUserId: p.hostUserId,
      hostUsername: p.hostDisplayName,
      listenerCount: p.listenerCount,
      isLive: p.isLive,
      isPublic: p.visibility == proto.RoomVisibility.ROOM_VISIBILITY_PUBLIC,
    );
  }

  /// Converts a `RoomSummaryModel` to a gRPC protobuf `RoomSummary` message.
  proto.RoomSummary toProto() {
    return proto.RoomSummary(
      roomId: id,
      roomName: name,
      trackId: trackId,
      trackTitle: trackTitle,
      trackArtist: trackArtist,
      artworkUrl: artworkUrl,
      hostUserId: hostUserId,
      hostDisplayName: hostUsername,
      listenerCount: listenerCount,
      isLive: isLive,
      visibility: isPublic
          ? proto.RoomVisibility.ROOM_VISIBILITY_PUBLIC
          : proto.RoomVisibility.ROOM_VISIBILITY_PRIVATE,
    );
  }

  /// Creates a `RoomSummaryModel` from a JSON map.
  factory RoomSummaryModel.fromJson(Map<String, dynamic> json) {
    return RoomSummaryModel(
      id: json['id'],
      name: json['name'],
      trackId: json['trackId'],
      trackTitle: json['trackTitle'],
      trackArtist: json['trackArtist'],
      artworkUrl: json['artworkUrl'],
      hostUserId: json['hostUserId'],
      hostUsername: json['hostUsername'],
      listenerCount: json['listenerCount'],
      isLive: json['isLive'],
      isPublic: json['isPublic'],
    );
  }

  /// Converts a `RoomSummaryModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'trackId': trackId,
      'trackTitle': trackTitle,
      'trackArtist': trackArtist,
      'artworkUrl': artworkUrl,
      'hostUserId': hostUserId,
      'hostUsername': hostUsername,
      'listenerCount': listenerCount,
      'isLive': isLive,
      'isPublic': isPublic,
    };
  }
}