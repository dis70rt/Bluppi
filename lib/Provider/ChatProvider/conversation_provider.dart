import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Data/Models/conversation_model.dart';
import 'package:bluppi/Data/Services/local_storage_service_sql.dart';
import 'package:bluppi/Provider/ChatProvider/socket_provider.dart';
import 'package:dio/dio.dart';

enum ConversationLoadingState { initial, loading, loaded, error }

class ConversationsState {
  final List<Conversation> conversations;
  final ConversationLoadingState loadingState;
  final bool isLoading;
  final String? error;

  ConversationsState({
    this.conversations = const [],
    this.loadingState = ConversationLoadingState.initial,
    this.isLoading = false,
    this.error,
  });

  ConversationsState copyWith({
    List<Conversation>? conversations,
    ConversationLoadingState? loadingState,
    bool? isLoading,
    String? error,
  }) {
    return ConversationsState(
      conversations: conversations ?? this.conversations,
      loadingState: loadingState ?? this.loadingState,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ConversationNotifier extends StateNotifier<ConversationsState> {
  final LocalStorageService _storage;
  final Dio _dio;
  final String _currentUserId;

  ConversationNotifier(
    this._storage,
    this._dio,
    this._currentUserId,
  ) : super(ConversationsState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    state = state.copyWith(loadingState: ConversationLoadingState.loading);
    
    try {
      final localConversations = await _storage.loadConversations();
      
      if (localConversations.isNotEmpty) {
        state = state.copyWith(
          conversations: localConversations,
          loadingState: ConversationLoadingState.loaded,
        );
      }
      
      await fetchConversations();
    } catch (e) {
      log("Error initializing conversations: $e");
      state = state.copyWith(
        loadingState: ConversationLoadingState.error,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchConversations() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      final response = await _dio.get(
        '/$_currentUserId/conversations/',
      );

      if (response.statusCode == 200) {
        final data = response.data['conversations'] as List;
        final fetchedConversations = data.map((d) => Conversation(
              conversationId: d['conversation_id'],
              conversationName: d['conversation_name'] ?? '',
              isGroup: d['is_group'] ?? false,
              participants: List<String>.from(d['participants'] ?? []),
              lastActivity: d['last_activity'] != null 
                  ? DateTime.parse(d['last_activity']) 
                  : DateTime.now(),
            )).toList();

        await _storage.saveConversations(fetchedConversations);
        
        state = state.copyWith(
          conversations: fetchedConversations,
          loadingState: ConversationLoadingState.loaded,
          isLoading: false,
        );
      } else {
        throw Exception("Failed to fetch conversations: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching conversations: $e");
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        loadingState: ConversationLoadingState.error,
      );
    }
  }

  Future<String?> getOrCreateConversation({
    required List<String> participants,
    required String conversationName,
    bool isGroup = false,
  }) async {
    if (state.isLoading) return null;
    
    state = state.copyWith(isLoading: true);
    
    try {
      if (!isGroup) {
        for (final conversation in state.conversations) {
          if (!conversation.isGroup &&
              conversation.participants.length == participants.length &&
              conversation.participants.toSet().containsAll(participants)) {
            state = state.copyWith(isLoading: false);
            return conversation.conversationId;
          }
        }
      }

      final response = await _dio.post(
        '/ws/v1/conversations/get-or-create',
        data: {
          'participants': participants,
          'conversation_name': conversationName,
          'is_group': isGroup,
        },
      );

      if (response.statusCode == 200) {
        final conversationId = response.data['conversation_id'];
        final isNew = response.data['is_new'] ?? false;

        if (isNew || !state.conversations.any((c) => c.conversationId == conversationId)) {
          final conversation = Conversation(
            conversationId: conversationId,
            conversationName: conversationName,
            isGroup: isGroup,
            participants: participants,
            lastActivity: DateTime.now(),
          );

          final updatedConversations = [...state.conversations, conversation];
          await _storage.saveConversations(updatedConversations);

          state = state.copyWith(
            conversations: updatedConversations,
            isLoading: false,
          );
        } else {
          state = state.copyWith(isLoading: false);
        }

        return conversationId;
      } else {
        throw Exception("Failed to get or create conversation: ${response.statusCode}");
      }
    } catch (e) {
      log("Error getting or creating conversation: $e");
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return null;
    }
  }

  void updateConversationActivity(String conversationId, DateTime lastActivity) {
    final index = state.conversations.indexWhere((c) => c.conversationId == conversationId);
    if (index != -1) {
      final conversation = state.conversations[index];
      final updatedConversation = conversation.copyWith(lastActivity: lastActivity);
      
      final updatedConversations = [...state.conversations];
      updatedConversations[index] = updatedConversation;
      
      updatedConversations.sort((a, b) => b.lastActivity!.compareTo(a.lastActivity!));
      
      state = state.copyWith(conversations: updatedConversations);
    }
  }
}

final conversationProvider = StateNotifierProvider<ConversationNotifier, ConversationsState>((ref) {
  final storage = ref.watch(localStorageProvider);
  final dio = ref.watch(dioProvider);
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  
  if (currentUserId == null) {
    throw Exception("Cannot create conversation provider: User is not logged in");
  }
  
  return ConversationNotifier(storage, dio, currentUserId);
});