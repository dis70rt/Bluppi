import 'dart:convert';

import 'package:equatable/equatable.dart';

enum MessageStatus { pending, sent, delivered, seen, failed }

enum MessageType { text, track }

class ChatMessage extends Equatable {
  final String messageId;
  final String senderId;
  final String conversationId;
  final String messageText;
  final DateTime createdAt;
  final MessageStatus status;
  final MessageType type;

  const ChatMessage({
    required this.messageId,
    required this.senderId,
    required this.conversationId,
    required this.messageText,
    required this.createdAt,
    this.status = MessageStatus.pending,
    this.type = MessageType.text,
  });

  ChatMessage copyWith({
    String? messageId,
    String? senderId,
    String? conversationId,
    String? messageText,
    DateTime? createdAt,
    MessageStatus? status,
    MessageType? type,
  }) {
    return ChatMessage(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      conversationId: conversationId ?? this.conversationId,
      messageText: messageText ?? this.messageText,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      type: type ?? this.type,
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
      'type': type.toString(),
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['messageId'] ?? json['message_id'],
      senderId: json['senderId'] ?? json['sender_id'],
      conversationId: json['conversationId'] ?? json['conversation_id'],
      messageText: json['messageText'] ?? json['message_text'],
      createdAt: DateTime.parse(json['createdAt'] ?? json['created_at']),
      status: MessageStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => MessageStatus.sent,
      ),
      type: _parseMessageType(json),
    );
  }

  static MessageType _parseMessageType(Map<String, dynamic> json) {
    if (json['type'] != null) {
      String typeString = json['type'].toString();

      if (typeString.contains('track')) return MessageType.track;
      if (typeString.contains('text')) return MessageType.text;

      try {
        return MessageType.values.firstWhere(
          (e) =>
              e.toString() == 'MessageType.$typeString' ||
              e.toString() == typeString,
          orElse: () => MessageType.text,
        );
      } catch (_) {
        return MessageType.text;
      }
    }

    if (json['messageText'] != null) {
      try {
        var content = json['messageText'];
        if (content is String) {
          var decoded = jsonDecode(content);
          if (decoded is Map &&
              (decoded.containsKey('trackName') ||
                  decoded.containsKey('artistName'))) {
            return MessageType.track;
          }
        }
      } catch (_) {}
    }

    return MessageType.text;
  }

  @override
  List<Object?> get props => [
        messageId,
        senderId,
        conversationId,
        messageText,
        createdAt,
        status,
        type
      ];
}
