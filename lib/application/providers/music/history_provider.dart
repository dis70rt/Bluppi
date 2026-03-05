import 'dart:convert';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bluppi/domain/models/history_track_model.dart';
import 'package:bluppi/data/grpc/repositories/track_service_client.dart';

final historyProvider =
    AsyncNotifierProvider<HistoryNotifier, List<HistoryTrackModel>>(
  HistoryNotifier.new,
);

class HistoryNotifier extends AsyncNotifier<List<HistoryTrackModel>> {
  static const _prefsKey = 'history_tracks';
  SharedPreferences? _prefs;

  @override
  Future<List<HistoryTrackModel>> build() async {
    _prefs = await SharedPreferences.getInstance();

    ref.listen<QueueState>(queueProvider, (prev, next) {
      final prevTrackId = prev?.currentItem?.track.id;
      final nextItem = next.currentItem;

      if (nextItem != null && nextItem.track.id != prevTrackId) {
        add(
          HistoryTrackModel(
            trackId: nextItem.track.id,
            title: nextItem.track.title,
            artist: nextItem.track.artist,
            imageLarge: nextItem.track.imageLarge,
            imageSmall: nextItem.track.imageSmall,
            playedAt: DateTime.now(),
          ),
        );
      }
    });


    try {
      final cached = _prefs?.getString(_prefsKey);
      if (cached != null) {
        return (jsonDecode(cached) as List)
            .map((e) => HistoryTrackModel.fromJson(e))
            .toList();
      }
    } catch (_) {}

    try {
      final repo = ref.read(trackServiceProvider);
      final remote = await repo.getHistoryTracks();
      await _saveToPrefs(remote);
      return remote;
    } catch (_) {
      return [];
    }
  }

  Future<void> add(HistoryTrackModel entry) async {
    final current = List<HistoryTrackModel>.from(state.value ?? []);
    current.removeWhere((e) => e.trackId == entry.trackId);
    current.insert(0, entry);
    if (current.length > 10) {
      current.removeRange(10, current.length);
    }
    state = AsyncData(List<HistoryTrackModel>.from(current));
    await _saveToPrefs(current);
    _syncToApi(entry);
  }

  Future<void> clear() async {
    state = const AsyncData([]);
    await _prefs?.remove(_prefsKey);
    _clearRemote();
  }

  Future<void> _saveToPrefs(List<HistoryTrackModel> list) async {
    final encoded = jsonEncode(list.map((e) => e.toJson()).toList());
    await _prefs?.setString(_prefsKey, encoded);
  }

  Future<void> _syncToApi(HistoryTrackModel entry) async {
    try {
      final repo = ref.read(trackServiceProvider);
      await repo.addTrackToHistory(entry.trackId);
    } catch (_) {}
  }

  Future<void> _clearRemote() async {
    try {
      final repo = ref.read(trackServiceProvider);
      await repo.clearHistory();
    } catch (_) {}
  }
}