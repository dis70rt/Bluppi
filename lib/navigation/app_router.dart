import 'dart:async';
import 'package:bluppi/ui/screens/CreateProfileScreen/create_profile_screen.dart';
import 'package:bluppi/ui/screens/LoginScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bluppi/application/providers/auth_provider.dart';
import 'package:bluppi/domain/repositories/auth_repository.dart';
import 'package:bluppi/ui/screens/HomeScreen/home_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
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
      final isLoading = authState.isLoading;
      final isAuthenticated = authState.value == AuthStatus.authenticated;

      // TODO: Replace this with your actual DB Provider (e.g., ref.watch(userProfileProvider))

      final bool isUserInDatabase = true; 

      final String location = state.uri.path;
      final bool isLoggingIn = location == '/login';
      final bool isCreatingProfile = location == '/create-profile';

      // --- FLOW START ---

      // A. Global Loading (Auth or DB check is initializing)
      if (isLoading) return null;

      // B. Unauthenticated Flow
      if (!isAuthenticated) {
        // If not logged in and not on login page, force login
        if (!isLoggingIn) return '/login';
        // If on login page, stay there
        return null;
      }

      if (isAuthenticated) {
        
        // C1. Check Database (Does user exist?)
        if (!isUserInDatabase) {
          // Rule: If user NOT in DB, go to Create Profile
          if (!isCreatingProfile) return '/create-profile';
          return null;
        }

        if (isLoggingIn || isCreatingProfile) {
          return '/';
        }
      }

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