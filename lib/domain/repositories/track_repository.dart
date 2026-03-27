import 'package:bluppi/domain/models/history_track_model.dart';
import 'package:bluppi/domain/models/search_track_response_model.dart';
import 'package:bluppi/domain/models/track_model.dart';
import 'package:bluppi/domain/models/track_summary_model.dart';

abstract class TrackRepository {
  Future<TrackModel> getTrack(String id);
  Future<SearchTrackResponse> searchTrack(String query, {int limit = 10, String cursor = ""});
  Future<void> addTrackToHistory(String trackId);
  Future<List<HistoryTrackModel>> getHistoryTracks({int limit = 10, int offset = 0});
  Future<void> clearHistory();
  Future<List<TrackSummaryModel>> weeklyDiscoverTracks(String nextCursor, {int limit = 10});
}