import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/models/account_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountStatusProvider =
    FutureProvider.autoDispose.family<AccountStatus, String>((ref, uid) async {
  final repo = ref.read(userServiceClientRepositoryProvider);

  final exists = await repo.checkUserExists(uid);

  if (!exists) return AccountStatus.needsProfile;

  return AccountStatus.active;
});
