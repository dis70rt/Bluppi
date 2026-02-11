import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/search_track_model.dart';
import 'package:bluppi/domain/models/search_track_response_model.dart';
import 'package:bluppi/domain/models/track_model.dart';
import 'package:bluppi/domain/repositories/track_repository.dart';
import 'package:bluppi/generated/tracks.pbgrpc.dart' as proto;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackServiceProvider = Provider<TrackServiceRepository>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = proto.TrackServiceClient(channel);
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
  Future<SearchTrackResponse> searchTrack(String query, {int limit = 10, String? cursor}) async {
    final request = proto.SearchTracksRequest(query: query, limit: limit, cursor: cursor ?? "");
    final response = await _client.searchTracks(request);

    return SearchTrackResponse(
      results: response.tracks
          .map((p) => SearchTrackModel.fromProto(p))
          .toList(),
      nextCursor: response.nextCursor.isEmpty ? null : response.nextCursor,
    );
  }
}
