import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Data/Models/message_model.dart';
import 'package:bluppi/Data/Services/local_storage_service_sql.dart';
import 'package:bluppi/Data/Services/socket_service.dart';
import 'package:bluppi/config.dart';

final conversationSocketProvider = 
    StateNotifierProvider.autoDispose.family<ConversationSocketNotifier, ConversationSocketState, String>(
  (ref, conversationId) {
    final notifier = ConversationSocketNotifier(conversationId);
    ref.onDispose(() {
      notifier.dispose();
    });
    return notifier;
  },
);

class ConversationSocketState {
  final ConnectionStatus status;
  final bool isConnecting;
  final String? error;
  
  ConversationSocketState({
    this.status = ConnectionStatus.disconnected,
    this.isConnecting = false,
    this.error,
  });
  
  ConversationSocketState copyWith({
    ConnectionStatus? status,
    bool? isConnecting,
    String? error,
  }) {
    return ConversationSocketState(
      status: status ?? this.status,
      isConnecting: isConnecting ?? this.isConnecting,
      error: error,
    );
  }
}

class ConversationSocketNotifier extends StateNotifier<ConversationSocketState> {
  final String conversationId;
  SocketService? _socketService;
  StreamSubscription? _statusSubscription;
  StreamSubscription? _messageSubscription;
  final StreamController<ChatMessage> _messagesController = StreamController<ChatMessage>.broadcast();
  
  Stream<ChatMessage> get messages => _messagesController.stream;
  
  ConversationSocketNotifier(this.conversationId) : super(ConversationSocketState());
  
  Future<bool> connect(String userId) async {
    if (state.isConnecting) return false;
    
    state = state.copyWith(isConnecting: true, error: null);
    
    try {
      _socketService = SocketService(baseUrl: AppConfig.socketUrl);
      
      _statusSubscription = _socketService!.connectionStatus.listen((status) {
        state = state.copyWith(status: status);
      });
      
      _messageSubscription = _socketService!.messageStream.listen((message) {
        if (message.conversationId == conversationId) {
          _messagesController.add(message);
        }
      });
      
      final success = await _socketService!.connectToConversation(userId, conversationId);
      
      state = state.copyWith(
        isConnecting: false, 
        error: success ? null : 'Failed to connect'
      );
      
      return success;
    } catch (e) {
      log('Error connecting to conversation $conversationId: $e');
      state = state.copyWith(isConnecting: false, error: e.toString());
      return false;
    }
  }
  
  Future<bool> sendMessage(String messageId, String text, String type) async {
    if (_socketService == null) return false;
    return _socketService!.sendMessage(messageId, text, type);
  }
  
  void updateMessageStatus(String messageId, MessageStatus status) {
    _socketService?.updateMessageStatus(messageId, status);
  }
  
  void disconnect() {
    _statusSubscription?.cancel();
    _messageSubscription?.cancel();
    _socketService?.disconnect();
    _socketService = null;
    state = ConversationSocketState();
  }
  
  @override
  void dispose() {
    _statusSubscription?.cancel();
    _messageSubscription?.cancel();
    _socketService?.dispose();
    _messagesController.close();
    super.dispose();
  }
}

final socketServiceProvider = Provider<SocketService>((ref) {
  return SocketService(baseUrl: AppConfig.socketUrl);
});

final localStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
});