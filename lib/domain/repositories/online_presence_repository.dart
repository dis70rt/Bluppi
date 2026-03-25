import 'package:bluppi/domain/models/online_presence_model.dart';

abstract class OnlinePresenceRepository {
  Stream<PresenceEvent> subscribePresence(List<String> targetUserIds);
}