import 'dart:async';

import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:bluppi/domain/models/search_track_model.dart';
import 'package:riverpod/riverpod.dart';

class SearchTrackState {
  final String query;
  final bool isLoading;
  final bool isLoadingMore;
  final List<SearchTrackModel> results;
  final String? nextCursor;
  final bool hasMore;

  const SearchTrackState({
    this.query = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.results = const [],
    this.nextCursor,
    this.hasMore = true,
  });

  SearchTrackState copyWith({
    String? query,
    bool? isLoading,
    bool? isLoadingMore,
    List<SearchTrackModel>? results,
    String? nextCursor,
    bool? hasMore,
  }) {
    return SearchTrackState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
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
      state = const AsyncValue.data(SearchTrackState());
      return;
    }

    state = AsyncValue.data(
      SearchTrackState(
        query: query,
        isLoading: true,
        results: const [],
        nextCursor: null,
        hasMore: true,
      ),
    );

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      try {
        final repo = ref.read(trackServiceProvider);
        final response = await repo.searchTrack(query);

        if (!ref.mounted) return;

        state = AsyncValue.data(
          state.value!.copyWith(
            isLoading: false,
            results: response.results,
            nextCursor: response.nextCursor,
            hasMore: response.nextCursor != null,
          ),
        );
      } catch (e, st) {
        if (!ref.mounted) return;
        state = AsyncValue.error(e, st);
      }
    });
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null) return;
    if (!current.hasMore || current.isLoadingMore) return;

    state = AsyncValue.data(
      current.copyWith(isLoadingMore: true),
    );

    try {
      final repo = ref.read(trackServiceProvider);
      final response = await repo.searchTrack(
        current.query,
        cursor: current.nextCursor,
      );

      if (!ref.mounted) return;

      state = AsyncValue.data(
        current.copyWith(
          isLoadingMore: false,
          results: [...current.results, ...response.results],
          nextCursor: response.nextCursor,
          hasMore: response.nextCursor != null,
        ),
      );
    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncValue.error(e, st);
    }
  }
}


final searchTrackProvider =
    AsyncNotifierProvider.autoDispose<SearchTrackNotifier, SearchTrackState>(
      SearchTrackNotifier.new,
    );
