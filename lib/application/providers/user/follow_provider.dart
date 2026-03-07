import 'dart:developer';

import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowStats {
  final String userId;
  final int followers;
  final int following;
  final bool? isFollowing;
  final bool isLoading;

  const FollowStats({
    required this.userId,
    required this.followers,
    required this.following,
    this.isFollowing,
    this.isLoading = false,
  });

  FollowStats copyWith({int? followers, int? following, bool? isFollowing, bool? isLoading}) {
    return FollowStats(
      userId: userId,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isFollowing: isFollowing ?? this.isFollowing,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FollowStats &&
      other.userId == userId &&
      other.followers == followers &&
      other.following == following &&
      other.isFollowing == isFollowing &&
      other.isLoading == isLoading;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      followers.hashCode ^
      following.hashCode ^
      isFollowing.hashCode ^
      isLoading.hashCode;
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

    Future.microtask(() => _initialize());
    
    return FollowStats(
      userId: userId,
      followers: initialFollowers,
      following: initialFollowing,
    );
  }

  Future<void> _initialize() async {
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
    log("Toggling follow for $userId. Current state: isFollowing=${state.isFollowing}, followers=${state.followers}");
    if (state.isFollowing == null || state.isLoading) return;

    final wasFollowing = state.isFollowing!;
    final previousState = state;

    state = state.copyWith(
      isFollowing: !wasFollowing,
      followers: wasFollowing ? state.followers - 1 : state.followers + 1,
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
    .family<FollowStatsNotifier, FollowStats, FollowStats>(
      (arg) => FollowStatsNotifier(
        userId: arg.userId,
        initialFollowers: arg.followers,
        initialFollowing: arg.following,
      ),
    );
