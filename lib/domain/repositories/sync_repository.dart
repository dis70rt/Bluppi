import 'package:bluppi/domain/models/sync_model.dart';

abstract class SyncRepository {
  Future<ServerResponse> sync(int clientSendNs, String roomId);
}