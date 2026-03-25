
import 'package:bluppi/data/auth/auth_interceptor.dart';
import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/activity_model.dart';
import 'package:bluppi/domain/repositories/activity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/generated/friends_activity.pbgrpc.dart' as proto;

final activityServiceProvider = Provider<ActivityServiceRepository>((ref) {
  final channel = ref.read(grpcChannelProvider);
  final client = proto.FriendsActivityServiceClient(channel, interceptors: [AuthInterceptor()]);
  return ActivityServiceRepository(client);
});

class ActivityServiceRepository implements ActivityRepository {
  final proto.FriendsActivityServiceClient _client;
  ActivityServiceRepository(this._client);

  @override
  Future<List<ActivityModel>> getFriendsFeed({int limit = 0, int offset = 0}) {
    final request = proto.GetFriendsFeedRequest(limit: limit, offset: offset);
    return _client.getFriendsFeed(request).then((response) {
      return response.activities.map((protoActivity) => ActivityModel.fromProto(protoActivity)).toList();
    });
  }
}