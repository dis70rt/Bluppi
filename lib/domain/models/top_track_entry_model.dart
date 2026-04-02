import 'package:bluppi/generated/tracks.pb.dart' as proto;

class TopTrackEntryModel {
  final String trackId;
  final String title;
  final String artist;
  final String imageSmall;
  final int playCount;

  const TopTrackEntryModel({
    required this.trackId,
    required this.title,
    required this.artist,
    required this.imageSmall,
    required this.playCount,
  });

  TopTrackEntryModel copyWith({
    String? trackId,
    String? title,
    String? artist,
    String? imageSmall,
    int? playCount,
  }) {
    return TopTrackEntryModel(
      trackId: trackId ?? this.trackId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      imageSmall: imageSmall ?? this.imageSmall,
      playCount: playCount ?? this.playCount,
    );
  }

  factory TopTrackEntryModel.fromProto(proto.TopTrackEntry protoEntry) {
    return TopTrackEntryModel(
      trackId: protoEntry.trackId,
      title: protoEntry.title,
      artist: protoEntry.artist,
      imageSmall: protoEntry.imageSmall,
      playCount: protoEntry.playCount,
    );
  }

  proto.TopTrackEntry toProto() {
    return proto.TopTrackEntry(
      trackId: trackId,
      title: title,
      artist: artist,
      imageSmall: imageSmall,
      playCount: playCount,
    );
  }
}
