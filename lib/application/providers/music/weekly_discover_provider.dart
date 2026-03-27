import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:bluppi/domain/models/track_summary_model.dart';

final weeklyDiscoverProvider = AsyncNotifierProvider.autoDispose<
    WeeklyDiscoverNotifier, List<TrackSummaryModel>>(
  WeeklyDiscoverNotifier.new,
);

class WeeklyDiscoverNotifier extends AsyncNotifier<List<TrackSummaryModel>> {
  @override
  FutureOr<List<TrackSummaryModel>> build() async {
    return _fetchDiscoverTracks();
  }

  Future<List<TrackSummaryModel>> _fetchDiscoverTracks({String cursor = ""}) async {
    final trackRepository = ref.read(trackServiceProvider);
    return await trackRepository.weeklyDiscoverTracks(cursor);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDiscoverTracks());
  }
}