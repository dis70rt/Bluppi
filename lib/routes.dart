import 'package:bluppi/UI/Screens/ChatScreen/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bluppi/Data/Models/user_model.dart';
import 'package:bluppi/UI/Screens/ChatScreen/chatting_screen.dart';
import 'package:bluppi/UI/Screens/RoomScreen/utils/join_room_deeplinks.dart';
import 'package:bluppi/UI/Screens/RoomScreen/listening_room.dart';
import 'package:bluppi/UI/Screens/RoomScreen/room_screen.dart';
import 'package:bluppi/UI/Screens/SearchScreen/search_screen.dart';
import 'package:bluppi/UI/Screens/HomeScreen/home_screen.dart';
import 'package:bluppi/UI/Screens/ProfileScreen/other_profile_screen.dart';
import 'package:bluppi/UI/Screens/ProfileSettingScreen/Settings/edit_profile_screen.dart';
import 'package:bluppi/UI/Screens/ProfileSettingScreen/profile_settings_screen.dart';
import 'package:bluppi/UI/Widgets/auth_wrapper.dart';
import 'package:bluppi/UI/Widgets/main_screen.dart';

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
      name: 'chat',
      path: '/chat/:conversationId',
      builder: (context, state) {
        final conversationId = state.pathParameters['conversationId']!;
        final user = state.extra as UserModel;

        return ChattingScreen(
          conversationId: conversationId,
          user: user,
        );
      },
    ),
    GoRoute(
      name: 'chat-screen',
      path: '/chat-screen',
      builder: (context, state) => ChatsScreen(),
    ),
    GoRoute(
      name: 'room',
      path: '/room',
      builder: (context, state) => const RoomScreen(),
    ),
    GoRoute(
      name: 'listening',
      path: '/listening',
      builder: (context, state) {
        return const ListeningScreen();
      },
    ),
    GoRoute(
      name: 'join-room-link',
      path: '/join/:roomCode',
      builder: (context, state) {
        final roomCode = state.pathParameters['roomCode']!;
        return JoinRoomDeepLinkScreen(roomCode: roomCode);
      },
    ),
    // Keep this route always at the end
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
