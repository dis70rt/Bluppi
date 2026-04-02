import 'dart:developer';

import 'package:bluppi/application/providers/activity/activity_provider.dart';
import 'package:bluppi/application/providers/auth/auth_provider.dart';
import 'package:bluppi/application/providers/user/edit_profile_provider.dart';
import 'package:bluppi/application/providers/music/history_provider.dart';
import 'package:bluppi/application/providers/music/playback_provider.dart';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/application/providers/music/recently_search_provider.dart';
import 'package:bluppi/application/providers/music/weekly_discover_provider.dart';
import 'package:bluppi/application/providers/notification/fcm_provider.dart';
import 'package:bluppi/application/providers/presence/presence_provider.dart';
import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/room/search_room_provider.dart';
import 'package:bluppi/application/providers/user/suggested_friends_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logoutProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final authRepo = ref.read(authRepositoryProvider);
    await authRepo.logOut();

    try {
      await audioHandler.stop();
    } catch (e) {
      log('Audio handler stop ignored during logout: $e');
    }

    await Future.delayed(const Duration(milliseconds: 150));

    // 2. Clear all global provider states
    ref.invalidate(userProvider);
    ref.invalidate(activityProvider);
    ref.invalidate(fcmNotifierProvider);
    ref.invalidate(historyProvider);
    ref.invalidate(weeklyDiscoverProvider);
    ref.invalidate(recentlySearchProvider);
    ref.invalidate(suggestedUsersProvider);

    ref.invalidate(queueProvider);
    ref.invalidate(playerProvider);

    ref.invalidate(currentRoomProvider);
    ref.invalidate(presenceProvider);
    ref.invalidate(listRoomsProvider);
    ref.invalidate(editProfileProvider);
  };
});
