import 'package:bluppi/generated/tracks.pb.dart' as proto;

class SearchTrackModel {
  final String id;
  final String title;
  final String artist;
  final String imageSmall;
  final String previewUrl;

  SearchTrackModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageSmall,
    required this.previewUrl,
  });

  /// Converts a gRPC protobuf `SearchTrack` message to a `SearchTrackModel`.
  factory SearchTrackModel.fromProto(proto.SearchTrack pTrack) {
    return SearchTrackModel(
      id: pTrack.id,
      title: pTrack.title,
      artist: pTrack.artist,
      imageSmall: pTrack.imageSmall,
      previewUrl: pTrack.previewUrl,
    );
  }

  /// Converts a `SearchTrackModel` to a gRPC protobuf `SearchTrack` message.
  proto.SearchTrack toProto() {
    return proto.SearchTrack(
      id: id,
      title: title,
      artist: artist,
      imageSmall: imageSmall,
      previewUrl: previewUrl,
    );
  }

  /// Creates a `SearchTrackModel` from a JSON map.
  factory SearchTrackModel.fromJson(Map<String, dynamic> json) {
    return SearchTrackModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      imageSmall: json['imageSmall'],
      previewUrl: json['previewUrl'],
    );
  }

  /// Converts a `SearchTrackModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'imageSmall': imageSmall,
      'previewUrl': previewUrl,
    };
  }
}