import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/follower_model.dart';
import 'package:synqit/Data/Services/user_services.dart';

class FollowListState {
  final List<FollowUserModel> items;
  final bool isLoading;
  final bool hasMore;
  final int totalCount;
  final int offset;
  final String error;

  FollowListState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.totalCount = 0,
    this.offset = 0,
    this.error = '',
  });

  FollowListState copyWith({
    List<FollowUserModel>? items,
    bool? isLoading,
    bool? hasMore,
    int? totalCount,
    int? offset,
    String? error,
  }) {
    return FollowListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      totalCount: totalCount ?? this.totalCount,
      offset: offset ?? this.offset,
      error: error ?? this.error,
    );
  }
}

class FollowersNotifier extends StateNotifier<FollowListState> {
  final UserServices _userServices = UserServices();
  final String userId;
  final int limit = 15;

  FollowersNotifier({required this.userId}) : super(FollowListState());

  Future<void> loadFollowers({bool refresh = false}) async {
    if (state.isLoading) return;
    
    if (!state.hasMore && !refresh) return;
    
    final newOffset = refresh ? 0 : state.offset;
    
    state = state.copyWith(
      isLoading: true,
      error: '',
      offset: refresh ? 0 : state.offset,
      items: refresh ? [] : state.items,
    );

    try {
      final result = await _userServices.getFollowers(
        userId: userId,
        limit: limit,
        offset: newOffset,
      );

      final newItems = result.followers;
      final totalCount = result.totalCount;
      
      state = state.copyWith(
        items: refresh 
          ? newItems 
          : [...state.items, ...newItems],
        totalCount: totalCount,
        isLoading: false,
        hasMore: (newOffset + limit) < totalCount,
        offset: newOffset + limit,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

class FollowingNotifier extends StateNotifier<FollowListState> {
  final UserServices _userServices = UserServices();
  final String userId;
  final int limit = 15;

  FollowingNotifier({required this.userId}) : super(FollowListState());

  Future<void> loadFollowing({bool refresh = false}) async {
    if (state.isLoading) return;
    
    if (!state.hasMore && !refresh) return;
    
    final newOffset = refresh ? 0 : state.offset;
    
    state = state.copyWith(
      isLoading: true,
      error: '',
      offset: refresh ? 0 : state.offset,
      items: refresh ? [] : state.items,
    );

    try {
      final result = await _userServices.getFollowing(
        userId: userId,
        limit: limit,
        offset: newOffset,
      );

      final newItems = result.followers;
      final totalCount = result.totalCount;
      
      state = state.copyWith(
        items: refresh 
          ? newItems 
          : [...state.items, ...newItems],
        totalCount: totalCount,
        isLoading: false,
        hasMore: (newOffset + limit) < totalCount,
        offset: newOffset + limit,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final followersProvider = StateNotifierProvider.family<FollowersNotifier, FollowListState, String>(
  (ref, userId) => FollowersNotifier(userId: userId),
);

final followingProvider = StateNotifierProvider.family<FollowingNotifier, FollowListState, String>(
  (ref, userId) => FollowingNotifier(userId: userId),
);