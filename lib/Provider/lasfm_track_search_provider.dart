import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/lastfm_track_state.dart';

import 'track_repository.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final trackSearchProvider = Provider<TrackRepository>(
  (ref) => TrackRepository(ref.watch(dioProvider)),
);

final trackNotifierProvider = StateNotifierProvider<TrackNotifier, TrackState>(
  (ref) => TrackNotifier(ref.watch(trackSearchProvider)),
);

class TrackNotifier extends StateNotifier<TrackState> {
  final TrackRepository _repository;

  TrackNotifier(this._repository) : super(TrackInitial());

  Future<void> searchAndSuggestTracks(String query) async {
    if (query.isEmpty) {
      state = TrackInitial();
      return;
    }

    state = TrackLoading();

    // try {
      List<Track> itunesResults = await _repository.searchItunesTracks(query);

      if (itunesResults.isEmpty) {
        state = const TrackSuccess(
            searchResults: [], bestResult: null, suggestedTracks: []);
        return;
      }

      List<Track> enrichedResults = [];
      for (final track in itunesResults) {
        final lastFmData = await _repository.fetchLastFmTrackInfo(
            track.artistName, track.trackName);
        if (lastFmData != null) {
          enrichedResults.add(track.copyWith(
            listeners: lastFmData['listeners'],
            playcount: lastFmData['playcount'],
            lastFmUrl: lastFmData['url'],
          ));
        } else {
          enrichedResults.add(track);
        }
      }

      List<Track> sortedForBest = List.from(enrichedResults);
      sortedForBest.sort((a, b) {
        bool aHasPop = a.popularityScore > 0;
        bool bHasPop = b.popularityScore > 0;

        if (aHasPop && !bHasPop) return -1;
        if (!aHasPop && bHasPop) return 1;
        if (aHasPop && bHasPop) {
          return b.popularityScore.compareTo(a.popularityScore);
        }

        return 0;
      });

      Track? bestResult = sortedForBest.isNotEmpty ? sortedForBest.first : null;

      List<Track> suggestedTracks = [];
      if (bestResult?.primaryGenreName != null &&
          bestResult!.primaryGenreName!.isNotEmpty) {
        final genre = bestResult.primaryGenreName!;
        List<Track> topGenreTracks =
            await _repository.fetchTopTracksByGenre(genre, limit: 10);

        suggestedTracks = topGenreTracks
            .where((suggested) => !(suggested.trackName.toLowerCase() ==
                    bestResult.trackName.toLowerCase() &&
                suggested.artistName.toLowerCase() ==
                    bestResult.artistName.toLowerCase()))
            .take(5)
            .toList();
      }

      state = TrackSuccess(
        searchResults: enrichedResults,
        bestResult: bestResult,
        suggestedTracks: suggestedTracks,
      );
    // } catch (e) {
    //   state = TrackError('Failed to fetch tracks: ${e.toString()}');
    // }
  }
}
