import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final int? trackId;
  final String artistName;
  final String trackName;
  final String? collectionName;
  final String? artworkUrl100;
  final String? previewUrl;
  final String? primaryGenreName;
  final String? listeners;
  final String? playcount;
  final String? lastFmUrl;

  const Track({
    this.trackId,
    required this.artistName,
    required this.trackName,
    this.collectionName,
    this.artworkUrl100,
    this.previewUrl,
    this.primaryGenreName,
    this.listeners,
    this.playcount,
    this.lastFmUrl,
  });

  factory Track.fromItunesJson(Map<String, dynamic> json) {
    return Track(
      trackId: json['trackId'] as int?,
      artistName: json['artistName'] as String? ?? 'Unknown Artist',
      trackName: json['trackName'] as String? ?? 'Unknown Track',
      collectionName: json['collectionName'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
      previewUrl: json['previewUrl'] as String?,
      primaryGenreName: json['primaryGenreName'] as String?,
    );
  }

  factory Track.fromLastFmTopTrackJson(Map<String, dynamic> json) {
    final artist = json['artist'] as Map<String, dynamic>? ?? {};
    return Track(
      trackId: null,
      artistName: artist['name'] as String? ?? 'Unknown Artist',
      trackName: json['name'] as String? ?? 'Unknown Track',
      collectionName: null,
      artworkUrl100: _getImageUrl(json['image'] as List<dynamic>?),
      previewUrl: null,
      primaryGenreName: null,
      listeners: json['listeners'] as String?,
      playcount: json['playcount'] as String?,
      lastFmUrl: json['url'] as String?,
    );
  }

  static String? _getImageUrl(List<dynamic>? images) {
    if (images == null || images.isEmpty) {
      return null;
    }

    String? url;
    for (var imageInfo in images.reversed) {
      if (imageInfo is Map<String, dynamic>) {
        final size = imageInfo['size'] as String?;
        final textUrl = imageInfo['#text'] as String?;
        if (textUrl != null && textUrl.isNotEmpty) {
          url = textUrl;
          if (size == 'extralarge') break;
        }
      }
    }
    return url;
  }

  Track copyWith({
    int? trackId,
    String? artistName,
    String? trackName,
    String? collectionName,
    String? artworkUrl100,
    String? previewUrl,
    String? primaryGenreName,
    String? listeners,
    String? playcount,
    String? lastFmUrl,
  }) {
    return Track(
      trackId: trackId ?? this.trackId,
      artistName: artistName ?? this.artistName,
      trackName: trackName ?? this.trackName,
      collectionName: collectionName ?? this.collectionName,
      artworkUrl100: artworkUrl100 ?? this.artworkUrl100,
      previewUrl: previewUrl ?? this.previewUrl,
      primaryGenreName: primaryGenreName ?? this.primaryGenreName,
      listeners: listeners ?? this.listeners,
      playcount: playcount ?? this.playcount,
      lastFmUrl: lastFmUrl ?? this.lastFmUrl,
    );
  }

  @override
  List<Object?> get props => [
        trackId,
        artistName,
        trackName,
        collectionName,
        artworkUrl100,
        previewUrl,
        primaryGenreName,
        listeners,
        playcount,
        lastFmUrl,
      ];

  int get popularityScore {
    try {
      final count = playcount != null && playcount!.isNotEmpty
          ? int.tryParse(playcount!)
          : (listeners != null && listeners!.isNotEmpty
              ? int.tryParse(listeners!)
              : null);
      return count ?? 0;
    } catch (e) {
      return 0;
    }
  }
}
