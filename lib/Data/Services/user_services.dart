import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:synqit/Data/Models/user_model.dart';

class UserServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updateUser(UserModel user) async {
    final userId = auth.currentUser?.uid;
    if (userId != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      final userData = user.toFirestore();
      await userRef.update(userData);
      log("User data updated successfully");
    } else {
      log("User not authenticated");
    }
  }
}