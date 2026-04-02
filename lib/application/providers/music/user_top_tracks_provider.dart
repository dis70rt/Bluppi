import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:bluppi/domain/models/top_track_entry_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserTopTracksNotifier extends AsyncNotifier<List<TopTrackEntryModel>> {
  final String userId;
  UserTopTracksNotifier(this.userId);

  @override
  Future<List<TopTrackEntryModel>> build() async {
    final repo = ref.read(trackServiceProvider);
    return await repo.getUserTopTracks(userId, limit: 5);
  }
}

final userTopTracksProvider = AsyncNotifierProvider.family
    .autoDispose<UserTopTracksNotifier, List<TopTrackEntryModel>, String>(
      (userId) => UserTopTracksNotifier(userId),
    );
