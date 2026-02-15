import 'package:bluppi/application/providers/auth/auth_provider.dart';
import 'package:bluppi/application/providers/user/create_profile_provider.dart';
import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLifecycleListenerProvider = Provider<void>((ref) {
  ref.listen(authStateProvider, (prev, next) {
    final prevStatus = prev?.value;
    final nextStatus = next.value;

    if (prevStatus == null || prevStatus == AuthStatus.unknown) {
      return;
    }

    if (prevStatus != nextStatus) {
      ref.invalidate(userExistsProvider);
      ref.invalidate(createProfileDataProvider);
      ref.invalidate(createProfileStepProvider);
    }
  });
});
