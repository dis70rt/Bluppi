import 'dart:developer';
import 'dart:ui';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Data/Models/live_chat_model.dart';
import 'package:bluppi/Provider/MqttProvider/mqtt_provider.dart';
import 'package:bluppi/Provider/MusicProvider/current_track_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LiveChatScreen extends ConsumerStatefulWidget {
  final String roomId;
  final ChatUser currentUser;

  const LiveChatScreen({
    super.key,
    required this.roomId,
    required this.currentUser,
  });

  @override
  ConsumerState<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends ConsumerState<LiveChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(liveChatServiceProvider.notifier).connect(widget.roomId);
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final liveChatService = ref.read(liveChatServiceProvider.notifier);
    final isConnected = ref.read(liveChatServiceProvider).isConnected;

    if (!isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not connected to chat')),
      );
      return;
    }

    liveChatService.sendMessage(text, widget.currentUser);
    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildBackgroundImage(String? currentImage) {
    if (currentImage == null) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              AppColors.backgroundDark
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              key: ValueKey(currentImage),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(currentImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Colors.transparent
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(liveChatServiceProvider);
    final messages = ref.watch(chatMessagesProvider);
    final currentImage = ref
        .watch(currentTrackProvider)
        ?.imageUrl
        .replaceFirstMapped(RegExp(r"w\d+-h\d+"), (match) => 'w512-h512');
    
    log('Current Image: $currentImage');

    return Stack(
      children: [
        _buildBackgroundImage(currentImage),
        Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        'No messages yet',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMyMessage =
                            message.sender.id == widget.currentUser.id;

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 350),
                          child: SlideAnimation(
                            horizontalOffset: isMyMessage ? 20.0 : -20.0,
                            curve: Curves.elasticOut,
                            child: FadeInAnimation(
                              child: ScaleAnimation(
                                scale: 0.9,
                                child: _buildMessageItem(message, isMyMessage),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            _buildMessageInput(chatState.isConnected),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageItem(LiveChatModel message, bool isMyMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMyMessage) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade700,
              backgroundImage: message.sender.profileUrl.isNotEmpty
                  ? CachedNetworkImageProvider(message.sender.profileUrl)
                  : null,
              child: message.sender.profileUrl.isEmpty
                  ? const Icon(Icons.person, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMyMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isMyMessage)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      message.sender.name,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isMyMessage
                        ? AppColors.accent.withValues(alpha: 0.9)
                        : Colors.grey.shade800.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMyMessage) ...[
            // const SizedBox(width: 8),
            // CircleAvatar(
            //   radius: 16,
            //   backgroundColor: Colors.grey.shade700,
            //   backgroundImage: widget.currentUser.profileUrl.isNotEmpty
            //       ? CachedNetworkImageProvider(widget.currentUser.profileUrl)
            //       : null,
            //   child: widget.currentUser.profileUrl.isEmpty
            //       ? const Icon(Icons.person, color: Colors.white, size: 16)
            //       : null,
            // ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(bool isConnected) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: bottomPadding > 0 ? bottomPadding : 16,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        // border: Border(
        //   top: BorderSide(color: Colors.white.withValues(alpha:0.1)),
        // ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                enabled: isConnected,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: isConnected ? 'Type a message...' : 'Connecting...',
                  hintStyle: const TextStyle(color: Colors.white60),
                  fillColor: Colors.white.withValues(alpha: 0.1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: isConnected ? (_) => _sendMessage() : null,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color:
                    isConnected ? AppColors.accent : Colors.grey.shade600,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
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
    _scrollController.dispose();
    ref.read(liveChatServiceProvider.notifier).disconnect();
    super.dispose();
  }
}
