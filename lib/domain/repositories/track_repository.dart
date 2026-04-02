import 'package:bluppi/domain/models/history_track_model.dart';
import 'package:bluppi/domain/models/like_track_entry_model.dart';
import 'package:bluppi/domain/models/search_track_response_model.dart';
import 'package:bluppi/domain/models/top_track_entry_model.dart';
import 'package:bluppi/domain/models/track_model.dart';
import 'package:bluppi/domain/models/track_summary_model.dart';

abstract class TrackRepository {
  Future<TrackModel> getTrack(String id);
  Future<SearchTrackResponse> searchTrack(String query, {int limit = 10, String cursor = ""});
  Future<void> addTrackToHistory(String trackId);
  Future<List<HistoryTrackModel>> getHistoryTracks({int limit = 10, int offset = 0});
  Future<void> clearHistory();
  Future<List<TrackSummaryModel>> weeklyDiscoverTracks(String nextCursor, {int limit = 10});
  
  Future<void> likeTrack(String trackId);
  Future<void> unlikeTrack(String trackId);
  Future<bool> isTrackLiked(String trackId);
  Future<(List<LikedTrackModel>, String?, int, bool)> getLikedTracks(String userId, {int limit = 10, String? cursor});
  Future<List<TopTrackEntryModel>> getUserTopTracks(String userId, {int limit = 5, int timeRange = 0});
}