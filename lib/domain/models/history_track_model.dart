import 'package:bluppi/generated/tracks.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class HistoryTrackModel {
  final String trackId;
  final String title;
  final String artist;
  final String imageLarge;
  final String imageSmall;
  final DateTime playedAt;

  HistoryTrackModel({
    required this.trackId,
    required this.title,
    required this.artist,
    required this.imageLarge,
    required this.imageSmall,
    required this.playedAt,
  });

  /// Converts a gRPC protobuf `HistoryTrackEntry` message to a `HistoryTrackModel`.
  factory HistoryTrackModel.fromProto(proto.HistoryTrackEntry pEntry) {
    return HistoryTrackModel(
      trackId: pEntry.trackId,
      title: pEntry.title,
      artist: pEntry.artist,
      imageLarge: pEntry.imageLarge,
      imageSmall: pEntry.imageSmall,
      playedAt: pEntry.playedAt.toDateTime(),
    );
  }

  /// Converts a `HistoryTrackModel` to a gRPC protobuf `HistoryTrackEntry` message.
  proto.HistoryTrackEntry toProto() {
    return proto.HistoryTrackEntry(
      trackId: trackId,
      title: title,
      artist: artist,
      imageLarge: imageLarge,
      imageSmall: imageSmall,
      playedAt: Timestamp.fromDateTime(playedAt),
    );
  }

  /// Creates a `HistoryTrackModel` from a JSON map.
  factory HistoryTrackModel.fromJson(Map<String, dynamic> json) {
    return HistoryTrackModel(
      trackId: json['trackId'] ?? json['track_id'],
      title: json['title'],
      artist: json['artist'],
      imageLarge: json['imageLarge'] ?? json['image_large'],
      imageSmall: json['imageSmall'] ?? json['image_small'],
      playedAt: DateTime.parse(json['playedAt'] ?? json['played_at']),
    );
  }

  /// Converts a `HistoryTrackModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'trackId': trackId,
      'title': title,
      'artist': artist,
      'imageLarge': imageLarge,
      'imageSmall': imageSmall,
      'playedAt': playedAt.toIso8601String(),
    };
  }
}