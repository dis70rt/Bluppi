import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/chat_provider/socket_provider.dart';
import 'package:synqit/Provider/user_provider/user_provider.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  Future<Map<String, dynamic>?>? _conversationsFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeConversations();
    });
  }

  void _initializeConversations() {
    final user = ref.read(userProvider).value;
    if (user != null) {
      setState(() {
        _conversationsFuture =
            ref.read(socketProvider.notifier).getConversations(user.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider).value;
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
      body: _conversationsFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder(
              future: _conversationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoadingConversations();
                } else if (snapshot.hasError) {
                  return _buildErrorState(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                      child: Text('No conversations available.'));
                } else if (snapshot.data!["conversations"]?.isEmpty ?? true) {
                  return const Center(child: Text('No messages yet.'));
                }

                final conversations = snapshot.data!["conversations"];
                log("Conversations: ${conversations.length}");
                return RefreshIndicator(
                  onRefresh: () async {
                    _initializeConversations();
                  },
                  child: ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];

                      final participants =
                          List<String>.from(conversation['participants']);
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: const Text('Unknown User'),
                              subtitle: Text(conversation['lastMessage'] ??
                                  'No messages yet'),
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
                            subtitle: Text(conversation['lastMessage'] ??
                                'No messages yet'),
                            onTap: () {},
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
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
            onPressed: _initializeConversations,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
