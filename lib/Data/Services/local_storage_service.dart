// import 'dart:convert';
// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:bluppi/Data/Models/conversation_model.dart';
// import 'package:bluppi/Data/Models/message_model.dart';

// class LocalStorageService {
//   Future<Directory> get _appDirectory async {
//     return await getApplicationDocumentsDirectory();
//   }

//   Future<Directory> get _chatDirectory async {
//     final appDir = await _appDirectory;
//     final chatDir = Directory('${appDir.path}/chat');
//     if (!await chatDir.exists()) {
//       await chatDir.create(recursive: true);
//     }
//     return chatDir;
//   }

//   Future<File> _messageFile(String conversationId) async {
//     final chatDir = await _chatDirectory;
//     return File('${chatDir.path}/messages_$conversationId.json');
//   }

//   Future<File> _conversationsFile() async {
//     final chatDir = await _chatDirectory;
//     return File('${chatDir.path}/conversations.json');
//   }

//   Future<void> saveMessages(
//       String conversationId, List<ChatMessage> messages) async {
//     final file = await _messageFile(conversationId);
//     final jsonData = messages.map((msg) => msg.toJson()).toList();
//     await file.writeAsString(jsonEncode(jsonData));
//   }

//   Future<List<ChatMessage>> loadMessages(String conversationId) async {
//     try {
//       final file = await _messageFile(conversationId);
//       if (!await file.exists()) {
//         return [];
//       }

//       final jsonString = await file.readAsString();
//       final jsonData = jsonDecode(jsonString) as List<dynamic>;
//       return jsonData.map((data) => ChatMessage.fromJson(data)).toList();
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<void> saveConversations(List<Conversation> conversations) async {
//     final file = await _conversationsFile();
//     final jsonData = conversations.map((conv) => conv.toJson()).toList();
//     await file.writeAsString(jsonEncode(jsonData));
//   }

//   Future<List<Conversation>> loadConversations() async {
//     try {
//       final file = await _conversationsFile();
//       if (!await file.exists()) {
//         return [];
//       }

//       final jsonString = await file.readAsString();
//       final jsonData = jsonDecode(jsonString) as List<dynamic>;
//       return jsonData.map((data) => Conversation.fromJson(data)).toList();
//     } catch (e) {
//       return [];
//     }
//   }

//   Future<void> addMessage(ChatMessage message) async {
//     final messages = await loadMessages(message.conversationId);

//     final exists = messages.any((msg) => msg.messageId == message.messageId);
//     if (!exists) {
//       messages.add(message);
//       await saveMessages(message.conversationId, messages);

//       final conversations = await loadConversations();
//       final conversationIndex = conversations
//           .indexWhere((conv) => conv.conversationId == message.conversationId);

//       if (conversationIndex >= 0) {
//         conversations[conversationIndex] =
//             conversations[conversationIndex].copyWith(
//           lastActivity: message.createdAt,
//         );
//         await saveConversations(conversations);
//       }
//     }
//   }

//   Future<void> updateMessageStatus(
//       String messageId, String conversationId, MessageStatus status) async {
//     final messages = await loadMessages(conversationId);
//     final index = messages.indexWhere((msg) => msg.messageId == messageId);

//     if (index >= 0) {
//       messages[index] = messages[index].copyWith(status: status);
//       await saveMessages(conversationId, messages);
//     }
//   }
// }
