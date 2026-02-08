import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowStats {
  final String userId;
  final int followers;
  final int following;

  const FollowStats({
    required this.userId,
    required this.followers,
    required this.following,
  });

  FollowStats copyWith({int? followers, int? following}) {
    return FollowStats(
      userId: userId,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}

class FollowStatsNotifier extends Notifier<FollowStats> {
  final String userId;
  final int initialFollowers;
  final int initialFollowing;
  FollowStatsNotifier({
    required this.userId,
    required this.initialFollowers,
    required this.initialFollowing,
  });

  @override
  FollowStats build() {
    return FollowStats(
      userId: userId,
      followers: initialFollowers,
      following: initialFollowing,
    );
  }

  void incrementFollowing() =>
      state = state.copyWith(following: state.following + 1);

  void decrementFollowing() =>
      state = state.copyWith(following: state.following - 1);

  Future<bool> isFollowing() async {
    return await ref
        .read(userServiceClientRepositoryProvider)
        .isFollowing(userId);
  }
}

final followStatsProvider = NotifierProvider.autoDispose
    .family<FollowStatsNotifier, FollowStats, FollowStats>(
      (arg) => FollowStatsNotifier(
        userId: arg.userId,
        initialFollowers: arg.followers,
        initialFollowing: arg.following,
      ),
    );
