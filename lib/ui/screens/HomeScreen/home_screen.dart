import 'package:bluppi/application/controllers/home_controller.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/core/utils/error_scaffold.dart';
import 'package:bluppi/ui/screens/HomeScreen/Activity/activity_section.dart';
import 'package:bluppi/ui/screens/HomeScreen/SuggestFriends/suggest_friends_section.dart';
import 'package:bluppi/ui/screens/HomeScreen/WeeklyDiscovery/weekly_discovery_section.dart';
import 'package:bluppi/ui/screens/HomeScreen/shared/app_bar.dart';
import 'package:bluppi/ui/screens/HomeScreen/home_loading_screen.dart';
import 'package:bluppi/ui/screens/HomeScreen/RecentlyPlayed/recently_played_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeInitController);
    
    return homeAsync.when(
      data: (user) {
        if (user == null) {
          context.go('/auth');
          return const SizedBox.shrink();
        }

        return SafeArea(
          child: Scaffold(
            appBar: HomeAppBar(user: user),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    ActivitySection(),
                    WeeklyDiscovery(),
                    RecentlyPlayedSection(),
                    SuggestFriendSection(),
                    const SizedBox(height:80),
                    MaterialButton(onPressed: () {
                      context.go('/u/openai');
                    }, child: Text("Shikha Das"),)
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => LoadingHome(),
      error: (error, stackTrace) => ScaffoldError(
        message: "Error loading user data: $error",
        onRetry: () => ref.refresh(userProvider),
      ),
    );
  }

  // void _signOut(WidgetRef ref) async {
  //   await ref.read(fcmNotifierProvider.notifier).unregisterAndDeleteToken();
  //   await ref.read(authRepositoryProvider).logOut();

  //   ref.invalidate(userProvider);
  //   ref.invalidate(userExistsProvider);
  //   ref.invalidate(authStateProvider);
  // }
}
