
import 'dart:async';

import 'package:bluppi/data/auth/auth_interceptor.dart';
import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/online_presence_model.dart';
import 'package:bluppi/domain/repositories/online_presence_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/generated/presences.pbgrpc.dart' as proto;

final onlinePresenceServiceProvider = Provider<OnlinePresenceServiceRepository>(
  (ref) {
    final channel = ref.watch(gatewayGrpcChannelProvider);
    return OnlinePresenceServiceRepository(
      proto.PresenceGatewayClient(channel, interceptors: [AuthInterceptor()])
    );
  });


class OnlinePresenceServiceRepository implements OnlinePresenceRepository {
  final proto.PresenceGatewayClient _client;

  OnlinePresenceServiceRepository(this._client);
  
  @override
  Stream<PresenceEvent> subscribePresence(List<String> targetUserIds) {
    final request = proto.SubscribeRequest(targetUserIds: targetUserIds);
    final response = _client.subscribePresence(request);
    return response.map((protoUpdate) => PresenceEvent.fromProto(protoUpdate));
  }
}