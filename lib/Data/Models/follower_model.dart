class FollowUserModel {
  final String id;
  final String username;
  final String name;
  final String profilePic;

  const FollowUserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.profilePic,
  });

  factory FollowUserModel.fromMap(Map<String, dynamic> map) {
    return FollowUserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profile_pic'] ?? '',
    );
  }
}

class FollowingModel {
  final List<FollowUserModel> followers;
  final int totalCount;

  const FollowingModel({
    required this.followers,
    required this.totalCount,
  });

  factory FollowingModel.fromMap(Map<String, dynamic> map) {
    return FollowingModel(
      followers: List<FollowUserModel>.from(
        map['following']?.map((x) => FollowUserModel.fromMap(x)) ?? [],
      ),
      totalCount: map['total'] ?? 0,
    );
  }
}

class FollowerModel {
  final List<FollowUserModel> followers;
  final int totalCount;

  const FollowerModel({
    required this.followers,
    required this.totalCount,
  });

  factory FollowerModel.fromMap(Map<String, dynamic> map) {
    return FollowerModel(
      followers: List<FollowUserModel>.from(
        map['followers']?.map((x) => FollowUserModel.fromMap(x)) ?? [],
      ),
      totalCount: map['total'] ?? 0,
    );
  }
}
