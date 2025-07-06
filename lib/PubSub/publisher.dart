import 'dart:async';
import 'package:bluppi/Data/Models/track_model.dart';

enum TrackEventType {
  play,
  pause, 
  seek,
  complete
}

class TrackEvent {
  final Track track;
  final TrackEventType type;
  final int? durationSeconds;
  
  TrackEvent({
    required this.track,
    required this.type,
    this.durationSeconds,
  });
}

// final trackEventBusProvider = Provider<TrackEventBus>((ref) {
//   return TrackEventBus();
// });

// class TrackEventBus {
//   final _controller = StreamController<TrackEvent>.broadcast();
  
//   Stream<TrackEvent> get stream => _controller.stream;
  
//   void publish(TrackEvent event) {
//     _controller.add(event);
//   }
  
//   void dispose() {
//     _controller.close();
//   }
// }

class TrackEventBus {
  TrackEventBus._();  
  static final TrackEventBus instance = TrackEventBus._();
  final _controller = StreamController<TrackEvent>.broadcast();
  Stream<TrackEvent> get stream => _controller.stream;
  void publish(TrackEvent e) => _controller.add(e);
  void dispose() => _controller.close();
}
