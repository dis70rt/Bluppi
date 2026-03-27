import 'package:bluppi/generated/tracks.pb.dart' as proto;

class TrackSummaryModel {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final String previewUrl;
  final int? socialCount;
  final String? socialContext;

  TrackSummaryModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.previewUrl,
    this.socialCount,
    this.socialContext,
  });

  /// Converts a gRPC protobuf `TrackSummary` message to a `TrackSummaryModel`.
  factory TrackSummaryModel.fromProto(proto.TrackSummary pTrackSummary) {
    return TrackSummaryModel(
      id: pTrackSummary.id,
      title: pTrackSummary.title,
      artist: pTrackSummary.artist,
      imageUrl: pTrackSummary.imageUrl,
      previewUrl: pTrackSummary.previewUrl,
      socialCount: pTrackSummary.hasSocialCount() ? pTrackSummary.socialCount : null,
      socialContext: pTrackSummary.hasSocialContext() ? pTrackSummary.socialContext : null,
    );
  }

  /// Converts a `TrackSummaryModel` to a gRPC protobuf `TrackSummary` message.
  proto.TrackSummary toProto() {
    final summary = proto.TrackSummary(
      id: id,
      title: title,
      artist: artist,
      imageUrl: imageUrl,
      previewUrl: previewUrl,
    );
    
    if (socialCount != null) {
      summary.socialCount = socialCount!;
    }
    
    if (socialContext != null) {
      summary.socialContext = socialContext!;
    }
    
    return summary;
  }

  /// Creates a `TrackSummaryModel` from a JSON map.
  factory TrackSummaryModel.fromJson(Map<String, dynamic> json) {
    return TrackSummaryModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      imageUrl: json['imageUrl'],
      previewUrl: json['previewUrl'],
      socialCount: json['socialCount'],
      socialContext: json['socialContext'],
    );
  }

  /// Converts a `TrackSummaryModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'imageUrl': imageUrl,
      'previewUrl': previewUrl,
      if (socialCount != null) 'socialCount': socialCount,
      if (socialContext != null) 'socialContext': socialContext,
    };
  }
}