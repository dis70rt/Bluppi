import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Data/Services/database_services.dart';
import 'package:bluppi/Data/Services/user_services.dart';
import 'package:bluppi/PubSub/publisher.dart';

final trackDatabaseSubscriberProvider = Provider<void>((ref) {
  final eventBus = ref.watch(trackEventBusProvider);
  final database = Database();
  
  eventBus.stream.listen((event) {
    if (event.type == TrackEventType.play) {
      database.writeTrack(event.track, event.durationSeconds ?? 0);
    }
  });  
});

final trackHistorySubscriberProvider = Provider<void>((ref) {
  final eventBus = ref.watch(trackEventBusProvider);
  final userServices = UserServices();
  
  eventBus.stream.listen((event) {
    if (event.type == TrackEventType.play) {
      userServices.historyTrack(event.track.trackId);
    }
  });
});