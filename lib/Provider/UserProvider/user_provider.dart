import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Data/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bluppi/config.dart';
import 'auth_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = AppConfig.apiURL;
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  dio.options.validateStatus = (status) => status! < 500;
  return dio;
});

final userProvider =
    StateNotifierProvider<UserStateNotifier, AsyncValue<UserModel?>>((ref) {
  return UserStateNotifier(ref);
});

class UserStateNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final Ref _ref;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Dio _dio;

  UserStateNotifier(this._ref) : super(const AsyncValue.loading()) {
    _dio = _ref.read(dioProvider);
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

    try {
      final userData = await _getCachedUserData(authUser.uid);
      if (userData != null) {
        state = AsyncValue.data(userData);
        log("Loaded user data from cache for user: ${authUser.uid}");
        _refreshUserData(authUser.uid);
        return;
      }

      log("Attempting to fetch user data for user: ${authUser.uid}");
      await _refreshUserData(authUser.uid);
    } catch (e, stackTrace) {
      log('Error during user data retrieval for user ${authUser.uid}: $e\n$stackTrace');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<UserModel?> _getCachedUserData(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedUserData = prefs.getString('user_data_$userId');
      if (cachedUserData != null) {
        return UserModel.fromJson(cachedUserData);
      }
      return null;
    } catch (e) {
      log("Error loading user data from cache: $e");
      return null;
    }
  }

  Future<void> _cacheUserData(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data_${user.id}', user.toJson());
      log("User data cached for user: ${user.id}");
    } catch (e) {
      log("Error caching user data: $e");
    }
  }

  Future<void> refresh() async {
    final authUser = _auth.currentUser;
    if (authUser == null) {
      log("Attempted to refresh user data, but user is not authenticated.");
      throw Exception("Cannot refresh user data: User not authenticated.");
    }

    log("Manually refreshing user data for user: ${authUser.uid}");
    if (!mounted) {
      log("Skipping refresh - notifier already disposed");
      return;
    }

    state = const AsyncValue.loading();

    try {
      await _refreshUserData(authUser.uid);
      log("User data manually refreshed for: ${authUser.uid}");
    } catch (e, stackTrace) {
      log("Error during manual user refresh: $e");
      if (mounted) {
        state = AsyncValue.error(e, stackTrace);
      }
      rethrow;
    }
  }

  Future<void> _refreshUserData(String userId) async {
    try {
      final response = await _dio.get('user/$userId');
      if (!mounted) {
        log("Skipping user data refresh - notifier already disposed");
        return;
      }

      log("Response: $response");

      if (response.statusCode == 200) {
        final userModel = UserModel.fromMap(response.data['user']);
        state = AsyncValue.data(userModel);
        await _cacheUserData(userModel);
        log("User data refreshed from API for user: $userId");
      } else {
        log('API Error: User not found for ID: $userId');
        if (mounted) {
          state = AsyncValue.error(
            UserProfileNotFoundException(userId),
            StackTrace.current,
          );
        }
      }
    } on DioException catch (e, stackTrace) {
      log('Network Error fetching user data: ${e.message}');
      if (mounted) {
        state = AsyncValue.error(e, stackTrace);
      }
    } catch (e, stackTrace) {
      log('Error during user data refresh for user $userId: $e');
      if (mounted) {
        state = AsyncValue.error(e, stackTrace);
      }
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

    try {
      log("Attempting to update user data for user: ${authUser.uid} with data: $newData");

      final response = await _dio.patch(
        '/user/${authUser.uid}',
        data: newData,
      );

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromMap(response.data);
        state = AsyncValue.data(updatedUser);

        await _cacheUserData(updatedUser);
        log("User data updated successfully for user: ${authUser.uid}");
      } else {
        log("Failed to update user data. Status: ${response.statusCode}, Message: ${response.data}");
        throw Exception("Failed to update user data: ${response.data}");
      }
    } on DioException catch (e, stackTrace) {
      log('Network Error updating user data: ${e.message}\n$stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Error during user data update: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> incrementFollowing(String followeeId) async {
    final authUser = _auth.currentUser;
    if (authUser == null) return;

    try {
      final response = await _dio.post(
        '/user/${authUser.uid}/follow/$followeeId',
      );

      if (response.statusCode != 201) {
        log("Failed to increment following count. Status: ${response.statusCode}, Message: ${response.data}");
        throw Exception(
            "Failed to increment following count: ${response.data}");
      }

      log("Incremented following count via API");
    } on DioException catch (e, stackTrace) {
      log('Network Error incrementing following count: ${e.message}\n$stackTrace');

      rethrow;
    } catch (e, stackTrace) {
      log('Error incrementing following count: $e\n$stackTrace');

      rethrow;
    }
  }

  Future<void> decrementFollowing(String followeeId) async {
    final authUser = _auth.currentUser;
    if (authUser == null) return;

    try {
      log("Decremented local following count");

      final response = await _dio.delete(
        '/user/${authUser.uid}/unfollow/$followeeId',
      );

      if (response.statusCode != 200) {
        log("Failed to decrement following count. Status: ${response.statusCode}, Message: ${response.data}");
        throw Exception(
            "Failed to decrement following count: ${response.data}");
      }

      log("Decremented following count via API");
    } on DioException catch (e, stackTrace) {
      log('Network Error decrementing following count: ${e.message}\n$stackTrace');

      rethrow;
    } catch (e, stackTrace) {
      log('Error decrementing following count: $e\n$stackTrace');

      rethrow;
    }
  }

  Future<bool> isFollowing(String followeeId) async {
    final authUser = _auth.currentUser;
    if (authUser == null) return false;

    try {
      final response = await _dio.get(
        '/user/${authUser.uid}/is-following/$followeeId',
      );

      if (response.statusCode == 200) {
        return response.data['is_following'] as bool;
      } else {
        log("Failed to check following status. Status: ${response.statusCode}, Message: ${response.data}");
        throw Exception("Failed to check following status: ${response.data}");
      }
    } on DioException catch (e, stackTrace) {
      log('Network Error checking following status: ${e.message}\n$stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      log('Error checking following status: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      try {
        final response = await _dio.patch(
          '/user/$userId',
          data: user.toMap(),
        );

        if (response.statusCode == 200) {
          log("User data updated successfully");

          state = AsyncValue.data(user);
          await _cacheUserData(user);
        } else {
          log("Failed to update user data. Status: ${response.statusCode}, Message: ${response.data}");
          throw Exception("Failed to update user data: ${response.data}");
        }
      } catch (e) {
        log("Error updating user data: $e");
        rethrow;
      }
    } else {
      log("User not authenticated");
      throw Exception("User not authenticated");
    }
  }
}

class UserProfileNotFoundException implements Exception {
  final String userId;
  final String message;

  UserProfileNotFoundException(this.userId,
      [this.message = "User profile not found in the database."]);

  @override
  String toString() =>
      'UserProfileNotFoundException: $message (UserID: $userId)';
}
