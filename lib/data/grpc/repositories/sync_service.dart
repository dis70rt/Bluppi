import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/sync_model.dart';
import 'package:bluppi/domain/repositories/sync_repository.dart';
import 'package:bluppi/generated/party.pbgrpc.dart' as proto;
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncServiceProvider = Provider<SyncServiceRepository>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = proto.SyncServiceClient(channel);
  return SyncServiceRepository(client);
});

class SyncServiceRepository implements SyncRepository {
  final proto.SyncServiceClient _client;

  SyncServiceRepository(this._client);

  @override
  Future<ServerResponse> sync(int clientSendNs, String roomId, String userId) async {
    final request = proto.SyncRequest(clientSendUs: Int64(clientSendNs), roomId: roomId, userId: userId);
    final response = await _client.clockSync(request);
    return ServerResponse.fromProto(response);
  }
}