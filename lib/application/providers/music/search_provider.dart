import 'dart:async';
import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:bluppi/domain/models/search_track_model.dart';
import 'package:riverpod/riverpod.dart';

class SearchTrackState {
  final String query;
  final bool isLoadingMore;
  final List<SearchTrackModel> results;
  final String? nextCursor;
  final bool hasMore;

  const SearchTrackState({
    this.query = '',
    this.isLoadingMore = false,
    this.results = const [],
    this.nextCursor,
    this.hasMore = true,
  });

  SearchTrackState copyWith({
    String? query,
    bool? isLoadingMore,
    List<SearchTrackModel>? results,
    String? nextCursor,
    bool? hasMore,
  }) {
    return SearchTrackState(
      query: query ?? this.query,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      results: results ?? this.results,
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class SearchTrackNotifier extends AsyncNotifier<SearchTrackState> {
  Timer? _debounce;

  @override
  Future<SearchTrackState> build() async {
    ref.onDispose(() {
      _debounce?.cancel();
    });
    return const SearchTrackState();
  }

  void setQuery(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      state = const AsyncData(SearchTrackState());
      return;
    }

    state = const AsyncLoading();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (!ref.mounted) return;

      try {
        final repo = ref.read(trackServiceProvider);
        final response = await repo.searchTrack(query);

        if (!ref.mounted) return;

        state = AsyncData(
          SearchTrackState(
            query: query,
            results: response.results,
            nextCursor: response.nextCursor,
            hasMore: response.nextCursor != null && response.nextCursor!.isNotEmpty,
          ),
        );
      } catch (e, st) {
        if (!ref.mounted) return;
        state = AsyncError(e, st);
      }
    });
  }

  Future<void> loadMore() async {
    final before = state.value;
    if (before == null) return;
    if (!before.hasMore || before.isLoadingMore) return;
    if (before.nextCursor == null || before.nextCursor!.isEmpty) return;

    final requestedQuery = before.query;
    final requestedCursor = before.nextCursor!;

    state = AsyncData(before.copyWith(isLoadingMore: true));

    try {
      final repo = ref.read(trackServiceProvider);
      final response = await repo.searchTrack(
        requestedQuery,
        cursor: requestedCursor,
      );

      if (!ref.mounted) return;

      final current = state.value;
      if (current == null || current.query != requestedQuery) return;

      final mergedResults = [...current.results, ...response.results];

      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          results: mergedResults,
          nextCursor: response.nextCursor,
          hasMore: response.nextCursor != null && response.nextCursor!.isNotEmpty,
        ),
      );
    } catch (e) {
      if (!ref.mounted) return;

      // Keep existing results, just stop the loading indicator
      final current = state.value;
      if (current != null) {
        state = AsyncData(current.copyWith(isLoadingMore: false));
      }
    }
  }
}

final searchTrackProvider =
    AsyncNotifierProvider.autoDispose<SearchTrackNotifier, SearchTrackState>(
  SearchTrackNotifier.new,
);
