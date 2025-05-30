import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/message_model.dart';
import 'package:synqit/Data/Services/local_storage_service_sql.dart';
import 'package:synqit/Provider/chat_provider/socket_provider.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

enum MessageLoadingState { initial, loading, loaded, error }

class MessagesState {
  final List<ChatMessage> messages;
  final bool isLoadingMore;
  final MessageLoadingState loadingState;
  final String? error;
  final String conversationId;

  MessagesState({
    required this.conversationId,
    this.messages = const [],
    this.isLoadingMore = false,
    this.loadingState = MessageLoadingState.initial,
    this.error,
  });

  MessagesState copyWith({
    List<ChatMessage>? messages,
    bool? isLoadingMore,
    MessageLoadingState? loadingState,
    String? error,
  }) {
    return MessagesState(
      conversationId: conversationId,
      messages: messages ?? this.messages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadingState: loadingState ?? this.loadingState,
      error: error,
    );
  }
}

class MessageNotifier extends StateNotifier<MessagesState> {
  final LocalStorageService _storage;
  final Dio _dio;
  final String _conversationId;
  final String _currentUserId;
  final SocketNotifier _socketNotifier;
  StreamSubscription? _messageSubscription;

  MessageNotifier(
    this._storage,
    this._dio,
    this._conversationId,
    this._currentUserId,
    this._socketNotifier,
  ) : super(MessagesState(conversationId: _conversationId)) {
    _initialize();
    _listenToNewMessages();
  }

  Future<void> _initialize() async {
    state = state.copyWith(loadingState: MessageLoadingState.loading);
    
    try {
      final localMessages = await _storage.loadMessages(_conversationId);
      
      if (localMessages.isNotEmpty) {
        state = state.copyWith(
          messages: localMessages,
          loadingState: MessageLoadingState.loaded,
        );
      } else {
        await loadMoreMessages();
      }
    } catch (e) {
      log("Error initializing messages: $e");
      state = state.copyWith(
        loadingState: MessageLoadingState.error,
        error: e.toString(),
      );
    }
  }

  void _listenToNewMessages() {
    _messageSubscription?.cancel();
    _messageSubscription = _socketNotifier.messageStreamForConversation(_conversationId)
        .listen((message) {
      _addMessage(message);
    });
  }

  Future<void> loadMoreMessages({String? beforeId, int limit = 20}) async {
    if (state.isLoadingMore) return;
    
    state = state.copyWith(isLoadingMore: true);
    
    try {
      final actualBeforeId = beforeId ?? 
          (state.messages.isNotEmpty ? state.messages.first.messageId : null);
      
      final response = await _dio.get(
        'https://socket.saikat.in/conversations/$_conversationId/messages',
        queryParameters: {
          if (actualBeforeId != null) 'before_id': actualBeforeId,
          'limit': limit,
        },
      );

      final data = response.data['messages'] as List;
      final newMessages = data
          .map((d) => ChatMessage(
                messageId: d['message_id'],
                senderId: d['sender_id'],
                conversationId: _conversationId,
                messageText: d['message_text'],
                createdAt: DateTime.parse(d['created_at']),
                status: MessageStatus.delivered,
                type: MessageType.values.firstWhere(
                  (e) => e.toString() == d['type'],
                  orElse: () => MessageType.text,
                ),
              ))
          .toList();

      for (final message in newMessages) {
        await _storage.addMessage(message);
      }

      final allMessages = [...state.messages];
      
      for (final newMsg in newMessages) {
        if (!allMessages.any((msg) => msg.messageId == newMsg.messageId)) {
          allMessages.add(newMsg);
        }
      }
      
      allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      
      state = state.copyWith(
        messages: allMessages,
        isLoadingMore: false,
        loadingState: MessageLoadingState.loaded,
      );
    } catch (e) {
      log("Error loading more messages: $e");
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
        loadingState: MessageLoadingState.error,
      );
    }
  }

  Future<bool> sendMessage(String messageText, {MessageType messageType = MessageType.text}) async {
    if (messageText.trim().isEmpty) return false;
    
    final messageId = const Uuid().v4();
    final now = DateTime.now();

    final pendingMessage = ChatMessage(
      messageId: messageId,
      senderId: _currentUserId,
      conversationId: _conversationId,
      messageText: messageText,
      createdAt: now,
      status: MessageStatus.pending,
      type: messageType,
    );

    _addMessage(pendingMessage);
    await _storage.addMessage(pendingMessage);

    try {
      await _socketNotifier.sendMessage(_conversationId, messageText, messageId, messageType.name);
      
      _updateMessageStatus(messageId, MessageStatus.sent);
      await _storage.updateMessageStatus(
        messageId, _conversationId, MessageStatus.sent);
      
      return true;
    } catch (e) {
      log("Failed to send message: $e");
      
      _updateMessageStatus(messageId, MessageStatus.failed);
      await _storage.updateMessageStatus(
        messageId, _conversationId, MessageStatus.failed);
      
      state = state.copyWith(error: "Failed to send message: ${e.toString()}");
      return false;
    }
  }

  void _addMessage(ChatMessage message) {
    if (state.messages.any((m) => m.messageId == message.messageId)) {
      return;
    }

    final updatedMessages = [...state.messages, message];
    updatedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    
    state = state.copyWith(messages: updatedMessages);
  }

  void _updateMessageStatus(String messageId, MessageStatus status) {
    final messageIndex = state.messages.indexWhere((m) => m.messageId == messageId);
    if (messageIndex != -1) {
      final message = state.messages[messageIndex];
      final updatedMessage = message.copyWith(status: status);
      
      final updatedMessages = [...state.messages];
      updatedMessages[messageIndex] = updatedMessage;
      
      state = state.copyWith(messages: updatedMessages);
    }
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }
}

final messageProvider = StateNotifierProvider.family<MessageNotifier, MessagesState, String>((ref, conversationId) {
  final storage = ref.watch(localStorageProvider);
  final dio = ref.watch(dioProvider);
  final socketNotifier = ref.watch(socketProvider.notifier);
  final currentUserId = ref.watch(socketProvider).currentUserId;
  
  if (currentUserId == null) {
    throw Exception("Cannot create message provider: User is not logged in");
  }
  
  return MessageNotifier(storage, dio, conversationId, currentUserId, socketNotifier);
});