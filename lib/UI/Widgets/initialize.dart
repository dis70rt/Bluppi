import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synqit/Provider/UserProvider/auth_provider.dart';
import 'package:synqit/Provider/UserProvider/user_provider.dart';

enum InitializationStatus { initializing, initialized, error }

class AppInitializationState {
  final InitializationStatus status;
  final String error;
  final bool isUserProfileLoaded;
  final bool isSocketConnected;

  AppInitializationState({
    this.status = InitializationStatus.initializing,
    this.error = '',
    this.isUserProfileLoaded = false,
    this.isSocketConnected = false,
  });

  bool get isFullyInitialized =>
      status == InitializationStatus.initialized &&
      isUserProfileLoaded &&
      isSocketConnected;

  AppInitializationState copyWith({
    InitializationStatus? status,
    String? error,
    bool? isUserProfileLoaded,
    bool? isSocketConnected,
  }) {
    return AppInitializationState(
      status: status ?? this.status,
      error: error ?? this.error,
      isUserProfileLoaded: isUserProfileLoaded ?? this.isUserProfileLoaded,
      isSocketConnected: isSocketConnected ?? this.isSocketConnected,
    );
  }
}

final appInitializationProvider =
    StateNotifierProvider<AppInitializationNotifier, AppInitializationState>(
        (ref) {
  return AppInitializationNotifier(ref);
});

class AppInitializationNotifier extends StateNotifier<AppInitializationState> {
  final Ref ref;
  // bool _isInitializingSocket = false;

  AppInitializationNotifier(this.ref) : super(AppInitializationState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      ref.listen(authProvider, (previous, next) {
        next.whenData((authResult) {
          if (authResult.user != null) {
            _initializeUserData(authResult.user!.uid);
          } else {
            _resetState();
          }
        });
      });

      ref.listen(userProvider, (previous, next) {
        next.whenData((userModel) {
          if (userModel != null) {
            state = state.copyWith(isUserProfileLoaded: true);
            // _initializeSocket(userModel.id);
          }
        });
      });

      state = state.copyWith(status: InitializationStatus.initialized);
    } catch (e) {
      log('Initialization error: $e');
      state = state.copyWith(
          status: InitializationStatus.error, error: e.toString());
    }
  }

  Future<void> _initializeUserData(String userId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString('user_data_$userId');

      if (cached == null) {
        ref.read(userProvider.notifier).refresh();
      }
    } catch (e) {
      log('User data initialization error: $e');
    }
  }

  // Future<void> _initializeSocket(String userId) async {
  //   if (_isInitializingSocket || state.isSocketConnected) return;

  //   try {
  //     _isInitializingSocket = true;

  //     await Future.delayed(const Duration(milliseconds: 500));
  //     final socketNotifier = ref.read(socketProvider.notifier);
  //     final success = await socketNotifier.initialize(userId);

  //     if (!success) {
  //       throw Exception('Failed to initialize socket connection');
  //     }

  //     state = state.copyWith(isSocketConnected: true);
  //   } catch (e) {
  //     log('Socket initialization error: $e');
  //     state = state.copyWith(error: 'Failed to connect: $e');

  //     Future.delayed(const Duration(seconds: 3), () {
  //       if (!state.isSocketConnected) {
  //         _initializeSocket(userId);
  //       }
  //     });
  //   } finally {
  //     _isInitializingSocket = false;
  //   }
  // }

  void _resetState() {
    state = AppInitializationState();
  }
}
