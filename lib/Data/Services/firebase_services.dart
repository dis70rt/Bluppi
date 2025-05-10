import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final auth = FirebaseAuth.instance;

  void writeLastPlayedTrack(int trackId) async {
    try {
      final user = auth.currentUser;
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('userTracks')
          .doc('lastPlayedTrack');

      await docRef.set({
        'trackId': trackId,
        'lastPlayed': FieldValue.serverTimestamp(),
      });

      log("Successfully wrote last played track.");
    } catch (e) {
      log("Error writing last played track: $e");
    }
  }

  Future<Map<String, dynamic>?> getLastPlayedTrack() async {
    try {
      final user = auth.currentUser;
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('userTracks')
          .doc('lastPlayedTrack');

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return data!;
      } else {
        log("No last played track found.");
        return null;
      }
    } catch (e) {
      log("Error fetching last played track: $e");
      return null;
    }
  }
}
