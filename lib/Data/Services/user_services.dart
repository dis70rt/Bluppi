import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synqit/Data/Models/follower_model.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/config.dart';

class UserServices {
  final auth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final Dio dio = Dio();

  UserServices() {
    dio.options.baseUrl = AppConfig.apiURL;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.validateStatus = (status) => status! < 500;
  }

  Future<Map<String, dynamic>?> getLastPlayedSong({required String uid}) async {
    try {
      final response = await dio.get('/user/$uid/history',
          queryParameters: {'limit': 1, 'offset': 0});

      if (response.statusCode == 200 && response.data['history'].isNotEmpty) {
        final history = response.data['history'][0];
        final trackId = history['track_id'];

        final trackResponse = await dio.get('/track/$trackId');
        if (trackResponse.statusCode == 200) {
          final track = Track.fromJson(trackResponse.data['track']);
          return {
            "track": track,
            "lastPlayed": history['played_at'],
          };
        }
      }
      log("No last played track found for user: $uid");
      return null;
    } catch (e) {
      log("Error fetching last played song: $e");
      return null;
    }
  }

  Future<void> recentlySearched(String query) async {
    if (query.trim().isEmpty) {
      log("Skipping empty search query");
      return;
    }

    log("Saving recently searched query to local storage: $query");
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedSearches = prefs.getStringList('recent_searches') ?? [];

      cachedSearches.remove(query);
      cachedSearches.insert(0, query);

      if (cachedSearches.length > 10) {
        cachedSearches.removeRange(10, cachedSearches.length);
      }

      await prefs.setStringList('recent_searches', cachedSearches);
      log("Successfully saved search query to local storage.");
    } catch (e) {
      log("Error saving recently searched query: $e");
    }
  }

  Future<List<String>> getRecentlySearched() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedSearches = prefs.getStringList('recent_searches') ?? [];
      return cachedSearches;
    } catch (e) {
      log("Error retrieving recently searched queries: $e");
      return [];
    }
  }

  Future<void> deleteRecentlySearched(String query) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedSearches = prefs.getStringList('recent_searches') ?? [];

      cachedSearches.remove(query);
      await prefs.setStringList('recent_searches', cachedSearches);

      log("Successfully deleted recently searched query from local storage: $query");
    } catch (e) {
      log("Error deleting recently searched query: $e");
    }
  }

  Future<void> historyTrack(int trackId) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        log("Cannot add track to history: User not authenticated");
        return;
      }

      final response = await dio
          .post('/user/${user.uid}/history', data: {'track_id': trackId});

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully wrote history track.");
      } else {
        log("Failed to add track to history. Status: ${response.statusCode}, Message: ${response.data}");
      }
    } catch (e) {
      log("Error writing history track: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getHistoryTracks() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        log("Cannot get history tracks: User not authenticated");
        return [];
      }

      final response = await dio.get('/user/${user.uid}/history',
          queryParameters: {'limit': 10, 'offset': 0});

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> tracks =
            List<Map<String, dynamic>>.from(
                (response.data['history'] as List).map((track) => {
                      'trackId': track['track_id'],
                      'playedAt': DateTime.parse(track['played_at']),
                    }));
        return tracks;
      }
      return [];
    } catch (e) {
      log("Error fetching history tracks: $e");
      return [];
    }
  }

  Future<bool> deleteAllHistoryTracks() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        log("Cannot delete history: User not authenticated");
        return false;
      }

      final response = await dio.delete('/user/${user.uid}/history');

      if (response.statusCode == 200) {
        log("Successfully deleted all history tracks");
        return true;
      }

      log("Note: Backend implementation needed for deleteAllHistoryTracks()");
      return false;
    } catch (e) {
      log("Error deleting all history tracks: $e");
      return false;
    }
  }

  Future<String?> uploadFile(File file, String storagePath,
      {bool isProfilePic = false}) async {
    log("Attempting to upload file to storagePath: $storagePath");
    final user = auth.currentUser;
    if (user == null) {
      log("Upload failed: User not authenticated.");
      throw Exception("User not authenticated.");
    }

    if (storagePath.isEmpty ||
        storagePath.startsWith('/') ||
        storagePath.endsWith('/')) {
      log("Upload failed: Invalid storagePath provided: '$storagePath'");
      throw ArgumentError(
          "Invalid storagePath: Must not be empty or start/end with '/'. Example: 'profile_pictures'.");
    }

    try {
      final parts = file.path.split('.');
      final extension = parts.isNotEmpty && parts.length > 1 ? parts.last : '';

      String fileName = '';
      if (isProfilePic) {
        fileName = '${user.uid}${extension.isNotEmpty ? ".$extension" : ""}';
      } else {
        fileName = '$fileName${extension.isNotEmpty ? ".$extension" : ""}';
      }

      final storageRef = firebaseStorage
          .ref()
          .child('users')
          .child(user.uid)
          .child(storagePath)
          .child(fileName);

      log("Starting upload to: gs://${storageRef.bucket}/${storageRef.fullPath}");
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {
        log("Upload task completed for path: ${storageRef.fullPath}");
      });

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      log("Error uploading file: $e");
      return null;
    }
  }

  Future<UserModel?> getUserByID(String uid) async {
    try {
      final response = await dio.get('/user/$uid');

      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      } else {
        log("No user found with UID: $uid");
        return null;
      }
    } catch (e) {
      log("Error fetching user: $e");
      return null;
    }
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final response = await dio.get('/user/username/$username');

      if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      log("Error fetching user by username: $e");
      rethrow;
    }
  }

  Future<bool> isUsernameUnique(String username) async {
    try {
      final response = await dio.get(
        '/user/check/username/${username.trim()}',
      );

      if (response.statusCode == 200) {
        final exists = response.data['exists'] as bool;
        return !exists;
      } else {
        log("Error checking username: Status code ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("Error checking username uniqueness: $e");
      return false;
    }
  }

  Future<FollowerModel> getFollowers({
    required String userId,
    int limit = 15,
    int offset = 0,
  }) async {
    try {
      final response = await dio.get(
        '/user/$userId/followers',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      return FollowerModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Failed to load followers: $e');
    }
  }

  Future<FollowingModel> getFollowing({
    required String userId,
    int limit = 15,
    int offset = 0,
  }) async {
    try {
      final response = await dio.get(
        '/user/$userId/following',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      return FollowingModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Failed to load following: $e');
    }
  }
}
