import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum EditProfileStatus { idle, saving, success, error }

class EditProfileState {
  final String name;
  final String bio;
  final String gender;
  final EditProfileStatus status;
  final String? errorMessage;

  const EditProfileState({
    this.name = '',
    this.bio = '',
    this.gender = '',
    this.status = EditProfileStatus.idle,
    this.errorMessage,
  });

  EditProfileState copyWith({
    String? name,
    String? bio,
    String? gender,
    EditProfileStatus? status,
    String? errorMessage,
  }) {
    return EditProfileState(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

class EditProfileNotifier extends Notifier<EditProfileState> {
  @override
  EditProfileState build() {
    return const EditProfileState();
  }

  void init(UserModel user) {
    state = EditProfileState(
      name: user.name,
      bio: user.bio,
      gender: user.gender,
    );
  }

  void updateName(String value) => state = state.copyWith(name: value);
  void updateBio(String value) => state = state.copyWith(bio: value);
  void updateGender(String value) => state = state.copyWith(gender: value);

  Future<bool> save() async {
    state = state.copyWith(status: EditProfileStatus.saving);

    try {
      final repo = ref.read(userServiceClientRepositoryProvider);
      await repo.updateUser(
        name: state.name,
        bio: state.bio,
        gender: state.gender,
      );

      // Refresh the global user provider
      await ref.read(userProvider.notifier).refreshUser();

      state = state.copyWith(status: EditProfileStatus.success);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: EditProfileStatus.error,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}

final editProfileProvider =
    NotifierProvider<EditProfileNotifier, EditProfileState>(
      EditProfileNotifier.new,
    );
