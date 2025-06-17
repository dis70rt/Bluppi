import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/MusicProvider/track_search_provider.dart';

class PaginatedSearchState {
  final List<Track> tracks;
  final bool isLoading;
  final bool hasMore;
  final int offset;
  final String query;

  PaginatedSearchState({
    required this.tracks,
    this.isLoading = false,
    this.hasMore = true,
    this.offset = 0,
    this.query = '',
  });

  PaginatedSearchState copyWith({
    List<Track>? tracks,
    bool? isLoading,
    bool? hasMore,
    int? offset,
    String? query,
  }) {
    return PaginatedSearchState(
      tracks: tracks ?? this.tracks,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      offset: offset ?? this.offset,
      query: query ?? this.query,
    );
  }
}

class PaginatedSearchNotifier extends StateNotifier<PaginatedSearchState> {
  final TrackRepository _repository;
  
  PaginatedSearchNotifier(this._repository) 
    : super(PaginatedSearchState(tracks: []));

  Future<void> searchTracks(String query, {bool refresh = false}) async {
    if (refresh) {
      state = PaginatedSearchState(tracks: [], query: query);
    }
    
    if (state.isLoading || (!refresh && state.query != query)) {
      state = state.copyWith(tracks: [], offset: 0, query: query);
    }

    state = state.copyWith(isLoading: true);

    try {
      final response = await _repository.searchTracks(
        query,
        limit: 10,
        offset: state.offset,
      );

      final newTracks = response.results;
      final hasMore = newTracks.length == 10;

      state = state.copyWith(
        tracks: [...state.tracks, ...newTracks],
        isLoading: false,
        hasMore: hasMore,
        offset: state.offset + newTracks.length,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, hasMore: false);
      rethrow;
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading) return;
    await searchTracks(state.query);
  }
}

final paginatedSearchProvider = StateNotifierProvider<PaginatedSearchNotifier, PaginatedSearchState>((ref) {
  final repository = ref.watch(trackRepositoryProvider);
  return PaginatedSearchNotifier(repository);
});

final paginatedBottomSheetSearchProvider = StateNotifierProvider.family<
    PaginatedSearchNotifier, PaginatedSearchState, String>((ref, query) {
  final repository = ref.watch(trackRepositoryProvider);
  return PaginatedSearchNotifier(repository)..searchTracks(query, refresh: true);
});