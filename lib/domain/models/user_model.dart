import 'package:bluppi/generated/users.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  final String name;
  final String bio;
  final String country;
  final String phone;
  final String profilePic;
  final List<String> favoriteGenres;
  final int followerCount;
  final int followingCount;
  final DateTime createdAt;
  final DateTime dateOfBirth;
  final String gender;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.bio,
    required this.country,
    required this.phone,
    required this.profilePic,
    required this.favoriteGenres,
    required this.followerCount,
    required this.followingCount,
    required this.createdAt,
    required this.dateOfBirth,
    required this.gender,
  });

  /// Converts a gRPC protobuf `User` message to a `UserModel`.
  factory UserModel.fromProto(proto.User pUser) {
    return UserModel(
      id: pUser.id,
      email: pUser.email,
      username: pUser.username,
      name: pUser.name,
      bio: pUser.bio,
      country: pUser.country,
      phone: pUser.phone,
      profilePic: pUser.profilePic,
      favoriteGenres: List<String>.from(pUser.favoriteGenres),
      followerCount: pUser.followerCount,
      followingCount: pUser.followingCount,
      createdAt: pUser.createdAt.toDateTime(),
      dateOfBirth: pUser.dateOfBirth.toDateTime(),
      gender: pUser.gender,
    );
  }

  /// Converts a `UserModel` to a gRPC protobuf `User` message.
  proto.User toProto() {
    return proto.User(
      id: id,
      email: email,
      username: username,
      name: name,
      bio: bio,
      country: country,
      phone: phone,
      profilePic: profilePic,
      favoriteGenres: favoriteGenres,
      followerCount: followerCount,
      followingCount: followingCount,
      createdAt: Timestamp.fromDateTime(createdAt),
      dateOfBirth: Timestamp.fromDateTime(dateOfBirth),
      gender: gender,
    );
  }

  /// Creates a `UserModel` from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      name: json['name'],
      bio: json['bio'],
      country: json['country'],
      phone: json['phone'],
      profilePic: json['profilePic'],
      favoriteGenres: List<String>.from(json['favoriteGenres']),
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      createdAt: DateTime.parse(json['createdAt']),
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
    );
  }

  /// Converts a `UserModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name,
      'bio': bio,
      'country': country,
      'phone': phone,
      'profilePic': profilePic,
      'favoriteGenres': favoriteGenres,
      'followerCount': followerCount,
      'followingCount': followingCount,
      'createdAt': createdAt.toIso8601String(),
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
    };
  }
}