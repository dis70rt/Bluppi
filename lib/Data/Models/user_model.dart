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
        profilePic: data['profile_pic'] as String?,
        createdAt: (data['created_at'] != null)
            ? DateTime.tryParse(data['created_at'] as String? ?? '') ??
                DateTime.now()
            : DateTime.now(),
        followers: data['follower_count'] as int? ?? 0,
        following: data['following_count'] as int? ?? 0,
        favoriteGenres: (data['favorite_genres'] as List<dynamic>?)
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
      'profile_pic': profilePic,
      'createdAt': createdAt.toIso8601String(),
      'follower_count': followers,
      'following_count': following,
      'favorite_genres': favoriteGenres,
      'bio': bio,
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? name,
    String? email,
    int? phone,
    String? country,
    String? profilePic,
    DateTime? createdAt,
    int? followers,
    int? following,
    List<String>? favoriteGenres,
    String? bio,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      profilePic: profilePic ?? this.profilePic,
      createdAt: createdAt ?? this.createdAt,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'phone': phone,
      'email': email,
      'country': country,
      'profile_pic': profilePic,
      'createdAt': createdAt.toIso8601String(),
      'follower_count': followers,
      'following_count': following,
      'favorite_genres': favoriteGenres,
      'bio': bio,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'] ?? '',
      country: map['country'],
      profilePic: map['profile_pic'],
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      followers: map['follower_count'] ?? 0,
      following: map['following_count'] ?? 0,
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

  void updateData(Map<String, dynamic> newData) {
    if (newData.containsKey('username')) {
      username = newData['username'] as String? ?? '';
    }
    if (newData.containsKey('name')) {
      name = newData['name'] as String? ?? 'No Name Provided';
    }
    if (newData.containsKey('email')) {
      email = newData['email'] as String? ?? '';
    }
    if (newData.containsKey('phone')) {
      phone = newData['phone'] as int?;
    }
    if (newData.containsKey('country')) {
      country = newData['country'] as String?;
    }
    if (newData.containsKey('profile_pic')) {
      profilePic = newData['profile_pic'] as String?;
    }

    // if (newData.containsKey('followers')) {
    //   followers = newData['followers'] as int? ?? 0;
    // }
    // if (newData.containsKey('following')) {
    //   following = newData['following'] as int? ?? 0;
    // }
    if (newData.containsKey('favorite_genres')) {
      favoriteGenres = (newData['favorite_genres'] as List<dynamic>?)
          ?.map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }
    if (newData.containsKey('bio')) {
      bio = newData['bio'] as String?;
    }

    notifyListeners();
  }

  void incrementFollowing() {
    following++;
    notifyListeners();
  }

  void decrementFollowing() {
    if (following > 0) {
      following--;
      notifyListeners();
    }
  }
}
