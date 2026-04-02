import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:bluppi/domain/models/like_track_entry_model.dart';
import 'package:riverpod/riverpod.dart';

class LikedTracksState {
  final List<LikedTrackModel> tracks;
  final String? nextCursor;
  final int total;
  final bool hasMore;
  final bool isLoadingMore;

  const LikedTracksState({
    required this.tracks,
    this.nextCursor,
    required this.total,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  LikedTracksState copyWith({
    List<LikedTrackModel>? tracks,
    String? nextCursor,
    int? total,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return LikedTracksState(
      tracks: tracks ?? this.tracks,
      nextCursor: nextCursor ?? this.nextCursor,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class LikedTracksNotifier extends AsyncNotifier<LikedTracksState> {
  final String userId;
  LikedTracksNotifier(this.userId);

  @override
  Future<LikedTracksState> build() async {
    final repo = ref.read(trackServiceProvider);
    final (tracks, nextCursor, total, hasMore) = await repo.getLikedTracks(
      userId,
    );
    return LikedTracksState(
      tracks: tracks,
      nextCursor: nextCursor,
      total: total,
      hasMore: hasMore,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.hasError) return;

    final currentState = state.value!;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final repo = ref.read(trackServiceProvider);
      final (newTracks, nextCursor, total, hasMore) = await repo.getLikedTracks(
        userId,
        cursor: currentState.nextCursor,
      );

      state = AsyncData(
        currentState.copyWith(
          tracks: [...currentState.tracks, ...newTracks],
          nextCursor: nextCursor,
          total: total,
          hasMore: hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      state = AsyncData(currentState.copyWith(isLoadingMore: false));
    }
  }
}

final likedTracksProvider = AsyncNotifierProvider.family
    .autoDispose<LikedTracksNotifier, LikedTracksState, String>(
      (userId) => LikedTracksNotifier(userId),
    );
