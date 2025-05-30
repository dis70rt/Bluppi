import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:synqit/Data/Models/message_model.dart';
import 'package:synqit/Data/Services/local_storage_service_sql.dart';
import 'package:synqit/Data/Services/socket_service.dart';
import 'package:synqit/config.dart';

class SocketState {
  final ConnectionStatus connectionStatus;
  final bool isLoading;
  final String? error;
  final String? currentUserId;

  SocketState({
    this.connectionStatus = ConnectionStatus.disconnected,
    this.isLoading = false,
    this.error,
    this.currentUserId,
  });

  SocketState copyWith({
    ConnectionStatus? connectionStatus,
    bool? isLoading,
    String? error,
    String? currentUserId,
  }) {
    return SocketState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }
}

class SocketNotifier extends StateNotifier<SocketState> {
  final SocketService _socketService;
  final LocalStorageService storage;

  StreamSubscription? _connectionSubscription;
  StreamSubscription? _statusUpdateSubscription;
  
  final StreamController<ChatMessage> _messageController = StreamController<ChatMessage>.broadcast();
  Stream<ChatMessage> get messageStream => _messageController.stream;

  bool _isDisposed = false;

  SocketNotifier(
    this._socketService,
    this.storage,
  ) : super(SocketState());

  void _safeUpdateState(SocketState Function(SocketState) updater) {
    if (!_isDisposed && mounted) {
      try {
        state = updater(state);
      } catch (e) {
        log("Error updating state: $e");
      }
    }
  }

  Future<bool> initialize(String userId) async {
    if (_isDisposed) return false;

    _safeUpdateState(
        (state) => state.copyWith(isLoading: true, currentUserId: userId));

    try {
      _setupSocketListeners();
      final connected = await _socketService.connect(userId);

      if (connected) {
        log("Socket initialized successfully for user: $userId");
        _safeUpdateState(
            (state) => state.copyWith(isLoading: false, error: null));
        return true;
      } else {
        _safeUpdateState((state) => state.copyWith(
            isLoading: false, error: "Failed to connect to chat server"));
        return false;
      }
    } catch (e) {
      log("Error initializing socket: $e");
      _safeUpdateState(
          (state) => state.copyWith(isLoading: false, error: e.toString()));
      return false;
    }
  }

  void _setupSocketListeners() {
    if (_isDisposed) return;

    _connectionSubscription?.cancel();
    _statusUpdateSubscription?.cancel();
    
    _socketService.messageStream.listen((message) {
      if (!_isDisposed) {
        log("New message received: ${message.messageText} from ${message.senderId}");
        _messageController.add(message);
        
        if (message.senderId != state.currentUserId) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!_isDisposed) {
              _socketService.updateMessageStatus(
                  message.messageId, MessageStatus.seen);
            }
          });
        }
      }
    });

    _connectionSubscription = _socketService.connectionStatus.listen((status) {
      if (!_isDisposed) {
        log("Connection status changed: $status");
        _safeUpdateState((state) => state.copyWith(connectionStatus: status));
      }
    });

    _statusUpdateSubscription = _socketService.statusUpdateStream.listen((update) {
      if (!_isDisposed) {
        final messageId = update['message_id'];
        final status = update['status'];
        final userId = update['user_id'];

        if (messageId != null && status != null) {
          log("Status update: Message $messageId -> $status by $userId");
        }
      }
    });
  }

  Stream<ChatMessage> messageStreamForConversation(String conversationId) {
    return messageStream.where((msg) => msg.conversationId == conversationId);
  }

  Future<bool> sendMessage(String conversationId, String messageText, String messageId, String type) async {
    if (_isDisposed || state.currentUserId == null) {
      log("Cannot send message - disposed or no current user");
      return false;
    }

    try {
      await _socketService.sendMessage(conversationId, messageText, messageId, type);
      return true;
    } catch (e) {
      log("Failed to send message: $e");
      return false;
    }
  }

  void disconnect() {
    log("Disconnecting chat service");
    _socketService.disconnect();
    _connectionSubscription?.cancel();
    _statusUpdateSubscription?.cancel();
    _safeUpdateState((state) =>
        state.copyWith(connectionStatus: ConnectionStatus.disconnected));
  }

  @override
  void dispose() {
    log("Disposing SocketNotifier");
    _isDisposed = true;
    disconnect();
    _messageController.close();
    _socketService.dispose();
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

final socketProvider = StateNotifierProvider<SocketNotifier, SocketState>((ref) {
  final socketService = ref.watch(socketServiceProvider);
  final storage = ref.watch(localStorageProvider);

  ref.onDispose(() {
    socketService.disconnect();
  });

  return SocketNotifier(socketService, storage);
});