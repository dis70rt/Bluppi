import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synqit/Data/Models/conversation_model.dart';
import 'package:synqit/Data/Models/message_model.dart';
import 'package:synqit/Data/Services/socket_service.dart';
import 'package:synqit/config.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ChatState {
  final Map<String, List<ChatMessage>> messages;
  final List<Conversation> conversations;
  final ConnectionStatus connectionStatus;
  final bool isLoading;
  final String? error;
  final String? currentUserId;

  ChatState({
    this.messages = const {},
    this.conversations = const [],
    this.connectionStatus = ConnectionStatus.disconnected,
    this.isLoading = false,
    this.error,
    this.currentUserId,
  });

  ChatState copyWith({
    Map<String, List<ChatMessage>>? messages,
    List<Conversation>? conversations,
    ConnectionStatus? connectionStatus,
    bool? isLoading,
    String? error,
    String? currentUserId,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      conversations: conversations ?? this.conversations,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }
}

class PersistentStorageService {
  static const String _messagesDir = 'messages';
  static const String _conversationsFile = 'conversations.json';

  Directory? _appDir;

  Future<void> _ensureInitialized() async {
    if (_appDir == null) {
      _appDir = await getApplicationDocumentsDirectory();
      final messagesDir = Directory('${_appDir!.path}/$_messagesDir');
      if (!await messagesDir.exists()) {
        await messagesDir.create(recursive: true);
      }
    }
  }

  Future<void> saveMessage(ChatMessage message) async {
    await _ensureInitialized();
    try {
      final file =
          File('${_appDir!.path}/$_messagesDir/${message.conversationId}.json');

      List<Map<String, dynamic>> messages = [];
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          messages = List<Map<String, dynamic>>.from(jsonDecode(content));
        }
      }

      if (!messages.any((m) => m['messageId'] == message.messageId)) {
        messages.add(message.toJson());
        messages.sort((a, b) => DateTime.parse(a['createdAt'])
            .compareTo(DateTime.parse(b['createdAt'])));
        await file.writeAsString(jsonEncode(messages));
        log("Message saved to ${file.path}");
      }
    } catch (e) {
      log("Error saving message: $e");
    }
  }

  Future<List<ChatMessage>> loadMessages(String conversationId) async {
    await _ensureInitialized();
    try {
      final file = File('${_appDir!.path}/$_messagesDir/$conversationId.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          final List<dynamic> data = jsonDecode(content);
          return data.map((json) => ChatMessage.fromJson(json)).toList();
        }
      }
    } catch (e) {
      log("Error loading messages: $e");
    }
    return [];
  }

  Future<void> saveConversations(List<Conversation> conversations) async {
    await _ensureInitialized();
    try {
      final file = File('${_appDir!.path}/$_conversationsFile');
      final data = conversations.map((c) => c.toJson()).toList();
      await file.writeAsString(jsonEncode(data));
      log("Conversations saved");
    } catch (e) {
      log("Error saving conversations: $e");
    }
  }

  Future<List<Conversation>> loadConversations() async {
    await _ensureInitialized();
    try {
      final file = File('${_appDir!.path}/$_conversationsFile');
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          final List<dynamic> data = jsonDecode(content);
          return data.map((json) => Conversation.fromJson(json)).toList();
        }
      }
    } catch (e) {
      log("Error loading conversations: $e");
    }
    return [];
  }

  Future<void> updateMessageStatus(
      String messageId, String conversationId, MessageStatus status) async {
    await _ensureInitialized();
    try {
      final file = File('${_appDir!.path}/$_messagesDir/$conversationId.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          List<Map<String, dynamic>> messages =
              List<Map<String, dynamic>>.from(jsonDecode(content));
          final index = messages.indexWhere((m) => m['messageId'] == messageId);
          if (index != -1) {
            messages[index]['status'] = status.name;
            await file.writeAsString(jsonEncode(messages));
            log("Message status updated: $messageId -> ${status.name}");
          }
        }
      }
    } catch (e) {
      log("Error updating message status: $e");
    }
  }
}

class SocketNotifier extends StateNotifier<ChatState> {
  final SocketService _socketService;
  final PersistentStorageService _storage;
  final Dio _dio;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _connectionSubscription;
  StreamSubscription? _statusUpdateSubscription;

  final Map<String, ChatMessage> _pendingMessages = {};
  bool _isDisposed = false;

  SocketNotifier(
    this._socketService,
    this._storage,
    this._dio,
  ) : super(ChatState());

  void _safeUpdateState(ChatState Function(ChatState) updater) {
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
      await _loadLocalData();

      _setupSocketListeners();

      final connected = await _socketService.connect(userId);

      if (connected) {
        log("Chat initialized successfully for user: $userId");
        _safeUpdateState(
            (state) => state.copyWith(isLoading: false, error: null));
        return true;
      } else {
        _safeUpdateState((state) => state.copyWith(
            isLoading: false, error: "Failed to connect to chat server"));
        return false;
      }
    } catch (e) {
      log("Error initializing chat: $e");
      _safeUpdateState(
          (state) => state.copyWith(isLoading: false, error: e.toString()));
      return false;
    }
  }

  void _setupSocketListeners() {
    if (_isDisposed) return;

    _messageSubscription?.cancel();
    _connectionSubscription?.cancel();
    _statusUpdateSubscription?.cancel();

    _messageSubscription = _socketService.messageStream.listen((message) {
      if (!_isDisposed) {
        log("New message received: ${message.messageText} from ${message.senderId}");
        _handleNewMessage(message);
      }
    });

    _connectionSubscription = _socketService.connectionStatus.listen((status) {
      if (!_isDisposed) {
        log("Connection status changed: $status");
        _safeUpdateState((state) => state.copyWith(connectionStatus: status));
      }
    });

    _statusUpdateSubscription =
        _socketService.statusUpdateStream.listen((update) {
      if (!_isDisposed) {
        _handleStatusUpdate(update);
      }
    });
  }

  Future<void> _loadLocalData() async {
    if (_isDisposed) return;

    try {
      final conversations = await _storage.loadConversations();
      log("Loaded ${conversations.length} conversations from storage");

      final Map<String, List<ChatMessage>> allMessages = {};
      for (final conversation in conversations) {
        final messages =
            await _storage.loadMessages(conversation.conversationId);
        allMessages[conversation.conversationId] = messages;
        log("Loaded ${messages.length} messages for conversation ${conversation.conversationId}");
      }

      _safeUpdateState((state) => state.copyWith(
            conversations: conversations,
            messages: allMessages,
          ));
    } catch (e) {
      log("Error loading local data: $e");
    }
  }

  void _handleNewMessage(ChatMessage message) {
    if (_isDisposed) return;

    _addMessageToState(message);
    _storage.saveMessage(message);

    if (message.senderId != state.currentUserId) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!_isDisposed) {
          _socketService.updateMessageStatus(
              message.messageId, MessageStatus.seen);
        }
      });
    }
  }

  void _addMessageToState(ChatMessage message) {
    if (_isDisposed) return;

    _safeUpdateState((currentState) {
      final messagesMap =
          Map<String, List<ChatMessage>>.from(currentState.messages);
      final conversationMessages =
          List<ChatMessage>.from(messagesMap[message.conversationId] ?? []);

      if (conversationMessages.any((m) => m.messageId == message.messageId)) {
        log("Duplicate message ignored: ${message.messageId}");
        return currentState;
      }

      conversationMessages.add(message);
      conversationMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      messagesMap[message.conversationId] = conversationMessages;

      final conversations = List<Conversation>.from(currentState.conversations);
      final convIndex = conversations
          .indexWhere((c) => c.conversationId == message.conversationId);
      if (convIndex != -1) {
        conversations[convIndex] =
            conversations[convIndex].copyWith(lastActivity: message.createdAt);
      }

      log("Message added to state: ${message.messageText}");

      return currentState.copyWith(
        messages: messagesMap,
        conversations: conversations,
      );
    });
  }

  void _handleStatusUpdate(Map<String, dynamic> update) {
    if (_isDisposed) return;

    final messageId = update['message_id'];
    final status = update['status'];
    final userId = update['user_id'];

    if (messageId != null && status != null) {
      log("Status update: Message $messageId -> $status by $userId");
    }
  }

  Future<bool> sendMessage(String conversationId, String messageText) async {
    if (_isDisposed || state.currentUserId == null) {
      log("Cannot send message - disposed or no current user");
      return false;
    }

    final messageId = const Uuid().v4();
    final now = DateTime.now();

    final pendingMessage = ChatMessage(
      messageId: messageId,
      senderId: state.currentUserId!,
      conversationId: conversationId,
      messageText: messageText,
      createdAt: now,
      status: MessageStatus.pending,
    );

    _pendingMessages[messageId] = pendingMessage;
    _addMessageToState(pendingMessage);
    await _storage.saveMessage(pendingMessage);

    try {
      await _socketService.sendMessage(conversationId, messageText, messageId);

      if (_isDisposed) return false;

      final sentMessage = pendingMessage.copyWith(status: MessageStatus.sent);
      _updateMessageInState(sentMessage);
      await _storage.updateMessageStatus(
          messageId, conversationId, MessageStatus.sent);

      log("Message sent successfully: $messageText");
      return true;
    } catch (e) {
      log("Failed to send message: $e");

      if (_isDisposed) return false;

      final failedMessage =
          pendingMessage.copyWith(status: MessageStatus.failed);
      _updateMessageInState(failedMessage);
      await _storage.updateMessageStatus(
          messageId, conversationId, MessageStatus.failed);

      _safeUpdateState((state) =>
          state.copyWith(error: "Failed to send message: ${e.toString()}"));
      return false;
    } finally {
      _pendingMessages.remove(messageId);
    }
  }

  void _updateMessageInState(ChatMessage updatedMessage) {
    if (_isDisposed) return;

    _safeUpdateState((currentState) {
      final messagesMap =
          Map<String, List<ChatMessage>>.from(currentState.messages);
      final conversationMessages = List<ChatMessage>.from(
          messagesMap[updatedMessage.conversationId] ?? []);

      final index = conversationMessages
          .indexWhere((m) => m.messageId == updatedMessage.messageId);
      if (index != -1) {
        conversationMessages[index] = updatedMessage;
        messagesMap[updatedMessage.conversationId] = conversationMessages;
        return currentState.copyWith(messages: messagesMap);
      }
      return currentState;
    });
  }

  // Future<Conversation?> createConversation({
  //   required List<String> participants,
  //   String? conversationName,
  //   bool isGroup = false,
  // }) async {
  //   if (_isDisposed) return null;

  //   _safeUpdateState((state) => state.copyWith(isLoading: true));

  //   try {
  //     final response = await _dio.post(
  //       'https://socket.saikat.in/ws/v1/conversations',
  //       data: {
  //         'participants': participants,
  //         'conversation_name': conversationName,
  //         'is_group': isGroup,
  //       },
  //     );

  //     if (_isDisposed) return null;

  //     if (response.statusCode == 200) {
  //       final conversationId = response.data['conversation_id'];
  //       final conversation = Conversation(
  //         conversationId: conversationId,
  //         conversationName: conversationName,
  //         isGroup: isGroup,
  //         participants: participants,
  //         lastActivity: DateTime.now(),
  //       );

  //       final updatedConversations = [...state.conversations, conversation];
  //       await _storage.saveConversations(updatedConversations);

  //       _safeUpdateState((state) => state.copyWith(
  //             conversations: updatedConversations,
  //             isLoading: false,
  //           ));

  //       log("Conversation created: $conversationId");
  //       return conversation;
  //     }
  //   } catch (e) {
  //     log("Error creating conversation: $e");
  //     _safeUpdateState(
  //         (state) => state.copyWith(error: e.toString(), isLoading: false));
  //   }

  //   _safeUpdateState((state) => state.copyWith(isLoading: false));
  //   return null;
  // }

  // Future<String?> checkConversationExists(List<String> participants) async {
  //   if (_isDisposed) return null;

  //   try {
  //     final response = await _dio.get(
  //       'https://socket.saikat.in/conversations',
  //       queryParameters: {
  //         'participants': participants,
  //       },
  //     );

  //     if (response.statusCode == 404) {
  //       return null;
  //     }

  //     if (response.statusCode == 200) {
  //       final conversationId = response.data['conversation_id'];
  //       return conversationId;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     log("Error checking conversation existence: $e");
  //     return null;
  //   }
  // }

  Future<List<ChatMessage>> loadMoreMessages(String conversationId,
      {String? beforeId}) async {
    if (_isDisposed) return [];

    try {
      final response = await _dio.get(
        'https://socket.saikat.in/conversations/$conversationId/messages',
        queryParameters: {
          if (beforeId != null) 'before_id': beforeId,
          'limit': 20,
        },
      );

      if (_isDisposed) return [];

      final data = response.data['messages'] as List;
      final messages = data
          .map((d) => ChatMessage(
                messageId: d['message_id'],
                senderId: d['sender_id'],
                conversationId: conversationId,
                messageText: d['message_text'],
                createdAt: DateTime.parse(d['created_at']),
                status: MessageStatus.delivered,
              ))
          .toList();

      for (final message in messages) {
        await _storage.saveMessage(message);
      }

      if (!_isDisposed) {
        _safeUpdateState((currentState) {
          final messagesMap =
              Map<String, List<ChatMessage>>.from(currentState.messages);
          final existingMessages = messagesMap[conversationId] ?? [];
          final allMessages = [...existingMessages, ...messages];
          allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          messagesMap[conversationId] = allMessages;

          return currentState.copyWith(messages: messagesMap);
        });
      }

      return messages;
    } catch (e) {
      log("Error loading more messages: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getConversations(
      String userId) async {
    if (_isDisposed) return null;

    try {
      final response = await _dio.get(
        'https://socket.saikat.in/${userId}/conversations/',
      );

      log("Fetched conversations for user $userId: ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        log("Failed to fetch conversation details: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error fetching conversation details: $e");
      return null;
    }
  }

  Future<String?> getOrCreateConversation({
    required List<String> participants,
    required String conversationName,
    bool isGroup = false,
  }) async {
    if (_isDisposed) return null;

    try {
      for (final conversation in state.conversations) {
        if (!conversation.isGroup &&
            conversation.participants.length == participants.length &&
            conversation.participants.toSet().containsAll(participants)) {
          return conversation.conversationId;
        }
      }

      final response = await _dio.post(
        'https://socket.saikat.in/ws/v1/conversations/get-or-create',
        data: {
          'participants': participants,
          'conversation_name': conversationName,
          'is_group': isGroup,
        },
      );

      if (_isDisposed) return null;

      if (response.statusCode == 200) {
        final conversationId = response.data['conversation_id'];
        final isNew = response.data['is_new'] ?? false;

        if (isNew ||
            !state.conversations
                .any((c) => c.conversationId == conversationId)) {
          final conversation = Conversation(
            conversationId: conversationId,
            conversationName: conversationName,
            isGroup: isGroup,
            participants: participants,
            lastActivity: DateTime.now(),
          );

          final updatedConversations = [...state.conversations, conversation];
          await _storage.saveConversations(updatedConversations);

          _safeUpdateState((state) => state.copyWith(
                conversations: updatedConversations,
              ));
        }

        log("Retrieved conversation: $conversationId (isNew: $isNew)");
        return conversationId;
      } else {
        log("Failed to get or create conversation: ${response.statusCode}");
        _safeUpdateState((state) => state.copyWith(
            error: "Failed to get or create conversation", isLoading: false));
        return null;
      }
    } catch (e) {
      log("Error getting or creating conversation: $e");
      _safeUpdateState(
          (state) => state.copyWith(error: e.toString(), isLoading: false));
      return null;
    }
  }

  void disconnect() {
    log("Disconnecting chat service");
    _socketService.disconnect();
    _messageSubscription?.cancel();
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
    _socketService.dispose();
    super.dispose();
  }
}

final socketServiceProvider = Provider<SocketService>((ref) {
  return SocketService(baseUrl: AppConfig.socketUrl);
});

final persistentStorageProvider = Provider<PersistentStorageService>((ref) {
  return PersistentStorageService();
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
});

final socketProvider = StateNotifierProvider<SocketNotifier, ChatState>((ref) {
  final socketService = ref.watch(socketServiceProvider);
  final storage = ref.watch(persistentStorageProvider);
  final dio = ref.watch(dioProvider);

  return SocketNotifier(socketService, storage, dio);
});
