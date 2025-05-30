import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synqit/Data/Models/conversation_model.dart';
import 'package:synqit/Data/Models/message_model.dart';
import 'dart:developer' as dev;

class LocalStorageService {
  static Database? _database;
  static const String dbName = 'synqit_chat.db';
  static const int dbVersion = 2;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try {
        await db.execute(
            'ALTER TABLE messages ADD COLUMN type INTEGER NOT NULL DEFAULT 0');
        dev.log('Successfully added type column to messages table');
      } catch (e) {
        dev.log('Error adding type column: $e');
      }
    }
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE conversations (
      conversation_id TEXT PRIMARY KEY,
      conversation_name TEXT,
      is_group INTEGER NOT NULL,
      participants TEXT NOT NULL,
      last_activity TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE messages (
      message_id TEXT PRIMARY KEY,
      sender_id TEXT NOT NULL,
      conversation_id TEXT NOT NULL,
      message_text TEXT NOT NULL,
      created_at TEXT NOT NULL,
      status TEXT NOT NULL,
      type INTEGER NOT NULL DEFAULT 0,
      FOREIGN KEY (conversation_id) REFERENCES conversations (conversation_id)
    )
  ''');

    await db.execute(
        'CREATE INDEX idx_messages_conversation_id ON messages (conversation_id)');
    await db.execute(
        'CREATE INDEX idx_messages_created_at ON messages (created_at)');
  }

  Future<void> saveConversations(List<Conversation> conversations) async {
    final db = await database;
    final batch = db.batch();

    await db.delete('conversations');

    for (var conversation in conversations) {
      batch.insert(
        'conversations',
        {
          'conversation_id': conversation.conversationId,
          'conversation_name': conversation.conversationName,
          'is_group': conversation.isGroup ? 1 : 0,
          'participants': conversation.participants.join(','),
          'last_activity': conversation.lastActivity?.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<List<Conversation>> loadConversations() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('conversations');

      return maps
          .map((map) => Conversation(
                conversationId: map['conversation_id'],
                conversationName: map['conversation_name'],
                isGroup: map['is_group'] == 1,
                participants: (map['participants'] as String).split(','),
                lastActivity: map['last_activity'] != null
                    ? DateTime.parse(map['last_activity'])
                    : null,
              ))
          .toList();
    } catch (e) {
      dev.log('Error loading conversations: $e');
      return [];
    }
  }

  Future<void> saveMessages(
      String conversationId, List<ChatMessage> messages) async {
    final db = await database;
    final batch = db.batch();

    await db.delete(
      'messages',
      where: 'conversation_id = ?',
      whereArgs: [conversationId],
    );

    for (var message in messages) {
      batch.insert(
        'messages',
        {
          'message_id': message.messageId,
          'sender_id': message.senderId,
          'conversation_id': message.conversationId,
          'message_text': message.messageText,
          'created_at': message.createdAt.toIso8601String(),
          'status': message.status.toString(),
          'type': message.type.toString(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<List<ChatMessage>> loadMessages(String conversationId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'messages',
        where: 'conversation_id = ?',
        whereArgs: [conversationId],
        orderBy: 'created_at ASC',
      );

      return maps
          .map((map) => ChatMessage(
                messageId: map['message_id'],
                senderId: map['sender_id'],
                conversationId: map['conversation_id'],
                messageText: map['message_text'],
                createdAt: DateTime.parse(map['created_at']),
                status: MessageStatus.values.firstWhere(
                  (e) => e.toString() == map['status'],
                  orElse: () => MessageStatus.sent,
                ),
                type: MessageType.values.firstWhere(
                  (e) => e.toString() == map['type'],
                  orElse: () => MessageType.text,
                ),
              ))
          .toList();
    } catch (e) {
      dev.log('Error loading messages: $e');
      return [];
    }
  }

  Future<void> addMessage(ChatMessage message) async {
    final db = await database;

    await db.transaction((txn) async {
      final count = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT COUNT(*) FROM messages WHERE message_id = ?',
              [message.messageId])) ??
          0;

      if (count == 0) {
        await txn.insert(
          'messages',
          {
            'message_id': message.messageId,
            'sender_id': message.senderId,
            'conversation_id': message.conversationId,
            'message_text': message.messageText,
            'created_at': message.createdAt.toIso8601String(),
            'status': message.status.toString(),
            'type': message.type.toString(),
          },
        );

        await txn.rawUpdate(
          '''
        UPDATE conversations 
        SET last_activity = ? 
        WHERE conversation_id = ?
        ''',
          [message.createdAt.toIso8601String(), message.conversationId],
        );
      }
    });
  }

  Future<void> updateMessageStatus(
      String messageId, String conversationId, MessageStatus status) async {
    final db = await database;

    await db.update(
      'messages',
      {'status': status.toString()},
      where: 'message_id = ? AND conversation_id = ?',
      whereArgs: [messageId, conversationId],
    );
  }

  Future<List<ChatMessage>> loadRecentMessages(String conversationId,
      {int limit = 20}) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'messages',
        where: 'conversation_id = ?',
        whereArgs: [conversationId],
        orderBy: 'created_at DESC',
        limit: limit,
      );

      final messages = maps
          .map((map) => ChatMessage(
                messageId: map['message_id'],
                senderId: map['sender_id'],
                conversationId: map['conversation_id'],
                messageText: map['message_text'],
                createdAt: DateTime.parse(map['created_at']),
                status: MessageStatus.values.firstWhere(
                  (e) => e.toString() == map['status'],
                  orElse: () => MessageStatus.sent,
                ),
                type: MessageType.values.firstWhere(
                  (e) => e.toString() == map['type'],
                  orElse: () => MessageType.text,
                ),
              ))
          .toList();

      return messages.reversed.toList();
    } catch (e) {
      dev.log('Error loading recent messages: $e');
      return [];
    }
  }

  Future<List<ChatMessage>> loadMessagesBefore(String conversationId,
      {required DateTime beforeDate, int limit = 20}) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'messages',
        where: 'conversation_id = ? AND created_at < ?',
        whereArgs: [conversationId, beforeDate.toIso8601String()],
        orderBy: 'created_at DESC',
        limit: limit,
      );

      final messages = maps
          .map((map) => ChatMessage(
                messageId: map['message_id'],
                senderId: map['sender_id'],
                conversationId: map['conversation_id'],
                messageText: map['message_text'],
                createdAt: DateTime.parse(map['created_at']),
                status: MessageStatus.values.firstWhere(
                  (e) => e.toString() == map['status'],
                  orElse: () => MessageStatus.sent,
                ),
                type: MessageType.values.firstWhere(
                  (e) => e.toString() == map['type'],
                  orElse: () => MessageType.text,
                ),
              ))
          .toList();

      return messages.reversed.toList();
    } catch (e) {
      dev.log('Error loading messages before date: $e');
      return [];
    }
  }
}
