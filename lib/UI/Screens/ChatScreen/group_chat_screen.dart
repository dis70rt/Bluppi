// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:synqit/Data/Models/message_model.dart';
// import 'package:synqit/Data/Models/user_model.dart';
// import 'package:synqit/Data/Services/socket_service.dart';
// import 'package:synqit/Provider/auth_provider.dart';
// import 'package:synqit/Provider/chat_provider/socket_provider.dart';
// import 'package:synqit/Provider/user_provider/user_provider.dart';

// class GroupChatScreen extends ConsumerStatefulWidget {
//   final String conversationId;
//   final UserModel user;

//   const GroupChatScreen(
//       {super.key, required this.conversationId, required this.user});

//   @override
//   ConsumerState<GroupChatScreen> createState() => _GroupChatScreenState();
// }

// class _GroupChatScreenState extends ConsumerState<GroupChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoadingMore = false;

//   String? get currentUserId => ref.read(authProvider).value?.user?.uid;

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(socketProvider.notifier).loadMoreMessages(widget.conversationId);
//     });

//     _scrollController.addListener(_onScroll);
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent &&
//         !_isLoadingMore) {
//       _loadMoreMessages();
//     }
//   }

//   Future<void> _loadMoreMessages() async {
//     final messages =
//         ref.read(socketProvider).messages[widget.conversationId] ?? [];
//     if (messages.isEmpty) return;

//     setState(() {
//       _isLoadingMore = true;
//     });

//     await ref.read(socketProvider.notifier).loadMoreMessages(
//         widget.conversationId,
//         beforeId: messages.first.messageId);

//     setState(() {
//       _isLoadingMore = false;
//     });
//   }

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     ref.read(socketProvider.notifier).sendMessage(widget.conversationId, text);
//     _messageController.clear();

//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           0,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatState = ref.watch(socketProvider);
//     final messages = chatState.messages[widget.conversationId] ?? [];
//     final connectionStatus = chatState.connectionStatus;
//     final user = widget.user;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 16,
//               backgroundColor: Colors.grey.shade700,
//               child: user.profilePic != null ?
//               CachedNetworkImage(
//                 imageUrl: user.profilePic!, fit: BoxFit.cover
//             ) :
//               const Icon(Icons.person, color: Colors.white),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(user.name, style: const TextStyle(fontSize: 16),),
//                 Text(
//                   user.username,
//                   style: const TextStyle(fontSize: 12, color: Colors.white70),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
//         ],
//       ),
//       body: Column(
//         children: [
//           // if (connectionStatus == ConnectionStatus.reconnecting)
//           //   Container(
//           //     color: Colors.amber,
//           //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           //     child: const Text(
//           //       'Reconnecting...',
//           //       style: TextStyle(color: Colors.black87),
//           //     ),
//           //   ),
//           Expanded(
//             child: messages.isEmpty
//                 ? const Center(
//                     child: Text('No messages yet',
//                         style: TextStyle(color: Colors.white70)),
//                   )
//                 : ListView.builder(
//                     controller: _scrollController,
//                     reverse: true,
//                     itemCount: messages.length + (_isLoadingMore ? 1 : 0),
//                     itemBuilder: (context, index) {
//                       if (_isLoadingMore && index == 0) {
//                         return const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child:
//                                 CircularProgressIndicator(color: Colors.green),
//                           ),
//                         );
//                       }

//                       final actualIndex = _isLoadingMore ? index - 1 : index;
//                       final message =
//                           messages[messages.length - 1 - actualIndex];
//                       final isMyMessage = message.senderId == currentUserId;

//                       final isFirstMessageFromSender = actualIndex == 0 ||
//                           messages[messages.length - actualIndex].senderId !=
//                               message.senderId;

//                       return _buildMessageItem(
//                           message, isMyMessage, isFirstMessageFromSender);
//                     },
//                   ),
//           ),
//           _buildMessageInput(connectionStatus),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageItem(
//       ChatMessage message, bool isMyMessage, bool showSenderName) {
//         final currentUser = ref.read(userProvider).value;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
//       child: Row(
//         mainAxisAlignment:
//             isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (!isMyMessage) ...[
//             CircleAvatar(
//               radius: 16,
//               backgroundImage: CachedNetworkImageProvider(widget.user.profilePic ?? 'https://randomuser.me/api/portraits/men/32.jpg')
//             ),
//             const SizedBox(width: 8),
//           ],
//           Flexible(
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: isMyMessage
//                     ? Colors.pinkAccent.shade100
//                     : const Color(0xFF2C2C2E),
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (showSenderName && !isMyMessage)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 4.0),
//                       child: Text(
//                         widget.user.name, // Replace with actual sender name
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white70,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ),
//                   Text(
//                     message.messageText,
//                     style: TextStyle(
//                       color: isMyMessage ? Colors.black : Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: isMyMessage ? Colors.black54 : Colors.white70,
//                         ),
//                       ),
//                       if (isMyMessage) ...[
//                         const SizedBox(width: 4),
//                         Icon(
//                           _getStatusIcon(message.status),
//                           size: 12,
//                           color: Colors.black54,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isMyMessage) ...[
//             const SizedBox(width: 8),
//             CircleAvatar(
//               radius: 16,
//               backgroundImage: CachedNetworkImageProvider(
//                 currentUser?.profilePic ?? 'https://randomuser.me/api/portraits/men/32.jpg'
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput(ConnectionStatus connectionStatus) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//       color: Colors.black,
//       child: SafeArea(
//         child: Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.attach_file, color: Colors.grey),
//               onPressed: () {},
//             ),
//             Expanded(
//               child: TextField(
//                 controller: _messageController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: 'Type your message...',
//                   hintStyle: TextStyle(color: Colors.grey.shade400),
//                   fillColor: Colors.grey.shade900,
//                   filled: true,
//                   isDense: true,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(24),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 onSubmitted: (_) =>
//                     connectionStatus == ConnectionStatus.connected
//                         ? _sendMessage()
//                         : null,
//               ),
//             ),
//             // IconButton(
//             //   icon:
//             //       const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
//             //   onPressed: () {},
//             // ),
//             IconButton(
//               icon: const Icon(Icons.send, color: Colors.grey),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   IconData _getStatusIcon(MessageStatus status) {
//     switch (status) {
//       case MessageStatus.pending:
//         return Icons.access_time;
//       case MessageStatus.sent:
//         return Icons.check;
//       case MessageStatus.delivered:
//         return Icons.done_all;
//       case MessageStatus.seen:
//         return Icons.done_all;
//       case MessageStatus.failed:
//         return Icons.error_outline;
//     }
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
