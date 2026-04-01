import 'package:bluppi/generated/users.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class FollowUserEntryModel {
  final String id;
  final String username;
  final String name;
  final String profilePic;
  final DateTime? followedAt;

  const FollowUserEntryModel({
    required this.id,
    required this.username,
    required this.name,
    required this.profilePic,
    this.followedAt,
  });

  FollowUserEntryModel copyWith({
    String? id,
    String? username,
    String? name,
    String? profilePic,
    DateTime? followedAt,
  }) {
    return FollowUserEntryModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      followedAt: followedAt ?? this.followedAt,
    );
  }

  factory FollowUserEntryModel.fromProto(proto.FollowUserEntry protoEntry) {
    return FollowUserEntryModel(
      id: protoEntry.id,
      username: protoEntry.username,
      name: protoEntry.name,
      profilePic: protoEntry.profilePic,
      followedAt: protoEntry.hasFollowedAt()
          ? protoEntry.followedAt.toDateTime()
          : null,
    );
  }

  proto.FollowUserEntry toProto() {
    return proto.FollowUserEntry(
      id: id,
      username: username,
      name: name,
      profilePic: profilePic,
      followedAt: followedAt != null
          ? Timestamp.fromDateTime(followedAt!)
          : null,
    );
  }
}
