import 'package:bluppi/domain/models/search_track_model.dart';

class SearchTrackResponse {
  final List<SearchTrackModel> results;
  final String? nextCursor;

  const SearchTrackResponse({
    required this.results,
    required this.nextCursor,
  });
}
