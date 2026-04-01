import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/models/follow_user_entry_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowPaginationState {
  final List<FollowUserEntryModel> users;
  final String nextCursor;
  final bool hasMore;

  FollowPaginationState({
    required this.users,
    required this.nextCursor,
    required this.hasMore,
  });

  FollowPaginationState copyWith({
    List<FollowUserEntryModel>? users,
    String? nextCursor,
    bool? hasMore,
  }) {
    return FollowPaginationState(
      users: users ?? this.users,
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class FollowersNotifier extends AsyncNotifier<FollowPaginationState> {
  final String userId;
  FollowersNotifier(this.userId);

  @override
  Future<FollowPaginationState> build() async {
    final (users, nextCursor, hasMore) = await ref
        .read(userServiceClientRepositoryProvider)
        .getFollowers(userId, '', limit: 20);
    return FollowPaginationState(
      users: users,
      nextCursor: nextCursor,
      hasMore: hasMore,
    );
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore) return;

    final (users, nextCursor, hasMore) = await ref
        .read(userServiceClientRepositoryProvider)
        .getFollowers(userId, currentState.nextCursor, limit: 20);
    state = AsyncData(
      currentState.copyWith(
        users: [...currentState.users, ...users],
        nextCursor: nextCursor,
        hasMore: hasMore,
      ),
    );
  }
}

class FollowingsNotifier extends AsyncNotifier<FollowPaginationState> {
  final String userId;
  FollowingsNotifier(this.userId);

  @override
  Future<FollowPaginationState> build() async {
    final (users, nextCursor, hasMore) = await ref
        .read(userServiceClientRepositoryProvider)
        .getFollowings(userId, '', limit: 20);
    return FollowPaginationState(
      users: users,
      nextCursor: nextCursor,
      hasMore: hasMore,
    );
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore) return;

    final (users, nextCursor, hasMore) = await ref
        .read(userServiceClientRepositoryProvider)
        .getFollowings(userId, currentState.nextCursor, limit: 20);
    state = AsyncData(
      currentState.copyWith(
        users: [...currentState.users, ...users],
        nextCursor: nextCursor,
        hasMore: hasMore,
      ),
    );
  }
}

final followersProvider = AsyncNotifierProvider.family
    .autoDispose<FollowersNotifier, FollowPaginationState, String>(
      (userId) => FollowersNotifier(userId),
    );

final followingsProvider = AsyncNotifierProvider.family
    .autoDispose<FollowingsNotifier, FollowPaginationState, String>(
      (userId) => FollowingsNotifier(userId),
    );
