import 'package:bluppi/domain/models/room_model.dart';

abstract class RoomRepository {
  Future<RoomModel> createRoom(String name, bool isPublic, bool inviteOnly, String hostUserId);
  Future<void> leaveRoom(String roomId, String userId);
}