import 'package:flutter/foundation.dart';

@immutable
class CurrentTrack {
  final String name;
  final String artistName;
  final String? youtubeVideoId;
  final String? thumbnailUrl;

  const CurrentTrack({
    required this.name,
    required this.artistName,
    this.youtubeVideoId,
    this.thumbnailUrl,
  });

  CurrentTrack copyWith({
    String? name,
    String? artistName,
    String? youtubeVideoId,
    String? thumbnailUrl,
  }) {
    return CurrentTrack(
      name: name ?? this.name,
      artistName: artistName ?? this.artistName,
      youtubeVideoId: youtubeVideoId ?? this.youtubeVideoId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentTrack &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          artistName == other.artistName &&
          youtubeVideoId == other.youtubeVideoId &&
          thumbnailUrl == other.thumbnailUrl;

  @override
  int get hashCode =>
      name.hashCode ^
      artistName.hashCode ^
      youtubeVideoId.hashCode ^
      thumbnailUrl.hashCode;

  @override
  String toString() {
    return 'CurrentTrack(name: $name, artistName: $artistName, youtubeVideoId: $youtubeVideoId, thumbnailUrl: $thumbnailUrl)';
  }
}