import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';

class QueueState {
  final List<Track> items;
  final int currentIndex;
  final Set<int> autoRecommendedIndices;
  final int version;

  const QueueState({
    this.items = const [],
    this.currentIndex = -1,
    this.autoRecommendedIndices = const {},
    this.version = 0,
  });

  Track? get current => (currentIndex >= 0 && currentIndex < items.length)
      ? items[currentIndex]
      : null;

  Track? get next =>
      (currentIndex + 1 < items.length) ? items[currentIndex + 1] : null;

  Track? get previous =>
      (currentIndex - 1 >= 0) ? items[currentIndex - 1] : null;

  int get remainingTracks => items.length - currentIndex - 1;

  bool get isEmpty => items.isEmpty;
  bool get isValidIndex => currentIndex >= 0 && currentIndex < items.length;

  QueueState copyWith({
    List<Track>? items,
    int? currentIndex,
    Set<int>? autoRecommendedIndices,
    int? version,
  }) {
    return QueueState(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
      autoRecommendedIndices:
          autoRecommendedIndices ?? this.autoRecommendedIndices,
      version: version ?? (this.version + 1),
    );
  }
}

class QueueNotifier extends StateNotifier<QueueState> {
  QueueNotifier() : super(const QueueState());

  void add(Track track) {
    if (_isDuplicate(track)) return;

    final isFirst = state.items.isEmpty;
    final newItems = List<Track>.from(state.items)..add(track);
    final newIndex = isFirst ? 0 : state.currentIndex;

    state = state.copyWith(
      items: newItems,
      currentIndex: newIndex,
    );
  }

  int playTrack(Track track) {
    int index = _findTrackIndex(track);

    if (index == -1) {
      final newItems = List<Track>.from(state.items)..add(track);
      index = newItems.length - 1;

      state = state.copyWith(
        items: newItems,
        currentIndex: index,
        version: state.version + 1,
      );
    } else if (state.currentIndex != index) {
      final tracksToKeep = state.items.sublist(0, index + 1);

      state = state.copyWith(
        items: tracksToKeep,
        currentIndex: index,
        version: state.version + 1,
        autoRecommendedIndices: {},
      );
    }

    return index;
  }

  bool playTrackAtIndex(int index) {
    
    if (index < 0 || index >= state.items.length) return false;

    if (state.currentIndex != index) {
      final tracksToKeep = state.items.sublist(0, index + 1);
      final newRecommended =
          state.autoRecommendedIndices.where((i) => i <= index).toSet();

      state = state.copyWith(
        items: tracksToKeep,
        currentIndex: index,
        autoRecommendedIndices: newRecommended,
      );
    }

    return true;
  }

  void addAfterCurrent(Track track) {
    if (_isDuplicate(track)) return;

    if (state.currentIndex == -1 || state.items.isEmpty) {
      add(track);
      return;
    }

    final insertIndex = state.currentIndex + 1;
    final newItems = List<Track>.from(state.items);
    final newRecommended = Set<int>.from(state.autoRecommendedIndices);

    if (insertIndex < newItems.length && newRecommended.contains(insertIndex)) {
      newItems[insertIndex] = track;
      newRecommended.remove(insertIndex);
    } else {
      newItems.insert(insertIndex, track);

      final shiftedRecommended =
          newRecommended.map((i) => i >= insertIndex ? i + 1 : i).toSet();
      newRecommended
        ..clear()
        ..addAll(shiftedRecommended);
    }

    state = state.copyWith(
      items: newItems,
      autoRecommendedIndices: newRecommended,
    );
  }

  void addRecommendation(Track track) {
    if (_isDuplicate(track)) return;

    final newItems = List<Track>.from(state.items)..add(track);
    final newRecommended = Set<int>.from(state.autoRecommendedIndices)
      ..add(newItems.length - 1);

    state = state.copyWith(
      items: newItems,
      autoRecommendedIndices: newRecommended,
    );
  }

  void removeAt(int index) {
    if (index < 0 || index >= state.items.length) return;

    final newItems = List<Track>.from(state.items)..removeAt(index);
    final newRecommended = Set<int>.from(state.autoRecommendedIndices);

    newRecommended.remove(index);

    final adjustedRecommended = newRecommended
        .map((i) => i > index ? i - 1 : i)
        .where((i) => i < newItems.length)
        .toSet();

    int newCurrentIndex = state.currentIndex;
    if (index == state.currentIndex) {
      if (newItems.isEmpty) {
        newCurrentIndex = -1;
      } else if (index >= newItems.length) {
        newCurrentIndex = newItems.length - 1;
      }
    } else if (index < state.currentIndex) {
      newCurrentIndex = state.currentIndex - 1;
    }

    state = state.copyWith(
      items: newItems,
      currentIndex: newCurrentIndex,
      autoRecommendedIndices: adjustedRecommended,
    );
  }

  void syncIndex(int newIndex) {
    if (newIndex == state.currentIndex) return;

    if (newIndex == -1) {
      state = state.copyWith(currentIndex: -1);
    } else if (newIndex >= 0 && newIndex < state.items.length) {
      state = state.copyWith(currentIndex: newIndex);
    }
  }

  void clear() {
    state = const QueueState();
  }

  void removeUpcoming() {
    if (state.currentIndex == -1 || state.items.isEmpty) return;

    if (state.currentIndex < state.items.length - 1) {
      final newItems = state.items.sublist(0, state.currentIndex + 1);
      final newRecommended = state.autoRecommendedIndices
          .where((i) => i <= state.currentIndex)
          .toSet();

      state = state.copyWith(
        items: newItems,
        autoRecommendedIndices: newRecommended,
      );
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= state.items.length ||
        newIndex < 0 ||
        newIndex >= state.items.length) return;

    final newItems = List<Track>.from(state.items);
    final item = newItems.removeAt(oldIndex);
    newItems.insert(newIndex, item);

    int newCurrentIndex = state.currentIndex;
    if (oldIndex == state.currentIndex) {
      newCurrentIndex = newIndex;
    } else if (oldIndex < state.currentIndex &&
        newIndex >= state.currentIndex) {
      newCurrentIndex--;
    } else if (oldIndex > state.currentIndex &&
        newIndex <= state.currentIndex) {
      newCurrentIndex++;
    }

    state = state.copyWith(
      items: newItems,
      currentIndex: newCurrentIndex,
      autoRecommendedIndices: {},
    );
  }

  bool _isDuplicate(Track track) {
    return state.items.any((item) => item.trackId == track.trackId);
  }

  int _findTrackIndex(Track track) {
    return state.items.indexWhere((item) => item.trackId == track.trackId);
  }
}

final queueProvider = StateNotifierProvider<QueueNotifier, QueueState>(
  (_) => QueueNotifier(),
);
