import 'dart:developer';

import 'package:bluppi/Data/Services/database_services.dart';
import 'package:bluppi/Data/Services/user_services.dart';
import 'package:bluppi/Provider/RoomProvider/room_sync_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/PubSub/publisher.dart';

final trackDatabaseSubscriberProvider = Provider<void>((ref) {
  final eventBus = TrackEventBus.instance;
  final database = Database();

  final sub = eventBus.stream.listen((event) {
    if (event.type == TrackEventType.play) {
      database.writeTrack(event.track, event.durationSeconds ?? 0);
      log("Track written to database: ${event.track.trackName}", name: "Subscriber");
    }
  });

  ref.onDispose(sub.cancel);
});

final trackHistorySubscriberProvider = Provider<void>((ref) {
  final eventBus = TrackEventBus.instance;
  final userServices = UserServices();

  final sub = eventBus.stream.listen((event) {
    if (event.type == TrackEventType.play) {
      userServices.historyTrack(event.track.trackId);
      log("Track history updated for: ${event.track.trackName}", name: "Subscriber");
    }
  });

  ref.onDispose(sub.cancel);
});

final trackSyncSubscriberProvider = Provider<void>((ref) {
  final eventBus = TrackEventBus.instance;
  final syncNotifier = ref.watch(roomSyncProvider.notifier);

  final sub = eventBus.stream.listen((event) {
    try {
      log("TrackEvent: ${event.track.trackName} - ${event.type}",
          name: "TrackSyncSubscriber");

      switch (event.type) {
        case TrackEventType.play:
          log("Syncing play command for track: ${event.track.trackName}",
              name: "TrackSyncSubscriber");
          syncNotifier.hostCommand(
            trackCommand: syncNotifier.trackCommand(
              track: event.track,
              startPosition: 0,
              duration: event.durationSeconds ?? 0,
            ),
          );
          break;
        case TrackEventType.pause:
          break;
        case TrackEventType.seek:
          break;
        case TrackEventType.complete:
          break;
      }
    } catch (e, stack) {
      log("Error processing TrackEvent: $e\n$stack", name: "Subscriber");
    }
  }, onError: (error, stackTrace) {
    log("Error: $error\n$stackTrace", name: "Subscriber");
  });

  ref.onDispose(sub.cancel);
});
