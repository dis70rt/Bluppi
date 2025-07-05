import 'package:bluppi/config.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Data/Models/conversation_model.dart';
import 'package:bluppi/Data/Models/message_model.dart';
import 'package:bluppi/Data/Models/user_model.dart';
import 'package:bluppi/Data/Services/user_services.dart';

class ConversationDetail {
  final UserModel? receiver;
  final ChatMessage? lastMessage;
  final bool isLoading;
  final Object? error;

  ConversationDetail({
    this.receiver,
    this.lastMessage,
    this.isLoading = false,
    this.error,
  });

  ConversationDetail copyWith({
    UserModel? receiver,
    ChatMessage? lastMessage,
    bool? isLoading,
    Object? error,
  }) {
    return ConversationDetail(
      receiver: receiver ?? this.receiver,
      lastMessage: lastMessage ?? this.lastMessage,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final conversationDetailProvider = StateNotifierProvider.family<
    ConversationDetailNotifier, ConversationDetail, Conversation>(
  (ref, conversation) => ConversationDetailNotifier(conversation, ref),
);

class ConversationDetailNotifier extends StateNotifier<ConversationDetail> {
  final Conversation conversation;
  final UserServices _userService = UserServices();
  final Ref ref;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.httpSocketUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15)

  ));

  ConversationDetailNotifier(this.conversation, this.ref) : super(ConversationDetail(isLoading: true)) {
    loadConversationDetails();
  }

  Future<void> loadConversationDetails() async {
    try {
      state = state.copyWith(isLoading: true, error: null);      
      final String receiverId = _getReceiverId(conversation);
      
      final results = await Future.wait([
        _userService.getUserByID(receiverId),
        getLastMessage(),
      ]);
      
      state = state.copyWith(
        receiver: results[0] as UserModel?,
        lastMessage: results[1] as ChatMessage?,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  String _getReceiverId(Conversation conversation) {
    final participants = List<String>.from(conversation.participants);
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    
    if (participants.isEmpty) return '';
    if (participants.length == 1) return participants.first;
    
    return participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => participants.first,
    );
  }

  Future<ChatMessage?> getLastMessage() async {
  try {
    final response = await _dio.get(
      '/conversations/${conversation.conversationId}/messages',
      queryParameters: {
        'limit': 1,
      },
      options: Options(
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    final data = response.data['messages'] as List;
    if (data.isEmpty) {
      return null;
    }

    final messages = data.map((d) => ChatMessage(
      messageId: d['message_id'],
      senderId: d['sender_id'],
      conversationId: conversation.conversationId,
      messageText: d['message_text'],
      createdAt: DateTime.parse(d['created_at']),
      status: MessageStatus.delivered,
      type: MessageType.values.firstWhere(
        (e) => e.name == d['type'],
        orElse: () => MessageType.text,
      ),
    )).toList();
    
    return messages.isNotEmpty ? messages.first : null;
  } catch (e) {
    return null;
  }
}
}