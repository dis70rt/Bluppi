import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final Dio dio = Dio();

class UserModel extends ChangeNotifier {
  String id;
  String name;
  int? phone;
  String email;
  String country;
  String? profilePic;
  DateTime createdAt;
  int followers;
  int following;

  UserModel({
    required this.id,
    required this.name,
    this.phone,
    required this.email,
    required this.country,
    this.profilePic,
    DateTime? createdAt,
    this.followers = 15638,
    this.following = 56,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone ?? '',
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'country': country,
      'profilePic': profilePic ?? '',
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['userMetadata']?['full_name'] ?? 'Unknown',
      phone: map['phone'],
      email: map['email'] ?? '',
      country: map['country'] ?? 'Unknown',
      profilePic: map['profilePic'],
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
