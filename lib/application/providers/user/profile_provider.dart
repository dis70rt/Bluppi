import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  final UserModel? user;
  final bool isOwnProfile;

  ProfileState({required this.user, required this.isOwnProfile});
}

class ProfileNotifier extends AsyncNotifier<ProfileState> {
  final String? username;
  ProfileNotifier(this.username);

  @override
  Future<ProfileState> build() async {
    final userAsync = ref.watch(userProvider);
    final currentUser = userAsync.value;

    if (username == null || username == currentUser?.username) {
      return ProfileState(user: currentUser, isOwnProfile: true);
    }

    final repo = ref.read(userServiceClientRepositoryProvider);
    final user = await repo.getUserByUsername(username!);
    return ProfileState(user: user, isOwnProfile: false);
  }

  Future<void> refreshProfile() async {
    if (username == null ||
        username == ref.read(userProvider).value?.username) {
      // ignore: unused_result
      await ref.refresh(userProvider.future);
    } else {
      ref.invalidateSelf();
      await future;
    }
  }
}

final profileProvider = AsyncNotifierProvider.autoDispose
    .family<ProfileNotifier, ProfileState, String?>(ProfileNotifier.new);
