import 'package:bluppi/data/auth/auth_interceptor.dart';
import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/history_track_model.dart';
import 'package:bluppi/domain/models/like_track_entry_model.dart';
import 'package:bluppi/domain/models/search_track_model.dart';
import 'package:bluppi/domain/models/search_track_response_model.dart';
import 'package:bluppi/domain/models/top_track_entry_model.dart';
import 'package:bluppi/domain/models/track_model.dart';
import 'package:bluppi/domain/models/track_summary_model.dart';
import 'package:bluppi/domain/repositories/track_repository.dart';
import 'package:bluppi/generated/tracks.pbgrpc.dart' as proto;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackServiceProvider = Provider<TrackServiceRepository>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = proto.TrackServiceClient(
    channel,
    interceptors: [AuthInterceptor()],
  );
  return TrackServiceRepository(client);
});

class TrackServiceRepository implements TrackRepository {
  final proto.TrackServiceClient _client;

  TrackServiceRepository(this._client);

  @override
  Future<TrackModel> getTrack(String id) async {
    final request = proto.GetTrackRequest(trackId: id);
    final response = await _client.getTrack(request);
    return TrackModel.fromProto(response.track);
  }

  @override
  Future<SearchTrackResponse> searchTrack(
    String query, {
    int limit = 10,
    String? cursor,
  }) async {
    final request = proto.SearchTracksRequest(
      query: query,
      limit: limit,
      cursor: cursor ?? "",
    );
    final response = await _client.searchTracks(request);

    return SearchTrackResponse(
      results: response.tracks
          .map((p) => SearchTrackModel.fromProto(p))
          .toList(),
      nextCursor: response.nextCursor.isEmpty ? null : response.nextCursor,
    );
  }

  @override
  Future<void> addTrackToHistory(String trackId) async {
    final request = proto.AddTrackToHistoryRequest(trackId: trackId);
    await _client.addTrackToHistory(request);
  }

  @override
  Future<List<HistoryTrackModel>> getHistoryTracks({
    int limit = 10,
    int offset = 0,
  }) async {
    final request = proto.GetTrackHistoryRequest(limit: limit, offset: offset);
    final response = await _client.getTrackHistory(request);

    return response.history.map((p) => HistoryTrackModel.fromProto(p)).toList();
  }

  @override
  Future<void> clearHistory() async {
    final request = proto.ClearTrackHistoryRequest();
    await _client.clearTrackHistory(request);
  }

  @override
  Future<List<TrackSummaryModel>> weeklyDiscoverTracks(
    String nextCursor, {
    int limit = 10,
  }) async {
    final request = proto.DiscoverTracksRequest(
      limit: limit,
      nextCursor: nextCursor,
    );
    final response = await _client.weeklyDiscoverTracks(request);
    return response.tracks
        .map((proto.TrackSummary t) => TrackSummaryModel.fromProto(t))
        .toList();
  }

  @override
  Future<void> likeTrack(String trackId) async {
    final request = proto.LikeTrackRequest(trackId: trackId);
    await _client.likeTrack(request);
  }

  @override
  Future<void> unlikeTrack(String trackId) async {
    final request = proto.UnlikeTrackRequest(trackId: trackId);
    await _client.unlikeTrack(request);
  }

  @override
  Future<bool> isTrackLiked(String trackId) async {
    final request = proto.IsTrackLikedRequest(trackId: trackId);
    final response = await _client.isTrackLiked(request);
    return response.isLiked;
  }

  @override
  Future<(List<LikedTrackModel>, String?, int, bool)> getLikedTracks(
    String userId, {
    int limit = 10,
    String? cursor,
  }) async {
    final request = proto.GetLikedTracksRequest(
      targetUserId: userId,
      limit: limit,
      cursor: cursor ?? "",
    );

    final response = await _client.getLikedTracks(request);
    final likedTracks = response.tracks
        .map((proto.LikedTrackEntry entry) => LikedTrackModel.fromProto(entry))
        .toList();
    final nextCursor = response.nextCursor.isEmpty ? null : response.nextCursor;
    final total = response.total.toInt();
    return (likedTracks, nextCursor, total, response.hasMore);
  }

  @override
  Future<List<TopTrackEntryModel>> getUserTopTracks(
    String userId, {
    int limit = 5,
    int timeRange = 0,
  }) async {
    final request = proto.GetUserTopTracksRequest(
      targetUserId: userId,
      limit: limit,
      timeRange: proto.TimeRange.valueOf(timeRange) ?? proto.TimeRange.TIME_RANGE_ALL_TIME,
    );
    final response = await _client.getUserTopTracks(request);
    return response.tracks
        .map((proto.TopTrackEntry t) => TopTrackEntryModel.fromProto(t))
        .toList();
  }
}
