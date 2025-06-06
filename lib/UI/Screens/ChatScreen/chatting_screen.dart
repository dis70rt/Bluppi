import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/themes.dart';

import 'package:synqit/Data/Models/message_model.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Data/Services/socket_service.dart';
import 'package:synqit/Provider/chat_provider/messages_provider.dart';
import 'package:synqit/Provider/chat_provider/socket_provider.dart';
import 'package:synqit/UI/Screens/ChatScreen/Widgets/status_helper.dart';
import 'package:synqit/UI/Screens/ChatScreen/Widgets/track_bottom_model.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/music_player.dart';
import 'package:synqit/Utils/snackbar.dart';

class ChattingScreen extends ConsumerStatefulWidget {
  final String conversationId;
  final UserModel user;

  const ChattingScreen(
      {super.key, required this.conversationId, required this.user});

  @override
  ConsumerState<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends ConsumerState<ChattingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentUserId != null) {
        ref
            .read(conversationSocketProvider(widget.conversationId).notifier)
            .connect(currentUserId!);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !ref.read(messageProvider(widget.conversationId)).isLoadingMore) {
      _loadMoreMessages();
    }
  }

  Future<void> _loadMoreMessages() async {
    final messagesState = ref.read(messageProvider(widget.conversationId));
    if (messagesState.messages.isEmpty) return;

    await ref
        .read(messageProvider(widget.conversationId).notifier)
        .loadMoreMessages(
            beforeId: messagesState.messages.isNotEmpty
                ? messagesState.messages.first.messageId
                : null);
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final connectionStatus =
        ref.read(conversationSocketProvider(widget.conversationId)).status;
    if (connectionStatus != ConnectionStatus.connected) {
      showSnackBar(
          context: context,
          message: "Not connected to chat server",
          icon: const Icon(Icons.cloud_off_rounded));
      return;
    }

    ref.read(messageProvider(widget.conversationId).notifier).sendMessage(text);
    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final socketState =
        ref.watch(conversationSocketProvider(widget.conversationId));
    final connectionStatus = socketState.status;
    final messagesState = ref.watch(messageProvider(widget.conversationId));
    final messages = messagesState.messages;
    final isLoadingMore = messagesState.isLoadingMore;
    final user = widget.user;

    final chatTheme = ref.watch(chatThemeProvider(widget.conversationId));

    return Stack(
      children: [
        Image.asset(
          chatTheme.backgroundImage,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: chatTheme.background,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: chatTheme.appBarBackground,
              foregroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              titleSpacing: 0,
              title: Row(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey.shade700,
                          child: user.profilePic != null
                              ? CachedNetworkImage(
                                  imageUrl: user.profilePic!, fit: BoxFit.cover)
                              : const Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Status.getColor(connectionStatus),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text("@${user.username}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: PopupMenuButton<ThemeType>(
                    icon: Icon(
                      Icons.color_lens,
                      color: chatTheme.themeIcon,
                    ),
                    onSelected: (ThemeType themeType) {
                      ref
                          .read(
                              chatThemeProvider(widget.conversationId).notifier)
                          .setTheme(themeType);
                    },
                    itemBuilder: (BuildContext context) {
                      final themeNames = chatTheme.themeNames;
                      return chatTheme.availableThemes
                          .map((themeType) => PopupMenuItem<ThemeType>(
                                value: themeType,
                                child: Text(themeNames[themeType] ?? ''),
                              ))
                          .toList();
                    },
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: messages.isEmpty &&
                          messagesState.loadingState ==
                              MessageLoadingState.loading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : messages.isEmpty
                          ? const Center(
                              child: Text('No messages yet',
                                  style: TextStyle(color: Colors.white70)),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              reverse: true,
                              itemCount:
                                  messages.length + (isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (isLoadingMore && index == 0) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                          color: Colors.green),
                                    ),
                                  );
                                }

                                final actualIndex =
                                    isLoadingMore ? index - 1 : index;
                                final message =
                                    messages[messages.length - 1 - actualIndex];
                                final isMyMessage =
                                    message.senderId == currentUserId;

                                final isFirstMessageFromSender =
                                    actualIndex == 0 ||
                                        messages[messages.length - actualIndex]
                                                .senderId !=
                                            message.senderId;

                                return _buildMessageItem(message, isMyMessage,
                                    isFirstMessageFromSender);
                              },
                            ),
                ),
                _buildMessageInput(connectionStatus),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageItem(
      ChatMessage message, bool isMyMessage, bool showSenderName) {
    final chatTheme = ref.watch(chatThemeProvider(widget.conversationId));


    if (message.type == MessageType.track) {
      try {
        final trackJson = jsonDecode(message.messageText);
        final track = Track.fromJson(trackJson);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment:
                isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MiniMusicPlayer(track: track, isPreview: true),
                    Row(
                      mainAxisAlignment: isMyMessage
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            fontSize: 11,
                            color: chatTheme.receivedTimestamp,
                          ),
                          child: Text(
                            '${message.createdAt.toLocal().hour}:${message.createdAt.toLocal().minute.toString().padLeft(2, '0')}',
                          ),
                        ),
                        if (isMyMessage) ...[
                          const SizedBox(width: 4),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: chatTheme.receivedTimestamp,
                            ),
                            child: Icon(
                              Status.getIcon(message.status),
                              size: 12,
                              color: chatTheme.receivedTimestamp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } catch (e) {
        log("Error parsing track message: $e");
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment:
            isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: isMyMessage
                    ? chatTheme.userBubble
                    : chatTheme.receivedBubble,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: isMyMessage
                          ? chatTheme.userText
                          : chatTheme.receivedText,
                    ),
                    child: Text(message.messageText),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMyMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: 11,
                          color: isMyMessage
                              ? chatTheme.timestamp
                              : chatTheme.receivedTimestamp,
                        ),
                        child: Text(
                          '${message.createdAt.toLocal().hour}:${message.createdAt.toLocal().minute.toString().padLeft(2, '0')}',
                        ),
                      ),
                      if (isMyMessage) ...[
                        const SizedBox(width: 4),
                        AnimatedIcon(
                          duration: const Duration(milliseconds: 300),
                          icon: Status.getIcon(message.status),
                          size: 12,
                          color: chatTheme.timestamp,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMyMessage) ...[
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(ConnectionStatus connectionStatus) {
    final chatTheme = ref.watch(chatThemeProvider(widget.conversationId));
    final isConnected = connectionStatus == ConnectionStatus.connected;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Colors.transparent,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                enabled: isConnected,
                style: const TextStyle(color: ChatThemeState.inputText),
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            scrollControlDisabledMaxHeightRatio: 0.8,
                            builder: (context) {
                              return trackSearchBottomSheet((track) {
                                final trackMessageText =
                                    jsonEncode(track.toJson());

                                ref
                                    .read(messageProvider(widget.conversationId)
                                        .notifier)
                                    .sendMessage(
                                      trackMessageText,
                                      messageType: MessageType.track,
                                    );
                              });
                            });
                      },
                      icon: Icon(Icons.my_library_music,
                          color: Colors.grey.shade700)),
                  hintText:
                      isConnected ? 'Type your message...' : 'Connecting...',
                  hintStyle: TextStyle(color: ChatThemeState.inputHint),
                  fillColor: ChatThemeState.inputBackground,
                  filled: true,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: isConnected ? (_) => _sendMessage() : null,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: isConnected ? chatTheme.sendButton : Colors.grey,
                ),
                onPressed: isConnected ? _sendMessage : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}

class AnimatedIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final Duration duration;

  const AnimatedIcon({
    Key? key,
    required this.icon,
    required this.size,
    required this.color,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: duration,
      style: TextStyle(color: color),
      child: Icon(icon, size: size, color: color),
    );
  }
}
