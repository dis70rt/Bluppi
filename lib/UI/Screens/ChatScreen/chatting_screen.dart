import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/message_model.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Data/Services/socket_service.dart';
import 'package:synqit/Provider/auth_provider.dart';
import 'package:synqit/Provider/chat_provider/socket_provider.dart';

class ChattingScreen extends ConsumerStatefulWidget {
  final String conversationId;
  final UserModel user;

  const ChattingScreen(
      {super.key, required this.conversationId, required this.user});

  @override
  ConsumerState<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends ConsumerState<ChattingScreen> with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _isInitialized = false;
  bool _isDisposed = false; // Add disposal flag

  String? get currentUserId => ref.read(authProvider).value?.user?.uid;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        _initializeChat();
      }
    });

    _scrollController.addListener(_onScroll);
  }

  Future<void> _initializeChat() async {
    if (_isInitialized || currentUserId == null || _isDisposed) return;
    
    try {
      final success = await ref.read(socketProvider.notifier).initialize(currentUserId!);
      if (!_isDisposed) {
        if (success) {
          setState(() {
            _isInitialized = true;
          });
          log("Chat initialized successfully");
        } else {
          log("Failed to initialize chat");
          _showConnectionError();
        }
      }
    } catch (e) {
      log("Error initializing chat: $e");
      if (!_isDisposed) {
        _showConnectionError();
      }
    }
  }

  void _showConnectionError() {
    if (_isDisposed || !mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Failed to connect to chat server'),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => _initializeChat(),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (state == AppLifecycleState.resumed && _isInitialized && !_isDisposed) {
      // Reconnect when app comes to foreground
      Future.delayed(const Duration(milliseconds: 500), () {
        if (currentUserId != null && !_isDisposed) {
          ref.read(socketProvider.notifier).initialize(currentUserId!);
        }
      });
    }
  }

  void _onScroll() {
    if (_isDisposed) return;
    
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      _loadMoreMessages();
    }
  }

  Future<void> _loadMoreMessages() async {
    if (_isDisposed) return;
    
    final messages =
        ref.read(socketProvider).messages[widget.conversationId] ?? [];
    if (messages.isEmpty) return;

    if (mounted && !_isDisposed) {
      setState(() {
        _isLoadingMore = true;
      });
    }

    await ref.read(socketProvider.notifier).loadMoreMessages(
        widget.conversationId,
        beforeId: messages.first.messageId);

    if (mounted && !_isDisposed) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_isDisposed) return;
    
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final connectionStatus = ref.read(socketProvider).connectionStatus;
    if (connectionStatus != ConnectionStatus.connected) {
      if (mounted && !_isDisposed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Not connected to chat server')),
        );
      }
      return;
    }

    _messageController.clear();

    try {
      final success = await ref.read(socketProvider.notifier).sendMessage(widget.conversationId, text);
      
      if (!_isDisposed && success) {
        // Scroll to bottom after sending
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scrollController.hasClients && !_isDisposed) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      } else if (!_isDisposed && !success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send message')),
          );
        }
      }
    } catch (e) {
      log("Error sending message: $e");
      if (mounted && !_isDisposed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDisposed) return const SizedBox.shrink();
    
    final chatState = ref.watch(socketProvider);
    final messages = chatState.messages[widget.conversationId] ?? [];
    final connectionStatus = chatState.connectionStatus;
    final user = widget.user;

    return Stack(
      children: [
        Image.asset(
          'assets/images/chat_bg.jpg',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey.shade700,
                  child: user.profilePic != null
                      ? CachedNetworkImage(
                          imageUrl: user.profilePic!, fit: BoxFit.cover)
                      : const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getStatusColor(connectionStatus),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getStatusText(connectionStatus),
                          style: const TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? const Center(
                        child: Text('No messages yet',
                            style: TextStyle(color: Colors.white70)),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: messages.length + (_isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (_isLoadingMore && index == 0) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    CircularProgressIndicator(color: Colors.green),
                              ),
                            );
                          }
        
                          final actualIndex = _isLoadingMore ? index - 1 : index;
                          final message =
                              messages[messages.length - 1 - actualIndex];
                          final isMyMessage = message.senderId == currentUserId;
        
                          final isFirstMessageFromSender = actualIndex == 0 ||
                              messages[messages.length - actualIndex].senderId !=
                                  message.senderId;
        
                          return _buildMessageItem(
                              message, isMyMessage, isFirstMessageFromSender);
                        },
                      ),
              ),
              _buildMessageInput(connectionStatus),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.connecting:
      case ConnectionStatus.reconnecting:
        return Colors.orange;
      case ConnectionStatus.error:
      case ConnectionStatus.disconnected:
        return Colors.red;
    }
  }

  String _getStatusText(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return 'Online';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.reconnecting:
        return 'Reconnecting...';
      case ConnectionStatus.error:
        return 'Connection error';
      case ConnectionStatus.disconnected:
        return 'Offline';
    }
  }

  Widget _buildMessageItem(
      ChatMessage message, bool isMyMessage, bool showSenderName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment:
            isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: isMyMessage
                    ? Colors.indigoAccent.shade100
                    : const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.messageText,
                    style: TextStyle(
                      color: isMyMessage ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${message.createdAt.toLocal().hour}:${message.createdAt.toLocal().minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isMyMessage ? Colors.black54 : Colors.white70,
                        ),
                      ),
                      if (isMyMessage) ...[
                        const SizedBox(width: 4),
                        Icon(
                          _getStatusIcon(message.status),
                          size: 12,
                          color: Colors.black54,
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
    final isConnected = connectionStatus == ConnectionStatus.connected;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Colors.black,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.grey),
              onPressed: isConnected ? () {} : null,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                enabled: isConnected,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: isConnected ? 'Type your message...' : 'Connecting...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  fillColor: Colors.grey.shade900,
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
            IconButton(
              icon: Icon(
                Icons.send, 
                color: isConnected ? Colors.green : Colors.grey,
              ),
              onPressed: isConnected ? _sendMessage : null,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.pending:
        return Icons.access_time;
      case MessageStatus.sent:
        return Icons.check;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.seen:
        return Icons.done_all;
      case MessageStatus.failed:
        return Icons.error_outline;
    }
  } 

  void disconnet() {
    ref.read(socketProvider.notifier).disconnect();
  }

  @override
  void dispose() {
    log("ChattingScreen disposing");
    _isDisposed = true; // Set disposal flag first
    
    WidgetsBinding.instance.removeObserver(this);
    _messageController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    
    disconnet();
    
    super.dispose();
  }
}