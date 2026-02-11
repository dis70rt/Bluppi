import 'package:bluppi/domain/models/search_track_response_model.dart';
import 'package:bluppi/domain/models/track_model.dart';

abstract class TrackRepository {
  Future<TrackModel> getTrack(String id);
  Future<SearchTrackResponse> searchTrack(String query, {int limit = 10, String cursor = ""});
}