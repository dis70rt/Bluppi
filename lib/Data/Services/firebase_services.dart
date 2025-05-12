import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/database_services.dart';

class FirebaseServices {
  final auth = FirebaseAuth.instance;
  final database = Database();

  Future<Map<String, dynamic>?> getLastPlayedSong() async {
    final doc = await getLastPlayedTrack();
    final trackId = doc?['trackId'];
    if (trackId != null) {
      final data = await database.getTrack(trackId.toString());
      if (data.isNotEmpty) {
        final track = Track.fromJson(data['track']);
        return {
          "track": track,
          "lastPlayed": doc!['lastPlayed'],
        };
      } else {
        log("No track found with ID: $trackId");
        return null;
      }
    } else {
      log("No last played track found.");
      return null;
    }
  }

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

  Future<void> recentlySearched(String query) async {
    log("Writing recently searched query: $query");
    try {
      final user = auth.currentUser;
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('recentSearches')
          .doc(query);

      await docRef.set({
        'query': query,
        'searchedAt': FieldValue.serverTimestamp(),
      });

      log("Successfully wrote recently searched query.");
    } catch (e) {
      log("Error writing recently searched query: $e");
    }
  }

  Future<List<String>> getRecentlySearched() async {
    try {
      final user = auth.currentUser;
      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('recentSearches');

      final querySnapshot = await collectionRef
          .orderBy('searchedAt', descending: true)
          .limit(10)
          .get();

      final List<String> queries = [];
      for (var doc in querySnapshot.docs) {
        queries.add(doc['query']);
      }

      return queries;
    } catch (e) {
      log("Error fetching recently searched queries: $e");
      return [];
    }
  }

  Future<void> deleteRecentlySearched(String query) async {
    try {
      final user = auth.currentUser;
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('recentSearches')
          .doc(query);

      await docRef.delete();
      log("Successfully deleted recently searched query: $query");
    } catch (e) {
      log("Error deleting recently searched query: $e");
    }
  }

  Future<void> historyTrack(int trackId) async {
    try {
      final user = auth.currentUser;
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('historyTracks')
          .doc(trackId.toString());

      await docRef.set({
        'trackId': trackId,
        'playedAt': FieldValue.serverTimestamp(),
      });

      log("Successfully wrote history track.");
    } catch (e) {
      log("Error writing history track: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getHistoryTracks() async {
    try {
      final user = auth.currentUser;
      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('historyTracks');

      final querySnapshot = await collectionRef
          .orderBy('playedAt', descending: true)
          .limit(10)
          .get();

      final List<Map<String, dynamic>> tracks = [];
      for (var doc in querySnapshot.docs) {
        tracks.add(doc.data());
      }

      return tracks;
    } catch (e) {
      log("Error fetching history tracks: $e");
      return [];
    }
  }
  Future<void> deleteAllHistoryTracks() async {
    try {
      final user = auth.currentUser;
      final collectionRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('historyTracks');

      final querySnapshot = await collectionRef.get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      log("Successfully deleted all history tracks.");
    } catch (e) {
      log("Error deleting all history tracks: $e");
    }
  }
}
