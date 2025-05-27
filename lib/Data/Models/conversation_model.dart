import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String conversationId;
  final String? conversationName;
  final bool isGroup;
  final List<String> participants;
  final DateTime? lastActivity;
  
  const Conversation({
    required this.conversationId,
    this.conversationName,
    required this.isGroup,
    required this.participants,
    this.lastActivity,
  });

  Conversation copyWith({
    String? conversationId,
    String? conversationName,
    bool? isGroup,
    List<String>? participants,
    DateTime? lastActivity,
  }) {
    return Conversation(
      conversationId: conversationId ?? this.conversationId,
      conversationName: conversationName ?? this.conversationName,
      isGroup: isGroup ?? this.isGroup,
      participants: participants ?? this.participants,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'conversationName': conversationName,
      'isGroup': isGroup,
      'participants': participants,
      'lastActivity': lastActivity?.toIso8601String(),
    };
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      conversationId: json['conversationId'],
      conversationName: json['conversationName'],
      isGroup: json['isGroup'],
      participants: List<String>.from(json['participants']),
      lastActivity: json['lastActivity'] != null ? DateTime.parse(json['lastActivity']) : null,
    );
  }

  @override
  List<Object?> get props => [conversationId, conversationName, isGroup, participants, lastActivity];
}