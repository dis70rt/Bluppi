import 'dart:async';
import 'dart:developer';
import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/ui/screens/CreateProfileScreen/create_profile_screen.dart';
import 'package:bluppi/ui/screens/HomeScreen/home_screen.dart';
import 'package:bluppi/ui/screens/LoginScreen/login_screen.dart';
import 'package:bluppi/ui/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bluppi/application/providers/auth_provider.dart';
import 'package:bluppi/domain/repositories/auth_repository.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.status),

    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/create-profile',
        name: 'create_profile',
        builder: (context, state) => const CreateProfileScreen(),
      ),
      GoRoute(
        path: '/u/:username',
        builder: (context, state) {
          final username = state.pathParameters['username'];
          return Scaffold(body: Center(child: Text('Profile: $username')));
        },
      ),
    ],

    redirect: (context, state) {
      if (authState.isLoading) return null;

      final isAuthenticated = authState.value == AuthStatus.authenticated;

      final String location = state.uri.path;
      final bool isLogin = location == '/login';
      final bool isAuthGate = location == '/auth';

      if (!isAuthenticated) {
        return isLogin ? null : '/login';
      }

      if (isLogin) return '/auth';
      if (isAuthGate) return null;

      return null;
    },
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
