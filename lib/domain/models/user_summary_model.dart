import 'package:bluppi/generated/users.pb.dart' as proto;

class UserSummaryModel {
  final String id;
  final String username;
  final String name;
  final String profilePic;
  final String? suggestionReason;

  UserSummaryModel({
    required this.id,
    required this.username,
    required this.name,
    required this.profilePic,
    this.suggestionReason,
  });

  /// Converts a gRPC protobuf `UserSummary` message to a `UserSummaryModel`.
  factory UserSummaryModel.fromProto(proto.UserSummary pUserSummary) {
    return UserSummaryModel(
      id: pUserSummary.id,
      username: pUserSummary.username,
      name: pUserSummary.name,
      profilePic: pUserSummary.profilePic,
      // Check if the optional field is actually set in the protobuf message
      suggestionReason: pUserSummary.hasSuggestionReason() ? pUserSummary.suggestionReason : null,
    );
  }

  /// Converts a `UserSummaryModel` to a gRPC protobuf `UserSummary` message.
  proto.UserSummary toProto() {
    final summary = proto.UserSummary(
      id: id,
      username: username,
      name: name,
      profilePic: profilePic,
    );
    
    if (suggestionReason != null) {
      summary.suggestionReason = suggestionReason!;
    }
    
    return summary;
  }

  /// Creates a `UserSummaryModel` from a JSON map.
  factory UserSummaryModel.fromJson(Map<String, dynamic> json) {
    return UserSummaryModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      profilePic: json['profilePic'],
      suggestionReason: json['suggestionReason'],
    );
  }

  /// Converts a `UserSummaryModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'profilePic': profilePic,
      if (suggestionReason != null) 'suggestionReason': suggestionReason,
    };
  }
}