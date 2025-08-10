class BlupUser {
  final String id;
  final String? profilePic;
  final String name;
  final String username;

  BlupUser({
    required this.id,
    this.profilePic,
    required this.name,
    required this.username,
  });

  factory BlupUser.fromJson(Map<String, dynamic> json) {
    return BlupUser(
      id: json['id'] as String,
      profilePic: json['profilePic'] as String?,
      name: json['name'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePic': profilePic,
      'name': name,
      'username': username,
    };
  }
}

class BlupModel {
  final String id;
  final BlupUser user;
  final String content;
  final String audioUrl;
  final Duration startTime;
  final DateTime timestamp;
  final int likesCount;
  final int commentsCount;
  final int shareCount;
  final List<double> audioFrequencies;

  BlupModel({
    required this.id,
    required this.user,
    required this.content,
    required this.audioUrl,
    required this.startTime,
    required this.timestamp,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.shareCount = 0,
    required this.audioFrequencies,
  });

  factory BlupModel.fromJson(Map<String, dynamic> json) {
    return BlupModel(
      id: json['id'] as String,
      user: BlupUser.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String,
      audioUrl: json['audioUrl'] as String,
      startTime: Duration(milliseconds: json['startTime'] as int),
      timestamp: DateTime.parse(json['timestamp'] as String),
      likesCount: json['likesCount'] as int? ?? 0,
      commentsCount: json['commentsCount'] as int? ?? 0,
      shareCount: json['shareCount'] as int? ?? 0,
      audioFrequencies: (json['audioFrequencies'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'content': content,
      'audioUrl': audioUrl,
      'startTime': startTime.inMilliseconds,
      'timestamp': timestamp.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'shareCount': shareCount,
      'audioFrequencies': audioFrequencies,
    };
  }
}

final defaultBlup = BlupModel(
  id: '1',
  user: BlupUser(
    id: 'u1',
    profilePic: null,
    name: 'Saikat Das',
    username: '@saikat',
  ),
  content: 'This is the song I love very much! I added these extra lines to make it take space so that I can test the UI properly. Added more lines just to test it... LETS GOOOOOOOOOOOOOOOO.......',
  audioUrl: 'https://example.com/audio.mp3',
  startTime: Duration.zero,
  timestamp: DateTime.now(),
  audioFrequencies: [
    0.3, 0.5, 0.7, 0.4, 0.6, 0.9, 0.8, 0.5, 0.4, 0.7,
    0.6, 0.9, 0.3, 0.5, 0.7, 0.4, 0.8, 0.5, 0.9, 0.3,
    0.6, 0.4, 0.5, 0.8, 0.7, 0.9, 0.3, 0.4, 0.6, 0.8
  ],
);
