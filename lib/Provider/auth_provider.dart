import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synqit/config.dart';

class Auth {
  final User? user;
  final String accessToken;
  final String refreshToken;
  final DateTime expiryTime;

  Auth({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiryTime,
  });
}

final authProvider = AsyncNotifierProvider<AuthNotifier, Auth>(
  () => AuthNotifier(),
);

class AuthNotifier extends AsyncNotifier<Auth> {
  final SupabaseClient supabase = Supabase.instance.client;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiURL,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Timer? _refreshTimer;

  @override
  Future<Auth> build() async {
    final sessionEvent = await supabase.auth.onAuthStateChange.first;
    final user = sessionEvent.session?.user;
    final token = sessionEvent.session?.providerToken ?? '';
    final refresh = sessionEvent.session?.providerRefreshToken ?? '';
    final expiresAt = sessionEvent.session?.expiresAt != null
        ? DateTime.fromMillisecondsSinceEpoch(
            sessionEvent.session!.expiresAt! * 1000)
        : DateTime.now().add(const Duration(hours: 1));


    final auth = Auth(
      user: user,
      accessToken: token,
      refreshToken: refresh,
      expiryTime: expiresAt,
    );

    scheduleTokenRefresh();
    return auth;
  }

  Future<void> signInWithSpotify() async {
    state = const AsyncValue.loading();
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.spotify,
        redirectTo: kIsWeb
            ? '${dotenv.env["SUPABASE_URL"]}/auth/v1/callback'
            : 'synqit://auth',
        authScreenLaunchMode: LaunchMode.externalApplication,
        scopes: '''
          user-read-email
          user-read-private
          user-read-playback-state
          user-top-read
          user-follow-read
          playlist-read-private
          user-read-recently-played
        ''',
      );

      final sessionEvent = await supabase.auth.onAuthStateChange.first;
      final user = sessionEvent.session?.user;
      final token = sessionEvent.session?.providerToken ?? '';
      final refresh = sessionEvent.session?.providerRefreshToken ?? '';
      final expiresAt = sessionEvent.session?.expiresAt != null
          ? DateTime.fromMillisecondsSinceEpoch(
              sessionEvent.session!.expiresAt! * 1000)
          : DateTime.now().add(const Duration(hours: 1));

      final auth = Auth(
        user: user,
        accessToken: token,
        refreshToken: refresh,
        expiryTime: expiresAt,
      );

      state = AsyncValue.data(auth);
      scheduleTokenRefresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    final session = supabase.auth.currentSession;
    if (session == null) return;

    try {
      final resp = await _dio.post(
        '/token/refresh',
        data: {
          'user_id': session.user.id,
          'refresh_token': session.providerRefreshToken,
        },
      );

      final data = resp.data as Map<String, dynamic>;
      final newAccess = data['access_token'] as String;
      final newRefresh = data['refresh_token'] as String;
      final expiresIn = data['expires_in'] as int;

      final newExpiry = DateTime.now().add(Duration(seconds: expiresIn));

      final auth = Auth(
        user: session.user,
        accessToken: newAccess,
        refreshToken: newRefresh,
        expiryTime: newExpiry,
      );

      state = AsyncValue.data(auth);
      scheduleTokenRefresh();
    } catch (e) {
      debugPrint('Error refreshing token via API: $e');
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    _refreshTimer?.cancel();
    state = AsyncValue.data(Auth(
      user: null,
      accessToken: '',
      refreshToken: '',
      expiryTime: DateTime.now(),
    ));
  }

  void scheduleTokenRefresh() {
    _refreshTimer?.cancel();
    final auth = state.value;
    if (auth == null) return;

    const refreshWindow = Duration(minutes: 5);
    final timeToRefresh =
        auth.expiryTime.difference(DateTime.now()) - refreshWindow;

    if (timeToRefresh <= Duration.zero) {
      _refreshTimer = Timer(Duration.zero, () => refresh());
    } else {
      _refreshTimer = Timer(timeToRefresh, () => refresh());
    }
  }
}
