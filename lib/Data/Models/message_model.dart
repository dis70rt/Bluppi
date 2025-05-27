import 'package:equatable/equatable.dart';

enum MessageStatus { pending, sent, delivered, seen, failed }

class ChatMessage extends Equatable {
  final String messageId;
  final String senderId;
  final String conversationId;
  final String messageText;
  final DateTime createdAt;
  final MessageStatus status;

  const ChatMessage({
    required this.messageId,
    required this.senderId,
    required this.conversationId,
    required this.messageText,
    required this.createdAt,
    this.status = MessageStatus.pending,
  });

  ChatMessage copyWith({
    String? messageId,
    String? senderId,
    String? conversationId,
    String? messageText,
    DateTime? createdAt,
    MessageStatus? status,
  }) {
    return ChatMessage(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      conversationId: conversationId ?? this.conversationId,
      messageText: messageText ?? this.messageText,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'conversationId': conversationId,
      'messageText': messageText,
      'createdAt': createdAt.toIso8601String(),
      'status': status.toString(),
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['messageId'],
      senderId: json['senderId'],
      conversationId: json['conversationId'],
      messageText: json['messageText'],
      createdAt: DateTime.parse(json['createdAt']),
      status: MessageStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => MessageStatus.sent,
      ),
    );
  }

  @override
  List<Object?> get props => [messageId, senderId, conversationId, messageText, createdAt, status];
}