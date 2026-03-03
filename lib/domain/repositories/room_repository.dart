import 'package:bluppi/domain/models/room_events_model.dart';
import 'package:bluppi/domain/models/room_model.dart';
import 'package:bluppi/domain/models/room_summary_model.dart';

abstract class RoomRepository {
  Future<RoomModel> createRoom(String name, bool isPublic, bool inviteOnly, String hostUserId);
  Future<void> leaveRoom(String roomId, String userId);
  Future<void> joinRoomByID(String roomId, String userId);
  Future<void> joinRoomByCode(String roomCode, String userId);
  Future<(List<RoomSummaryModel>, String)> listRooms(bool visibility, int size, String token);
  Future<RoomModel> getRoom(String roomId);
  Stream<RoomEventModel> subscribeToRoomEvents(String roomId, String userId);
}