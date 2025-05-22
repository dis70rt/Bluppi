import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';

class QueueState {
  final List<Track> items;
  final int currentIndex;
  final Set<int> autoRecommendedIndices;

  const QueueState({
    this.items = const [],
    this.currentIndex = -1,
    this.autoRecommendedIndices = const {},
  });

  Track? get current => (currentIndex >= 0 && currentIndex < items.length)
      ? items[currentIndex]
      : null;

  Track? get next =>
      (currentIndex + 1 < items.length) ? items[currentIndex + 1] : null;

  Track? get previous =>
      (currentIndex - 1 >= 0) ? items[currentIndex - 1] : null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueState &&
          runtimeType == other.runtimeType &&
          items == other.items &&
          currentIndex == other.currentIndex;

  @override
  int get hashCode => items.hashCode ^ currentIndex.hashCode;

  QueueState copyWith({
    List<Track>? items,
    int? currentIndex,
    Set<int>? autoRecommendedIndices,
  }) {
    return QueueState(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
      autoRecommendedIndices:
          autoRecommendedIndices ?? this.autoRecommendedIndices,
    );
  }
}

class QueueNotifier extends StateNotifier<QueueState> {
  QueueNotifier() : super(const QueueState());

  void add(Track track) {
    final isFirst = state.items.isEmpty;
    final newItems = [...state.items, track];
    final newIndex = isFirst ? 0 : state.currentIndex;
    state = state.copyWith(items: newItems, currentIndex: newIndex);
  }

  int playTrack(Track track) {
    int index = state.items.indexOf(track);
    List<Track> newItems = state.items;

    if (index == -1) {
      newItems = [...state.items, track];
      index = newItems.length - 1;

      state = state.copyWith(items: newItems, currentIndex: index);
      log("QueueNotifier: Added and playing new track '${track.trackName}' at index $index.");
    } else {
      if (state.currentIndex != index) {
        state = state.copyWith(currentIndex: index);
        log("QueueNotifier: Playing existing track '${track.trackName}' at index $index.");
      } else {
        log("QueueNotifier: Track '${track.trackName}' is already current at index $index.");
      }
    }
    return index;
  }

  // Track? next() {
  //   if (state.currentIndex + 1 >= state.items.length) return null;
  //   final idx = state.currentIndex + 1;
  //   state = QueueState(items: state.items, currentIndex: idx);
  //   return state.current;
  // }

  // Track? previous() {
  //   if (state.currentIndex - 1 < 0) return null;
  //   final idx = state.currentIndex - 1;
  //   state = QueueState(items: state.items, currentIndex: idx);
  //   return state.current;
  // }

  void addAfterCurrent(Track track) {
    if (state.currentIndex == -1 || state.items.isEmpty) {
      add(track);
      return;
    }

    final newIndex = state.currentIndex + 1;
    List<Track> newItems = List.from(state.items);

    if (newIndex < newItems.length &&
        state.autoRecommendedIndices.contains(newIndex)) {
      newItems[newIndex] = track;
      final newRecommended = Set<int>.from(state.autoRecommendedIndices);
      newRecommended.remove(newIndex);
      state = state.copyWith(
          items: newItems, autoRecommendedIndices: newRecommended);
      log("QueueNotifier: Replaced auto-recommended track with user track '${track.trackName}' at index $newIndex.");
    } else {
      newItems.insert(newIndex, track);
      state = state.copyWith(items: newItems);
      log("QueueNotifier: Added user track '${track.trackName}' after current at index $newIndex.");
    }
  }

  void addRecommendation(Track track) {
    final newItems = List<Track>.from(state.items);
    final newRecommended = Set<int>.from(state.autoRecommendedIndices);
    
    final newIndex = newItems.length;
    newItems.add(track);
    newRecommended.add(newIndex);
    
    state = state.copyWith(
      items: newItems, 
      autoRecommendedIndices: newRecommended
    );
    log("QueueNotifier: Added recommended track '${track.trackName}' at index $newIndex.");
  }

  void next() {
    if (state.currentIndex + 1 < state.items.length) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previous() {
    if (state.currentIndex - 1 >= 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void syncIndex(int newIndex) {
    if (newIndex >= -1 &&
        newIndex < state.items.length &&
        state.currentIndex != newIndex) {
      state = state.copyWith(currentIndex: newIndex);
    } else if (newIndex == -1 && state.currentIndex != -1) {
      state = state.copyWith(currentIndex: -1);
    }
  }

  void clear() => state = const QueueState();
}

final queueProvider =
    StateNotifierProvider<QueueNotifier, QueueState>((_) => QueueNotifier());
