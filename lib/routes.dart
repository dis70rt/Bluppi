import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/search_bar.dart';
import 'package:synqit/UI/Screens/HomeScreen/home_screen.dart';
import 'package:synqit/UI/Screens/ProfileScreen/other_profile_screen.dart';
import 'package:synqit/UI/Screens/ProfileSettingScreen/Settings/edit_profile_screen.dart';
import 'package:synqit/UI/Screens/ProfileSettingScreen/profile_settings_screen.dart';
import 'package:synqit/UI/Widgets/auth_wrapper.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/auth',
  routes: <RouteBase>[
    GoRoute(
      name: '/auth',
      path: '/auth',
      builder: (context, state) => const AuthWrapper(),
    ),
    GoRoute(
      name: '/home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: '/main',
      path: '/main',
      builder: (context, state) => const MainScreenWidget(),
    ),
    GoRoute(
      name: '/search',
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      name: '/main-screen',
      path: '/main-screen',
      builder: (context, state) => const MainScreenWidget(),
    ),
    GoRoute(
      name: '/edit-profile',
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      name: '/settings',
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: 'user-profile',
      path: '/:username',
      pageBuilder: (context, state) {
        final username = state.pathParameters['username']!;

        return CustomTransitionPage(
          key: ValueKey('user-$username'),
          child: OtherProfileScreen(
            username: username,
            onBack: () => context.pushReplacement("/main"),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
  ],
);
