import 'package:bluppi/domain/models/track_model.dart';
import 'package:riverpod/riverpod.dart';

enum QueueSource { user, radio, autoplay }

class QueueItem {
  final TrackModel track;
  final QueueSource source;

  const QueueItem({required this.track, required this.source});

  QueueItem copyWith({TrackModel? track, QueueSource? source}) {
    return QueueItem(track: track ?? this.track, source: source ?? this.source);
  }
}

class QueueState {
  final List<QueueItem> items;
  final int currentIndex;

  const QueueState({required this.items, required this.currentIndex});

  QueueState copyWith({List<QueueItem>? items, int? currentIndex}) {
    return QueueState(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  QueueItem? get currentItem =>
      items.isEmpty || currentIndex < 0 || currentIndex >= items.length
      ? null
      : items[currentIndex];
  
  TrackModel? get currentTrack => currentItem?.track;

  bool get hasNext => items.isNotEmpty && currentIndex < items.length - 1;

  bool get hasPrevious => items.isNotEmpty && currentIndex > 0;
}

class QueueNotifier extends Notifier<QueueState> {
  @override
  QueueState build() => const QueueState(items: [], currentIndex: 0);

  void setQueue(List<TrackModel> tracks, QueueSource source) {
    final newItems = tracks
        .map((track) => QueueItem(track: track, source: source))
        .toList(growable: false);
    state = QueueState(items: newItems, currentIndex: 0);
  }

  void playNext(TrackModel track) {
    final current = state.currentIndex;
    final items = List<QueueItem>.from(state.items);
    final insertIndex = items.isEmpty ? 0 : current + 1;
    items.insert(
      insertIndex,
      QueueItem(track: track, source: QueueSource.user),
    );
    state = state.copyWith(items: List.unmodifiable(items));
  }

  void addToBack(TrackModel track, QueueSource source) {
    final items = List<QueueItem>.from(state.items)
      ..add(QueueItem(track: track, source: source));
    state = state.copyWith(items: List.unmodifiable(items));
  }

  void jumpToIndex(int index) {
    if (index < 0 || index >= state.items.length) return;
    state = state.copyWith(currentIndex: index);
  }

  void skipNext() {
    if (state.hasNext) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void skipPrevious() {
    if (state.hasPrevious) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void removeAt(int index) {
    if (index < 0 || index >= state.items.length) return;

    final items = List<QueueItem>.from(state.items)..removeAt(index);
    int newIndex = state.currentIndex;
    if (index < state.currentIndex) newIndex--;

    if (newIndex >= items.length) {
      newIndex = items.isEmpty ? 0 : items.length - 1;
    }

    state = state.copyWith(items: items, currentIndex: newIndex);
  }

  void clear() {
    state = const QueueState(items: [], currentIndex: 0);
  }
}

final queueProvider = NotifierProvider<QueueNotifier, QueueState>(
  QueueNotifier.new,
);
