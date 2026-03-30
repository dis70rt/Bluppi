import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/models/user_summary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SuggestedFriendsState {
  final List<UserSummaryModel> suggestedFriends;
  final String nextCursor;
  final bool hasMore;

  SuggestedFriendsState({
    required this.suggestedFriends,
    required this.nextCursor,
    required this.hasMore,
  });
}

class SuggestedFriendsNotifier extends AsyncNotifier<SuggestedFriendsState> {
  @override
  Future<SuggestedFriendsState> build() async {
    return _fetchPage(nextCursor: '');
  }

  Future<SuggestedFriendsState> _fetchPage({required String nextCursor}) async {
    final repo = ref.read(userServiceClientRepositoryProvider);
    final (friends, newNextCursor) = await repo.getSuggestedFriends(nextCursor);

    final currentUsers = state.value?.suggestedFriends ?? [];

    return SuggestedFriendsState(
      suggestedFriends: [...currentUsers, ...friends],
      nextCursor: newNextCursor,
      hasMore: friends.isNotEmpty,
    );
  }

  Future<void> loadMore() async {
    final currentState = state.value;

    if (currentState == null || !currentState.hasMore || state.isLoading) {
      return;
    }

    final currentCursor = currentState.nextCursor;
    state = const AsyncLoading<SuggestedFriendsState>();

    state = await AsyncValue.guard(() async {
      return _fetchPage(nextCursor: currentCursor);
    });
  }
}

final suggestedUsersProvider =
    AsyncNotifierProvider<SuggestedFriendsNotifier, SuggestedFriendsState>(
      SuggestedFriendsNotifier.new,
    );
