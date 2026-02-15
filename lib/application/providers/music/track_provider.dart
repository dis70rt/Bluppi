import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:bluppi/domain/models/track_model.dart';
import 'package:riverpod/riverpod.dart';

final trackProvider =
    FutureProvider.autoDispose.family<TrackModel, String>((ref, trackId) async {
  final repo = ref.watch(trackServiceProvider);
  return repo.getTrack(trackId);
});
