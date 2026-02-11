import 'package:bluppi/generated/tracks.pb.dart' as proto;
import 'package:fixnum/fixnum.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class TrackModel {
  final String id;
  final String title;
  final String artist;
  final int durationMs;
  final List<String> genres;
  final String imageSmall;
  final String imageLarge;
  final String previewUrl;
  final String videoId;
  final int listeners;
  final int playCount;
  final int popularity;
  final DateTime createdAt;

  TrackModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.durationMs,
    required this.genres,
    required this.imageSmall,
    required this.imageLarge,
    required this.previewUrl,
    required this.videoId,
    required this.listeners,
    required this.playCount,
    required this.popularity,
    required this.createdAt,
  });

  /// Converts a gRPC protobuf `Track` message to a `TrackModel`.
  factory TrackModel.fromProto(proto.Track pTrack) {
    return TrackModel(
      id: pTrack.id,
      title: pTrack.title,
      artist: pTrack.artist,
      durationMs: pTrack.durationMs,
      genres: List<String>.from(pTrack.genres),
      imageSmall: pTrack.imageSmall,
      imageLarge: pTrack.imageLarge,
      previewUrl: pTrack.previewUrl,
      videoId: pTrack.videoId,
      listeners: pTrack.listeners.toInt(),
      playCount: pTrack.playCount.toInt(),
      popularity: pTrack.popularity,
      createdAt: pTrack.createdAt.toDateTime(),
    );
  }

  /// Converts a `TrackModel` to a gRPC protobuf `Track` message.
  proto.Track toProto() {
    return proto.Track(
      id: id,
      title: title,
      artist: artist,
      durationMs: durationMs,
      genres: genres,
      imageSmall: imageSmall,
      imageLarge: imageLarge,
      previewUrl: previewUrl,
      videoId: videoId,
      listeners: Int64(listeners),
      playCount: Int64(playCount),
      popularity: popularity,
      createdAt: Timestamp.fromDateTime(createdAt),
    );
  }

  /// Creates a `TrackModel` from a JSON map.
  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      durationMs: json['durationMs'],
      genres: List<String>.from(json['genres']),
      imageSmall: json['imageSmall'],
      imageLarge: json['imageLarge'],
      previewUrl: json['previewUrl'],
      videoId: json['videoId'],
      listeners: json['listeners'],
      playCount: json['playCount'],
      popularity: json['popularity'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  /// Converts a `TrackModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'durationMs': durationMs,
      'genres': genres,
      'imageSmall': imageSmall,
      'imageLarge': imageLarge,
      'previewUrl': previewUrl,
      'videoId': videoId,
      'listeners': listeners,
      'playCount': playCount,
      'popularity': popularity,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}