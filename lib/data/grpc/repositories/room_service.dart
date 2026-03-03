import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/room_events_model.dart';
import 'package:bluppi/domain/models/room_model.dart';
import 'package:bluppi/domain/models/room_summary_model.dart';
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

  @override
  Future<void> joinRoomByID(String roomId, String userId) async {
    final request = proto.JoinRoomRequest(roomId: roomId, userId: userId);
    await _client.joinRoom(request);
  }

  @override
  Future<void> joinRoomByCode(String roomCode, String userId) async {}

  @override
  Future<(List<RoomSummaryModel>, String)> listRooms(bool visibility, int pageSize, String pageToken) async {
    final protoVisibility = visibility
        ? proto.RoomVisibility.ROOM_VISIBILITY_PUBLIC
        : proto.RoomVisibility.ROOM_VISIBILITY_PRIVATE;
    
    final request = proto.ListRoomsRequest(visibility: protoVisibility, pageSize: pageSize, pageToken: pageToken);
    final response = await _client.listRooms(request);

    final rooms = response.rooms.map((p) => RoomSummaryModel.fromProto(p)).toList();

    return (rooms, response.nextPageToken);
  }

  @override
  Future<RoomModel> getRoom(String roomId) {
    final request = proto.GetRoomRequest(roomId: roomId);
    return _client.getRoom(request).then((response) => RoomModel.fromProto(response));
  }

  @override
  Stream<RoomEventModel> subscribeToRoomEvents(String roomId, String userId) {
    final request = proto.SubscribeRequest(roomId: roomId, userId: userId);
    return _client.subscribeToRoomEvents(request).map(RoomEventModel.fromProto);
  }
}