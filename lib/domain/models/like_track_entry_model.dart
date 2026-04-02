import 'package:bluppi/generated/tracks.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class LikedTrackModel {
  final String trackId;
  final String title;
  final String artist;
  final String imageSmall;
  final DateTime likedAt;

  const LikedTrackModel({
    required this.trackId,
    required this.title,
    required this.artist,
    required this.imageSmall,
    required this.likedAt,
  });

  LikedTrackModel copyWith({
    String? trackId,
    String? title,
    String? artist,
    String? imageSmall,
    DateTime? likedAt,
  }) {
    return LikedTrackModel(
      trackId: trackId ?? this.trackId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      imageSmall: imageSmall ?? this.imageSmall,
      likedAt: likedAt ?? this.likedAt,
    );
  }

  factory LikedTrackModel.fromProto(proto.LikedTrackEntry protoEntry) {
    return LikedTrackModel(
      trackId: protoEntry.trackId,
      title: protoEntry.title,
      artist: protoEntry.artist,
      imageSmall: protoEntry.imageSmall,
      // Converts Google Protobuf Timestamp to Dart DateTime
      likedAt: protoEntry.hasLikedAt() 
          ? protoEntry.likedAt.toDateTime() 
          : DateTime.now(),
    );
  }

  proto.LikedTrackEntry toProto() {
    return proto.LikedTrackEntry(
      trackId: trackId,
      title: title,
      artist: artist,
      imageSmall: imageSmall,
      // Converts Dart DateTime back to Google Protobuf Timestamp
      likedAt: Timestamp.fromDateTime(likedAt),
    );
  }
}