class Artist {
  String id;
  String name;
  String spotifyUrl;
  String? imageUrl;

  Artist({
    required this.id,
    required this.name,
    required this.spotifyUrl,
    this.imageUrl,
  });

  Artist.defaultArtist()
      : id = '0',
        name = 'Loading Artist...',
        spotifyUrl = '',
        imageUrl = null;
}

class LastTrack {
  String id;
  String name;
  Artist artist;
  Duration duartion;
  String trackUrl;
  String playedAt;
  String? imageUrl;
  String? previewUrl;

  LastTrack({
    required this.id,
    required this.name,
    required this.artist,
    required this.duartion,
    required this.trackUrl,
    required this.playedAt,
    this.imageUrl,
    this.previewUrl,
  });

  LastTrack.defaultTrack()
      : id = '0',
        name = 'Loading Track...',
        artist = Artist.defaultArtist(),
        duartion = const Duration(seconds: 30),
        trackUrl = '',
        imageUrl = null,
        playedAt = DateTime.now().toIso8601String(),
        previewUrl = null;
}
