import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';

class QueueState {
  final List<Track> items;
  final int currentIndex;

  const QueueState({
    this.items = const [],
    this.currentIndex = -1,
  });

  Track? get current => (currentIndex >= 0 && currentIndex < items.length)
      ? items[currentIndex]
      : null;

  Track? get next =>
      (currentIndex + 1 < items.length) ? items[currentIndex + 1] : null;

  Track? get previous =>
      (currentIndex - 1 >= 0) ? items[currentIndex - 1] : null;
}

class QueueNotifier extends StateNotifier<QueueState> {
  QueueNotifier() : super(const QueueState());

  void add(Track track) {
    final isFirst = state.items.isEmpty;
    final newItems = [...state.items, track];
    final newIndex = isFirst ? 0 : state.currentIndex;
    state = QueueState(items: newItems, currentIndex: newIndex);
  }

  Track? playTrack(Track track) {
    int index = state.items.indexOf(track);

    if (index == -1) {
      final newItems = [...state.items, track];
      index = newItems.length - 1;
      state = QueueState(items: newItems, currentIndex: index);
      return state.current;
    } else {
      if (state.currentIndex != index) {
          state = QueueState(items: state.items, currentIndex: index);
      }
      return state.current;
    }
  }

  Track? next() {
    if (state.currentIndex + 1 >= state.items.length) return null;
    final idx = state.currentIndex + 1;
    state = QueueState(items: state.items, currentIndex: idx);
    return state.current;
  }

  Track? previous() {
    if (state.currentIndex - 1 < 0) return null;
    final idx = state.currentIndex - 1;
    state = QueueState(items: state.items, currentIndex: idx);
    return state.current;
  }
}

final queueProvider =
    StateNotifierProvider<QueueNotifier, QueueState>((_) => QueueNotifier());
