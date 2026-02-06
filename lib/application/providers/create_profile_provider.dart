import 'package:bluppi/domain/models/create_user_model.dart';
import 'package:riverpod/riverpod.dart';

final createProfileStepProvider =
    NotifierProvider<CreateProfileStepNotifier, int>(
  CreateProfileStepNotifier.new,
);

class CreateProfileStepNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void next() {
    state++;
  }

  void back() {
    if (state > 0) {
      state--;
    }
  }
}

final createProfileDataProvider =
    NotifierProvider<CreateProfileDataNotifier, CreateUserModel>(
  CreateProfileDataNotifier.new,
);

class CreateProfileDataNotifier extends Notifier<CreateUserModel> {
  @override
  CreateUserModel build() => const CreateUserModel();

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateUsername(String value) {
    state = state.copyWith(username: value);
  }

  void updateBio(String value) {
    state = state.copyWith(bio: value);
  }

  void updateDateOfBirth(DateTime value) {
    state = state.copyWith(dateOfBirth: value);
  }

  void updateGender(String value) {
    state = state.copyWith(gender: value);
  }

  void toggleGenre(String genre) {
    final updatedGenres = List<String>.from(state.selectedGenres);

    if (updatedGenres.contains(genre)) {
      updatedGenres.remove(genre);
    } else {
      updatedGenres.add(genre);
    }

    state = state.copyWith(selectedGenres: updatedGenres);
  }

  void updateProfilePic(String path) {
    state = state.copyWith(profilePicPath: path);
  }
}