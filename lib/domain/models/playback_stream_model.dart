import 'package:bluppi/generated/playback.pb.dart' as proto;
import 'package:fixnum/fixnum.dart';

/// Represents a track in the playback stream.
class PlaybackTrackModel {
  final String id;
  final String title;
  final String artist;
  final String audioUrl;
  final String artworkUrl;
  final int durationMs;

  PlaybackTrackModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.audioUrl,
    required this.artworkUrl,
    required this.durationMs,
  });

  /// Converts a protobuf [TrackInfo] message to a [PlaybackTrackModel].
  factory PlaybackTrackModel.fromProto(proto.TrackInfo p) {
    return PlaybackTrackModel(
      id: p.trackId,
      title: p.title,
      artist: p.artist,
      audioUrl: p.audioUrl,
      artworkUrl: p.artworkUrl,
      durationMs: p.durationMs.toInt(),
    );
  }

  /// Converts a [PlaybackTrackModel] to a protobuf [TrackInfo] message.
  proto.TrackInfo toProto() {
    return proto.TrackInfo(
      trackId: id,
      title: title,
      artist: artist,
      audioUrl: audioUrl,
      artworkUrl: artworkUrl,
      durationMs: Int64(durationMs),
    );
  }

  /// Creates a [PlaybackTrackModel] from a JSON map.
  factory PlaybackTrackModel.fromJson(Map<String, dynamic> json) {
    return PlaybackTrackModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      audioUrl: json['audioUrl'],
      artworkUrl: json['artworkUrl'],
      durationMs: json['durationMs'],
    );
  }

  /// Converts a [PlaybackTrackModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'audioUrl': audioUrl,
      'artworkUrl': artworkUrl,
      'durationMs': durationMs,
    };
  }
}

/// Represents the playback state in the stream.
class PlaybackStateModel {
  final PlaybackTrackModel track;
  final bool isPlaying;
  final int positionMs;
  final int lastUpdateServerUs;
  final int scheduledStartServerUs;
  final int version;

  PlaybackStateModel({
    required this.track,
    required this.isPlaying,
    required this.positionMs,
    required this.lastUpdateServerUs,
    required this.scheduledStartServerUs,
    required this.version,
  });

  /// Converts a protobuf [PlaybackState] message to a [PlaybackStateModel].
  factory PlaybackStateModel.fromProto(proto.PlaybackState p) {
    return PlaybackStateModel(
      track: PlaybackTrackModel.fromProto(p.track),
      isPlaying: p.isPlaying,
      positionMs: p.positionMs.toInt(),
      lastUpdateServerUs: p.lastUpdateServerUs.toInt(),
      scheduledStartServerUs: p.scheduledStartServerUs.toInt(),
      version: p.version.toInt(),
    );
  }

  /// Converts a [PlaybackStateModel] to a protobuf [PlaybackState] message.
  proto.PlaybackState toProto() {
    return proto.PlaybackState(
      track: track.toProto(),
      isPlaying: isPlaying,
      positionMs: Int64(positionMs),
      lastUpdateServerUs: Int64(lastUpdateServerUs),
      scheduledStartServerUs: Int64(scheduledStartServerUs),
      version: Int64(version),
    );
  }

  /// Creates a [PlaybackStateModel] from a JSON map.
  factory PlaybackStateModel.fromJson(Map<String, dynamic> json) {
    return PlaybackStateModel(
      track: PlaybackTrackModel.fromJson(json['track']),
      isPlaying: json['isPlaying'],
      positionMs: json['positionMs'],
      lastUpdateServerUs: json['lastUpdateServerUs'],
      scheduledStartServerUs: json['scheduledStartServerUs'],
      version: json['version'],
    );
  }

  /// Converts a [PlaybackStateModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'track': track.toJson(),
      'isPlaying': isPlaying,
      'positionMs': positionMs,
      'lastUpdateServerUs': lastUpdateServerUs,
      'scheduledStartServerUs': scheduledStartServerUs,
      'version': version,
    };
  }
}