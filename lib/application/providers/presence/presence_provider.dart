import 'dart:async';
import 'dart:developer';

import 'package:bluppi/data/grpc/repositories/presence_stream_service.dart';
import 'package:bluppi/domain/models/online_presence_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final presenceProvider =
    NotifierProvider<PresenceNotifier, Map<String, PresenceEvent>>(
      PresenceNotifier.new,
    );

class PresenceNotifier extends Notifier<Map<String, PresenceEvent>> {
  StreamSubscription<PresenceEvent>? _subscription;

  @override
  Map<String, PresenceEvent> build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });

    // TODO: do a network call to send the target user ids and subscribe to their presence
    return {};
  }

  void startListening(List<String> friendIds) {
    if (friendIds.isEmpty) return;

    _subscription?.cancel();

    final repository = ref.read(onlinePresenceServiceProvider);
    _subscription = repository
        .subscribePresence(friendIds)
        .listen(
          (event) {
            state = {...state, event.userId: event};
          },
          onError: (error) {
            log('Error subscribing to presence updates: $error');
          },
        );
  }

  PresenceEvent? getPresence(String userId) {
    return state[userId];
  }
}
