import 'dart:async';
import 'dart:developer';
import 'package:bluppi/navigation/app_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/data/grpc/repositories/notification_service.dart';

class FCMState {
  final String? token;
  final bool isSyncing;
  final String? error;

  FCMState({this.token, this.isSyncing = false, this.error});

  FCMState copyWith({String? token, bool? isSyncing, String? error}) {
    return FCMState(
      token: token ?? this.token,
      isSyncing: isSyncing ?? this.isSyncing,
      error: error,
    );
  }
}

class FCMNotifier extends AsyncNotifier<FCMState> {
  FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  @override
  Future<FCMState> build() async {
    final subscription = _messaging.onTokenRefresh.listen(_handleTokenRefresh);
    
    // Listen to foreground messages
    final fgSub = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground message received: ${message.notification?.title}');
      // TODO: Handle showing an in-app banner or updating unread count
    });

    // Listen to notification taps when app is backgrounded
    final openSub = FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Notification tapped: ${message.data}');
      final router = ref.read(goRouterProvider);
      router.go('/u/${message.data['follower_name']}');
    });
    
    ref.onDispose(() {
      subscription.cancel();
      fgSub.cancel();
      openSub.cancel();
    });

    final token = await _messaging.getToken();
    return FCMState(token: token);
  }

  Future<void> requestAndSyncToken() async {
    final currentState = state.value ?? FCMState();
    state = AsyncValue.data(currentState.copyWith(isSyncing: true, error: null));

    try {
      await _messaging.requestPermission();
      final token = await _messaging.getToken();
      
      if (token != null) {
        await _syncTokenWithBackend(token);
        log('FCM token synced successfully: $token');
        state = AsyncValue.data(currentState.copyWith(token: token, isSyncing: false));
      } else {
        log('No FCM token received');
        state = AsyncValue.data(currentState.copyWith(isSyncing: false, error: 'No FCM token received'));
      }
    } catch (e) {
      log('FCM token sync error: $e');
      state = AsyncValue.data(currentState.copyWith(isSyncing: false, error: e.toString()));
    }
  }

  Future<void> unregisterAndDeleteToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      try {
        final notificationRepo = ref.read(notificationServiceProvider);
        await notificationRepo.unregisterDevice(token);
        await _messaging.deleteToken();
        state = AsyncValue.data(state.value!.copyWith(token: null));
      } catch (e) {
        state = AsyncValue.data(state.value!.copyWith(error: 'Failed to unregister FCM: $e'));
      }
    }
  }

  Future<void> _handleTokenRefresh(String token) async {
    await _syncTokenWithBackend(token);
    final currentState = state.value ?? FCMState();
    state = AsyncValue.data(currentState.copyWith(token: token));
  }

  Future<void> _syncTokenWithBackend(String fcmToken) async {
    try {
      final notificationRepo = ref.read(notificationServiceProvider);
      await notificationRepo.registerDevice(fcmToken);
    } catch (e) {
      final currentState = state.value ?? FCMState();
      log('Failed to sync FCM token with backend: $e');
      state = AsyncValue.data(currentState.copyWith(error: 'Failed to sync token: $e'));
    }
  }
}

final fcmNotifierProvider = AsyncNotifierProvider<FCMNotifier, FCMState>(FCMNotifier.new);