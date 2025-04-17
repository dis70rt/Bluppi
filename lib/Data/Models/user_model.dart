import 'dart:convert';
import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  final String id;
  String username;
  String name;
  String email;
  int? phone;
  String? country;
  String? profilePic;
  final DateTime createdAt;
  int followers;
  int following;

  List<String>? favoriteGenres;
  String? bio;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.phone,
    this.country,
    this.profilePic,
    DateTime? createdAt,
    this.followers = 0,
    this.following = 0,
    this.favoriteGenres,
    this.bio,
  }) : createdAt = createdAt ?? DateTime.now();

  factory UserModel.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    try {
      return UserModel(
        id: documentId,
        username: data['username'] ?? '',
        name: data['name'] ?? 'No Name Provided',
        email: data['email'] ?? '',
        phone: data['phone'] as int?,
        country: data['country'] as String?,
        profilePic: data['profilePic'] as String?,
        createdAt: (data['createdAt'] != null)
            ? DateTime.tryParse(data['createdAt'] as String? ?? '') ??
                DateTime.now()
            : DateTime.now(),
        followers: data['followers'] as int? ?? 0,
        following: data['following'] as int? ?? 0,
        favoriteGenres: (data['favoriteGenres'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        bio: data['bio'] as String?,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error creating UserModel from Firestore: $e");
        print("Data received: $data");
      }

      rethrow;
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'profilePic': profilePic,
      'createdAt': createdAt.toIso8601String(),
      'followers': followers,
      'following': following,
      'favoriteGenres': favoriteGenres,
      'bio': bio,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'phone': phone,
      'email': email,
      'country': country,
      'profilePic': profilePic,
      'createdAt': createdAt.toIso8601String(),
      'followers': followers,
      'following': following,
      'favoriteGenres': favoriteGenres,
      'bio': bio,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? 'Unknown',
      phone: map['phone'],
      email: map['email'] ?? '',
      country: map['country'],
      profilePic: map['profilePic'],
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
      favoriteGenres: (map['favoriteGenres'] as List<dynamic>?)?.cast<String>(),
      bio: map['bio'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, name: $name, email: $email)';
  }
}
