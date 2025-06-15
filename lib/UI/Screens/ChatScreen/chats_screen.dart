import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Models/message_model.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Provider/ChatProvider/conversation_detail_provider.dart';
import 'package:synqit/Provider/ChatProvider/conversation_provider.dart';
import 'package:synqit/Provider/UserProvider/user_provider.dart';
import 'package:synqit/Provider/UserProvider/user_search_provider.dart';
import 'package:synqit/UI/Screens/ChatScreen/Widgets/status_helper.dart';
import 'package:synqit/Utils/snackbar.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounce;

  void _onSearchTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchQuery != value.trim() && mounted) {
        setState(() {
          _searchQuery = value.trim();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider).value;
    final conversationState = ref.watch(conversationProvider);
    final userSearchAsyncValue = ref.watch(userSearchProvider(_searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 10),
            child: ClipOval(
              child: user?.profilePic != null
                  ? CachedNetworkImage(
                      imageUrl: user?.profilePic ?? '',
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.account_circle, size: 40),
                    )
                  : const Icon(Icons.account_circle, size: 40),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildSearchBar(),
          Expanded(
            child: _searchQuery.isNotEmpty
                ? _buildUserSearchResults(userSearchAsyncValue, user)
                : _buildConversationsList(conversationState, user),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white70,
          onChanged: _onSearchTextChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            border: InputBorder.none,
            hintText: "Search users...",
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear,
                        color: Colors.white.withValues(alpha: 0.8)),
                    onPressed: () {
                      _searchController.clear();
                      _debounce?.cancel();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildUserSearchResults(
      AsyncValue<UserSearchResult> userSearchAsyncValue,
      UserModel? currentUser) {
    return userSearchAsyncValue.when(
      loading: () => ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => _buildUserItemSkeleton()),
      error: (error, _) => _buildErrorState('Error searching users: $error'),
      data: (usersResult) {
        if (usersResult.count == 0) {
          return Center(
            child: Text(
              "No users found for '$_searchQuery'",
              style: const TextStyle(color: Colors.white54),
            ),
          );
        }

        final users = usersResult.users.where((user) {
          return user["id"] != currentUser?.id;
        }).toList();

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Colors.primaries[index % Colors.primaries.length],
                child: user["profile_pic"] != null
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: user["profile_pic"]!,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      )
                    : Icon(Icons.person,
                        color: Colors.white.withValues(alpha: 0.6)),
              ),
              title: Text(user["name"] ?? 'Unknown'),
              subtitle: Text("@${user["username"] ?? ''}"),
              onTap: () => _onpressed(currentUser!.id, user),
            );
          },
        );
      },
    );
  }

  void _onpressed(
      String currentUserId, Map<String, dynamic> otherUserMap) async {
    if (currentUserId.isEmpty) return;
    final otherUser = UserModel.fromMap(otherUserMap);

    final conversationId =
        await ref.read(conversationProvider.notifier).getOrCreateConversation(
      participants: [currentUserId, otherUser.id],
      conversationName: otherUser.name,
      isGroup: false,
    );

    if (!mounted) return;

    if (conversationId != null) {
      context.pushNamed(
        'chat',
        pathParameters: {'conversationId': conversationId},
        extra: otherUser,
      );
    } else {
      showSnackBar(
          context: context,
          message: 'Failed to create conversation',
          icon: const Icon(Icons.voice_over_off_rounded));
    }
  }

  Widget _buildConversationsList(
      ConversationsState conversationState, UserModel? user) {
    return Builder(
      builder: (context) {
        if (conversationState.loadingState ==
                ConversationLoadingState.loading &&
            conversationState.conversations.isEmpty) {
          return _buildLoadingConversations();
        } else if (conversationState.error != null) {
          return _buildErrorState(conversationState.error.toString());
        } else if (conversationState.conversations.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }

        final conversations = conversationState.conversations;
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(conversationProvider.notifier).fetchConversations();
          },
          child: ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              final conversationDetail =
                  ref.watch(conversationDetailProvider(conversation));

              if (conversationDetail.isLoading) {
                return _buildUserItemSkeleton();
              } else if (conversationDetail.error != null) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.error)),
                  title: Text('Error: ${conversationDetail.error}'),
                  subtitle: const Text('Could not load details'),
                );
              }

              final receiver = conversationDetail.receiver;
              final lastMessage = conversationDetail.lastMessage;
              final isMyMessage = lastMessage?.senderId == user?.id;
              final status = lastMessage?.status ?? MessageStatus.delivered;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: receiver?.profilePic != null
                      ? CachedNetworkImageProvider(receiver!.profilePic!)
                      : null,
                  child: receiver?.profilePic == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                title: Text(receiver?.name ?? 'Unknown User'),
                subtitle: _buildLastMessage(isMyMessage, lastMessage, status),
                onTap: () {
                  context.pushNamed(
                    'chat',
                    pathParameters: {
                      'conversationId': conversation.conversationId
                    },
                    extra: receiver,
                  );
                },
                trailing: lastMessage != null
                    ? Text(
                        '${lastMessage.createdAt.toLocal().hour}:${lastMessage.createdAt.toLocal().minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 12),
                      )
                    : null,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLastMessage(
      bool isMyMessage, ChatMessage? lastMessage, MessageStatus status) {
    String lastMessageText;
    bool isTrack = false;

    if (lastMessage == null) {
      lastMessageText = 'No messages yet';
    } else {
      try {
        final track = Track.fromJson(jsonDecode(lastMessage.messageText));
        lastMessageText = "${track.trackName} by ${track.artistName}";
        isTrack = true;
      } catch (e) {
        lastMessageText = lastMessage.messageText;
      }
    }

    return isMyMessage
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isTrack ? Icons.music_note : Status.getIcon(status),
                  size: 16),
              const SizedBox(width: 4),
              Flexible(
                child: Text(lastMessageText,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              )
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isTrack) const Icon(Icons.music_note, size: 16),
              const SizedBox(width: 4),
              Flexible(
                child: Text(lastMessageText,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              )
            ],
          );
  }

  Widget _buildLoadingConversations() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => _buildUserItemSkeleton(),
      ),
    );
  }

  Widget _buildUserItemSkeleton() {
    return const Skeletonizer(
      child: ListTile(
        leading: CircleAvatar(radius: 20),
        title: Text('Loading user name'),
        subtitle: Text('Loading message preview...'),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48.0, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error loading conversations',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(conversationProvider.notifier)
                  .fetchConversations();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
