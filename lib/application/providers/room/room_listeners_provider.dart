import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomListenersProvider =
    NotifierProvider<RoomListenersNotifier, List<String>>(
      RoomListenersNotifier.new,
    );

class RoomListenersNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void addListener(String userId) {
    if (!state.contains(userId)) {
      state = [...state, userId];
    }
  }

  void removeListener(String userId) {
    state = state.where((id) => id != userId).toList();
  }

  void clear() {
    state = [];
  }
}
