import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/chat_provider/conversation_provider.dart';
import 'package:synqit/Provider/user_provider/user_provider.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider).value;
    final conversationState = ref.watch(conversationProvider);
    final userService = UserServices();

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
      body: Builder(
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
              await ref
                  .read(conversationProvider.notifier)
                  .fetchConversations();
            },
            child: ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];

                final participants =
                    List<String>.from(conversation.participants);
                String receiverId = '';
                if (participants.isNotEmpty) {
                  if (participants.length == 1) {
                    receiverId = participants.first;
                  } else {
                    receiverId = participants.firstWhere(
                      (id) => id != user?.id,
                      orElse: () => participants.first,
                    );
                  }
                }

                return FutureBuilder(
                  future: userService.getUserByID(receiverId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildUserItemSkeleton();
                    } else if (snapshot.hasError) {
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.error),
                        ),
                        title: Text('Error: ${snapshot.error}'),
                        subtitle: const Text('Could not load user data'),
                      );
                    } else if (!snapshot.hasData) {
                      return const ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text('Unknown User'),
                        subtitle: Text('No messages yet'),
                      );
                    }

                    final user = snapshot.data!;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: user.profilePic != null
                            ? CachedNetworkImageProvider(user.profilePic!)
                            : null,
                        child: user.profilePic == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(user.name),
                      subtitle: const Text('No messages yet'),
                      onTap: () async {
                        context.pushNamed(
                          'chat',
                          pathParameters: {
                            'conversationId': conversation.conversationId
                          },
                          extra: user,
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
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
    return const ListTile(
      leading: CircleAvatar(radius: 20),
      title: Text('Loading user name'),
      subtitle: Text('Loading message preview...'),
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
}
