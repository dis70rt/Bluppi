class ChatUser {
  final String id;
  final String name;
  final String username;
  final String profileUrl;

  ChatUser({
    required this.id,
    required this.name,
    required this.username,
    required this.profileUrl,
  });

  ChatUser copyWith({
    String? id,
    String? name,
    String? username,
    String? profileUrl,
  }) {
    return ChatUser(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'profileUrl': profileUrl,
      };

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json['id'] as String,
        name: json['name'] as String,
        username: json['username'] as String,
        profileUrl: json['profileUrl'] as String,
      );
}

class LiveChatModel {
  final ChatUser sender;
  final String message;
  final DateTime timestamp;

  LiveChatModel({
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  LiveChatModel copyWith({
    ChatUser? sender,
    String? message,
    DateTime? timestamp,
  }) {
    return LiveChatModel(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'sender': sender.toJson(),
        'message': message,
        'timestamp': timestamp.toUtc().toIso8601String(),
      };

  factory LiveChatModel.fromJson(Map<String, dynamic> json) => LiveChatModel(
        sender: ChatUser.fromJson(json['sender'] as Map<String, dynamic>),
        message: json['message'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}
