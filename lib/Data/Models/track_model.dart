import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final int trackId;
  final String artistName;
  final String trackName;
  final String albumName;
  final String imageUrl;
  final String previewUrl;
  final List<String> genres;
  final int listeners;
  final int playcount;
  final String lastFmUrl;
  final int popularityScore;
  final String? ytUrl;

  const Track({
    required this.trackId,
    required this.artistName,
    required this.trackName,
    required this.albumName,
    required this.imageUrl,
    required this.previewUrl,
    required this.genres,
    required this.listeners,
    required this.playcount,
    required this.lastFmUrl,
    required this.popularityScore,
    this.ytUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    final List<dynamic> genreListRaw = json['genres'] as List<dynamic>? ?? [];
    final List<String> parsedGenres =
        genreListRaw.map((g) => g.toString()).toList();

    return Track(
      trackId: json['trackId'] as int? ?? 0,
      artistName: json['artistName'] as String? ?? 'Unknown Artist',
      trackName: json['trackName'] as String? ?? 'Unknown Track',
      albumName: json['albumName'] as String? ?? 'Unknown Album',
      imageUrl: json['imageUrl'] as String? ?? '',
      previewUrl: json['previewUrl'] as String? ?? '',
      genres: parsedGenres,
      listeners: json['listeners'] as int? ?? 0,
      playcount: json['playcount'] as int? ?? 0,
      lastFmUrl: json['lastFmUrl'] as String? ?? '',
      popularityScore: json['popularityScore'] as int? ?? 0,
      ytUrl: json['ytUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackId': trackId,
      'artistName': artistName,
      'trackName': trackName,
      'albumName': albumName,
      'imageUrl': imageUrl,
      'previewUrl': previewUrl,
      'genres': genres,
      'listeners': listeners,
      'playcount': playcount,
      'lastFmUrl': lastFmUrl,
      'popularityScore': popularityScore,
      'ytUrl': ytUrl,
    };
  }

  Track copyWith({
    int? trackId,
    String? artistName,
    String? trackName,
    String? albumName,
    String? imageUrl,
    String? previewUrl,
    List<String>? genres,
    int? listeners,
    int? playcount,
    String? lastFmUrl,
    int? popularityScore,
    String? ytUrl,
  }) {
    return Track(
      trackId: trackId ?? this.trackId,
      artistName: artistName ?? this.artistName,
      trackName: trackName ?? this.trackName,
      albumName: albumName ?? this.albumName,
      imageUrl: imageUrl ?? this.imageUrl,
      previewUrl: previewUrl ?? this.previewUrl,
      genres: genres ?? this.genres,
      listeners: listeners ?? this.listeners,
      playcount: playcount ?? this.playcount,
      lastFmUrl: lastFmUrl ?? this.lastFmUrl,
      popularityScore: popularityScore ?? this.popularityScore,
      ytUrl: ytUrl ?? this.ytUrl,
    );
  }

  @override
  List<Object?> get props => [
        trackId,
        artistName,
        trackName,
        albumName,
        imageUrl,
        previewUrl,
        genres,
        listeners,
        playcount,
        lastFmUrl,
        popularityScore,
        ytUrl,
      ];
}

class TrackSearchResponse {
  final List<Track> results;

  TrackSearchResponse({required this.results});

  factory TrackSearchResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> resultsRaw = json['results'] as List<dynamic>? ?? [];
    return TrackSearchResponse(
      results: resultsRaw
          .map((item) => Track.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
