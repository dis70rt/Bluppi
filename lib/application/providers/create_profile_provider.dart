import 'package:riverpod/riverpod.dart';

// -----------------------------------------------------------------------------
// STEP STATE
// -----------------------------------------------------------------------------

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

// -----------------------------------------------------------------------------
// PROFILE DATA STATE (IMMUTABLE)
// -----------------------------------------------------------------------------

final createProfileDataProvider =
    NotifierProvider<CreateProfileDataNotifier, CreateProfileData>(
  CreateProfileDataNotifier.new,
);

class CreateProfileDataNotifier extends Notifier<CreateProfileData> {
  @override
  CreateProfileData build() => const CreateProfileData();

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

// -----------------------------------------------------------------------------
// DATA MODEL
// -----------------------------------------------------------------------------

class CreateProfileData {
  final String name;
  final String username;
  final String bio;
  final DateTime? dateOfBirth;
  final String? gender;
  final List<String> selectedGenres;
  final String? profilePicPath;

  const CreateProfileData({
    this.name = '',
    this.username = '',
    this.bio = '',
    this.dateOfBirth,
    this.gender,
    this.selectedGenres = const [],
    this.profilePicPath,
  });

  /// Calculate age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  CreateProfileData copyWith({
    String? name,
    String? username,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    List<String>? selectedGenres,
    String? profilePicPath,
  }) {
    return CreateProfileData(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      profilePicPath: profilePicPath ?? this.profilePicPath,
    );
  }
}