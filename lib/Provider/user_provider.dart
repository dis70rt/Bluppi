import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_provider.dart';

final userProvider =
    StateNotifierProvider<UserStateNotifier, AsyncValue<UserModel?>>((ref) {
  return UserStateNotifier(ref);
});

class UserStateNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final Ref _ref;
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _auth;

  UserStateNotifier(this._ref) : super(const AsyncValue.loading()) {
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _initialize();
  }

  Future<void> _initialize() async {
    final authState = _ref.watch(authProvider);

    final User? authUser = authState.value?.user;

    if (authUser == null) {
      state = const AsyncValue.data(null);
      log("User is not authenticated. Setting userState to null.");
      return;
    }

    final userDocRef = _firestore.collection('users').doc(authUser.uid);

    try {
      log("Attempting to fetch Firestore document for user: ${authUser.uid}");
      final docSnapshot = await userDocRef.get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        if (userData != null) {
          final userModel = UserModel.fromFirestore(userData, authUser.uid);
          state = AsyncValue.data(userModel);
          log("Firestore document found and parsed for user: ${authUser.uid}");
        } else {
          log('Error: Firestore document exists for user ${authUser.uid} but data is null.');

          state = AsyncValue.error(
            Exception(
                'Firestore document exists but data is null for user ${authUser.uid}'),
            StackTrace.current,
          );
        }
      } else {
        log('Firestore document NOT found for authenticated user: ${authUser.uid}. Setting userState to null.');

        state = const AsyncValue.data(null);
      }
    } on FirebaseException catch (e, stackTrace) {
      log('Firebase Error fetching user data from Firestore: $e\n$stackTrace');
      state = AsyncValue.error(e, stackTrace);
    } catch (e, stackTrace) {
      log('Error during user data retrieval/parsing for user ${authUser.uid}: $e\n$stackTrace');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> update(Map<String, dynamic> newData) async {
    final currentUserModel = state.value;
    if (currentUserModel == null) {
      log("Attempted to update profile, but no user model is currently loaded.");

      throw Exception("Cannot update profile: No user data loaded.");
    }

    final authUser = _auth.currentUser;
    if (authUser == null) {
      log("Attempted to update profile, but user is no longer authenticated.");

      throw Exception("Cannot update profile: User not authenticated.");
    }

    final userDocRef = _firestore.collection('users').doc(authUser.uid);

    try {
      log("Attempting to update Firestore document for user: ${authUser.uid} with data: $newData");

      await userDocRef.update(newData);
      log("Firestore update successful for user: ${authUser.uid}");

      final updatedUserModel = currentUserModel.copyWith(
        username: newData['username'] as String? ?? currentUserModel.username,
        name: newData['name'] as String? ?? currentUserModel.name,
        email: newData['email'] as String? ?? currentUserModel.email,
        phone: newData['phone'] as int? ?? currentUserModel.phone,
        country: newData['country'] as String? ?? currentUserModel.country,
        profilePic:
            newData['profilePic'] as String? ?? currentUserModel.profilePic,
      );

      UserModel tempModel = currentUserModel;
      if (newData.containsKey('username')) {
        tempModel = tempModel.copyWith(username: newData['username']);
      }
      if (newData.containsKey('name')) {
        tempModel = tempModel.copyWith(name: newData['name']);
      }
      if (newData.containsKey('email')) {
        tempModel = tempModel.copyWith(email: newData['email']);
      }
      if (newData.containsKey('phone')) {
        tempModel = tempModel.copyWith(phone: newData['phone']);
      }
      if (newData.containsKey('country')) {
        tempModel = tempModel.copyWith(country: newData['country']);
      }
      if (newData.containsKey('profilePic')) {
        tempModel = tempModel.copyWith(profilePic: newData['profilePic']);
      }

      if (newData.containsKey('favoriteGenres')) {
        final dynamic genresData = newData['favoriteGenres'];
        if (genresData is List?) {
          tempModel = tempModel.copyWith(
              favoriteGenres: genresData
                  ?.map((e) => e?.toString() ?? '')
                  .where((s) => s.isNotEmpty)
                  .toList());
        }
      }
      if (newData.containsKey('bio')) {
        tempModel = tempModel.copyWith(bio: newData['bio']);
      }

      state = AsyncValue.data(tempModel);
      log("Local userState updated successfully.");
    } on FirebaseException catch (e, stackTrace) {
      log('Firebase Error updating user data in Firestore: $e\n$stackTrace');

      rethrow;
    } catch (e, stackTrace) {
      log('Error during user data update/parsing: $e\n$stackTrace');

      rethrow;
    }
  }

  Future<void> incrementFollowing() async {
    final currentUserModel = state.value;
    if (currentUserModel == null) return;

    final authUser = _auth.currentUser;
    if (authUser == null) return;

    final userDocRef = _firestore.collection('users').doc(authUser.uid);

    try {
      final updatedModel =
          currentUserModel.copyWith(following: currentUserModel.following + 1);
      state = AsyncValue.data(updatedModel);
      log("Incremented local following count");

      await userDocRef.update({'following': FieldValue.increment(1)});
      log("Incremented following count in Firestore");
    } on FirebaseException catch (e, stackTrace) {
      log('Firebase Error incrementing following count: $e\n$stackTrace');

      state = AsyncValue.data(currentUserModel);
      rethrow;
    } catch (e, stackTrace) {
      log('Error incrementing following count: $e\n$stackTrace');
      state = AsyncValue.data(currentUserModel);
      rethrow;
    }
  }

  Future<void> decrementFollowing() async {
    final currentUserModel = state.value;
    if (currentUserModel == null) return;

    final authUser = _auth.currentUser;
    if (authUser == null) return;

    final userDocRef = _firestore.collection('users').doc(authUser.uid);

    try {
      final updatedModel =
          currentUserModel.copyWith(following: currentUserModel.following - 1);
      state = AsyncValue.data(updatedModel);
      log("Decremented local following count");

      await userDocRef.update({'following': FieldValue.increment(-1)});
      log("Decremented following count in Firestore");
    } on FirebaseException catch (e, stackTrace) {
      log('Firebase Error decrementing following count: $e\n$stackTrace');

      state = AsyncValue.data(currentUserModel);
      rethrow;
    } catch (e, stackTrace) {
      log('Error decrementing following count: $e\n$stackTrace');
      state = AsyncValue.data(currentUserModel);
      rethrow;
    }
  }
}

class UserProfileNotFoundException implements Exception {
  final String userId;
  final String message;

  UserProfileNotFoundException(this.userId,
      [this.message = "User profile document not found in Firestore."]);

  @override
  String toString() =>
      'UserProfileNotFoundException: $message (UserID: $userId)';
}

const String usersCollection = 'users';
