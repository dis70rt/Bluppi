import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_provider.dart';

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

final userProvider = FutureProvider<UserModel?>((ref) async {
  final authState = ref.watch(authProvider);

  final User? authUser = authState.value?.user;

  if (authUser == null) {
    return null;
  }

  final firestore = FirebaseFirestore.instance;
  final userDocRef = firestore.collection(usersCollection).doc(authUser.uid);

  try {
    log("Fetching Firestore document for user: ${authUser.uid}");
    final docSnapshot = await userDocRef.get();

    if (docSnapshot.exists) {
      final userData = docSnapshot.data();
      if (userData != null) {
        log("Firestore document found for user: ${authUser.uid}. Parsing data.");

        return UserModel.fromFirestore(userData, authUser.uid);
      } else {
        log('Error: Firestore document exists for user ${authUser.uid} but data is null.');

        throw Exception(
            'Firestore document exists for user ${authUser.uid} but data is null.');
      }
    } else {
      log('Error: Firestore document NOT found for authenticated user: ${authUser.uid}');
      throw UserProfileNotFoundException(authUser.uid);
    }
  } on FirebaseException catch (e, stackTrace) {
    log('Firebase Error fetching user data from Firestore: $e\n$stackTrace');

    rethrow;
  } catch (e, stackTrace) {
    log('Error during user data retrieval/parsing for user ${authUser.uid}: $e\n$stackTrace');

    rethrow;
  }
});
