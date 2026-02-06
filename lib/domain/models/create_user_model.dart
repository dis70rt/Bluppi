import 'package:bluppi/generated/users.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class CreateUserModel {
  final String email;
  final String username;
  final String name;
  final String bio;
  final String country;
  final String phone;
  final String profilePicPath;
  final List<String> selectedGenres;
  final String id;
  final DateTime? dateOfBirth;
  final String gender;

  const CreateUserModel({
    this.email = '',
    this.username = '',
    this.name = '',
    this.bio = '',
    this.country = '',
    this.phone = '',
    this.profilePicPath = '',
    this.selectedGenres = const [],
    this.id = '',
    this.dateOfBirth,
    this.gender = '',
  });

  CreateUserModel copyWith({
    String? email,
    String? username,
    String? name,
    String? bio,
    String? country,
    String? phone,
    String? profilePicPath,
    List<String>? selectedGenres,
    String? id,
    DateTime? dateOfBirth,
    String? gender,
  }) {
    return CreateUserModel(
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      profilePicPath: profilePicPath ?? this.profilePicPath,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      id: id ?? this.id,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }

  proto.CreateUserRequest toProto() {
    return proto.CreateUserRequest(
      email: email,
      username: username,
      name: name,
      bio: bio,
      country: country,
      phone: phone,
      profilePic: profilePicPath,
      favoriteGenres: selectedGenres,
      id: id,
      dateOfBirth: dateOfBirth != null ? Timestamp.fromDateTime(dateOfBirth!) : null,
      gender: gender,
    );
  }
}