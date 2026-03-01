import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/room_model.dart';
import 'package:bluppi/domain/repositories/room_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/generated/rooms.pbgrpc.dart' as proto;

final roomServiceProvider = Provider<RoomServiceRepository>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = proto.RoomServiceClient(channel);
  return RoomServiceRepository(client);
});

class RoomServiceRepository implements RoomRepository {
  final proto.RoomServiceClient _client;

  RoomServiceRepository(this._client);

  @override
  Future<RoomModel> createRoom(String name, bool isPublic, bool inviteOnly, String hostUserId) async {
    final protoVisibility = isPublic
        ? proto.RoomVisibility.ROOM_VISIBILITY_PUBLIC
        : proto.RoomVisibility.ROOM_VISIBILITY_PRIVATE;
    
    final request = proto.CreateRoomRequest(name: name, visibility: protoVisibility, inviteOnly: inviteOnly, hostUserId: hostUserId);
    final response = await _client.createRoom(request);
    return RoomModel.fromProto(response);
  }

  @override
  Future<void> leaveRoom(String roomId, String userId) async {
    final request = proto.LeaveRoomRequest(roomId: roomId, userId: userId);
    await _client.leaveRoom(request);
  }
}