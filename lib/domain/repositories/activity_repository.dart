import 'package:bluppi/domain/models/activity_model.dart';

abstract class ActivityRepository {
  Future<List<ActivityModel>> getFriendsFeed({int limit = 50, int offset = 0});
}