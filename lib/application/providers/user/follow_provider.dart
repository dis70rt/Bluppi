import 'dart:developer';

import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowArg {
  final String userId;
  final int? initialFollowers;
  final int? initialFollowing;
  final bool? initialIsFollowing;

  const FollowArg({
    required this.userId,
    this.initialFollowers,
    this.initialFollowing,
    this.initialIsFollowing,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FollowArg && other.userId == userId);

  @override
  int get hashCode => userId.hashCode;
}

class FollowStats {
  // final String userId;
  final int? followers;
  final int? following;
  final bool? isFollowing;
  final bool isLoading;

  const FollowStats({
    // required this.userId,
    this.followers,
    this.following,
    this.isFollowing,
    this.isLoading = false,
  });

  FollowStats copyWith({
    int? followers,
    int? following,
    bool? isFollowing,
    bool? isLoading,
  }) {
    return FollowStats(
      // userId: userId,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isFollowing: isFollowing ?? this.isFollowing,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is FollowStats &&
  //     other.userId == userId &&
  //     other.followers == followers &&
  //     other.following == following &&
  //     other.isFollowing == isFollowing &&
  //     other.isLoading == isLoading;
  // }

  // @override
  // int get hashCode {
  //   return userId.hashCode ^
  //     followers.hashCode ^
  //     following.hashCode ^
  //     isFollowing.hashCode ^
  //     isLoading.hashCode;
  // }
}

class FollowStatsNotifier extends Notifier<FollowStats> {
  final FollowArg followArg;
  FollowStatsNotifier({required this.followArg});

  @override
  FollowStats build() {
    if(followArg.initialIsFollowing == null) {
      Future.microtask(() => _initialize());
    }

    return FollowStats(
      followers: followArg.initialFollowers,
      following: followArg.initialFollowing,
      isFollowing: followArg.initialIsFollowing,
    );
  }

  Future<void> _initialize() async {
    final userId = followArg.userId;
    try {
      log("Checking if current user is following $userId");
      final currentlyFollowing = await ref
          .read(userServiceClientRepositoryProvider)
          .isFollowing(userId);

      log("Follow status for $userId: $currentlyFollowing");
      state = state.copyWith(isFollowing: currentlyFollowing, isLoading: false);
    } catch (e) {
      log("Error checking follow status for $userId: $e");
      state = state.copyWith(isFollowing: false, isLoading: false);
    }
  }

  Future<void> toggleFollow() async {
    final userId = followArg.userId;
    log(
      "Toggling follow for $userId. Current state: isFollowing=${state.isFollowing}, followers=${state.followers}",
    );
    if (state.isFollowing == null || state.isLoading) return;

    final wasFollowing = state.isFollowing!;
    final previousState = state;

    int? newFollowerCount;
    if (state.followers != null) {
      newFollowerCount = wasFollowing
          ? state.followers! - 1
          : state.followers! + 1;
    }

    state = state.copyWith(
      isFollowing: !wasFollowing,
      followers: newFollowerCount,
      isLoading: true,
    );

    try {
      final repo = ref.read(userServiceClientRepositoryProvider);

      if (wasFollowing) {
        await repo.unfollowUser(userId);
      } else {
        await repo.followUser(userId);
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = previousState;
    }
  }
}

final followStatsProvider = NotifierProvider.autoDispose
    .family<FollowStatsNotifier, FollowStats, FollowArg>(
      (arg) => FollowStatsNotifier(followArg: arg),
    );
