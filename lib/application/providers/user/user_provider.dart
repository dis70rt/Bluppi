import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    final repo = ref.read(userServiceClientRepositoryProvider);
    return await repo.getCurrentUser();
  }

  Future<void> refreshUser() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repo = ref.read(userServiceClientRepositoryProvider);
      return await repo.getCurrentUser();
    });
  }

  void clear() {
    state = const AsyncData(null);
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, UserModel?>(
  UserNotifier.new,
);
