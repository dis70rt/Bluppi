import 'dart:developer';

import 'package:bluppi/Data/Models/track_model.dart';
import 'package:bluppi/Data/Services/database_services.dart';
import 'package:bluppi/Data/Services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryTrack {
  final Track track;
  final DateTime playedAt;

  HistoryTrack({required this.track, required this.playedAt});

  HistoryTrack copyWith({
    Track? track,
    DateTime? playedAt,
  }) {
    return HistoryTrack(
      track: track ?? this.track,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  factory HistoryTrack.empty() {
    return HistoryTrack(track: Track.empty(), playedAt: DateTime.now());
  }
}

class RecentlyPlayedState {
  final List<HistoryTrack> tracks;
  final bool isLoading;
  final String? error;

  const RecentlyPlayedState({
    this.tracks = const [],
    this.isLoading = false,
    this.error,
  });

  RecentlyPlayedState copyWith({
    List<HistoryTrack>? tracks,
    bool? isLoading,
    String? error,
  }) {
    return RecentlyPlayedState(
      tracks: tracks ?? this.tracks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final recentlyPlayedProvider =
    StateNotifierProvider<RecentlyPlayedNotifier, RecentlyPlayedState>((ref) {
  final userServices = UserServices();
  final database = Database();
  return RecentlyPlayedNotifier(userServices, database);
});

class RecentlyPlayedNotifier extends StateNotifier<RecentlyPlayedState> {
  final UserServices userServices;
  final Database database;
  RecentlyPlayedNotifier(this.userServices, this.database)
      : super(const RecentlyPlayedState()) {
    initialize();
  }

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, error: null);
    final recentlyPlayedTracks = await getHistoryTracks();
    state = state.copyWith(
      tracks: recentlyPlayedTracks,
      isLoading: false,
    );
  }

  Future<void> addTrack(Track track) async {
    try {
      final historyTrack = HistoryTrack(
        track: track,
        playedAt: DateTime.now(),
      );

      final updatedTracks = [historyTrack, ...state.tracks];
      state = state.copyWith(tracks: updatedTracks);

      await userServices.addHistoryTrack(track.trackId);
    } catch (e) {
      final revertedTracks =
          state.tracks.where((t) => t.track.trackId != track.trackId).toList();
      state = state.copyWith(
        tracks: revertedTracks,
        error: 'Failed to add track to history: ${e.toString()}',
      );
    }
  }

  Future<List<HistoryTrack>> getHistoryTracks() async {
    try {
      final historyEntries = await userServices.getHistoryTracks();
      if (historyEntries.isEmpty) {
        return [];
      }

      final List<Future<HistoryTrack?>> historyTrackFutures =
          historyEntries.map((historyEntry) {
        final trackId = historyEntry['trackId'];
        final playedAt = historyEntry['playedAt'];

        return Future<HistoryTrack?>(() async {
          final trackJson = await database.getTrack(trackId.toString());
          final track = Track.fromJson(trackJson['track']);
          return HistoryTrack(track: track, playedAt: playedAt);
        });
      }).toList();

      final List<HistoryTrack?> results =
          await Future.wait(historyTrackFutures);
      final List<HistoryTrack> validHistoryTracks =
          results.whereType<HistoryTrack>().toList();

      return validHistoryTracks;
    } catch (e, stackTrace) {
      log('Error fetching history tracks: $e');
      debugPrint('StackTrace: $stackTrace');
      return [];
    }
  }

  Future<bool> clearAllHistory() async {
    try {
      final currentTracks = state.tracks;
      state = state.copyWith(tracks: [], error: null);

      final success = await userServices.deleteAllHistoryTracks();

      if (!success) {
        state = state.copyWith(
          tracks: currentTracks,
          error: 'Failed to clear history',
        );
        return false;
      }

      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<void> refreshHistory() async {
    await initialize();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
