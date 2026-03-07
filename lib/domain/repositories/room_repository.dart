import 'package:bluppi/domain/models/room_events_model.dart';
import 'package:bluppi/domain/models/room_model.dart';
import 'package:bluppi/domain/models/room_summary_model.dart';

abstract class RoomRepository {
  Future<RoomModel> createRoom(String name, bool isPublic, bool inviteOnly);
  Future<void> leaveRoom(String roomId);
  Future<void> joinRoomByID(String roomId);
  Future<void> joinRoomByCode(String roomCode);
  Future<(List<RoomSummaryModel>, String)> listRooms(bool visibility, int size, String token);
  Future<RoomModel> getRoom(String roomId);
  Stream<RoomEventModel> subscribeToRoomEvents(String roomId);
  Future<void> sendLiveChatMessage(String roomId, String message);
  Future<List<JoinedMemberModel>> getRoomMembers(String roomId);
  Future<void> inviteUser(String roomId, String userId);
}