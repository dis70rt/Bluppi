import 'package:bluppi/application/providers/auth/auth_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/core/utils/error_scaffold.dart';
import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/ui/screens/HomeScreen/widgets/app_bar.dart';
import 'package:bluppi/ui/screens/HomeScreen/widgets/loading_home.dart';
import 'package:bluppi/ui/screens/HomeScreen/widgets/recently_played_widget.dart';
import 'package:bluppi/ui/widgets/floating_media_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) {
          context.go('/auth');
          return const SizedBox.shrink();
        }

        return Scaffold(
          appBar: HomeAppBar(user: user),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RecentlyPlayedWidget(),
              Text('Welcome, ${user.name}'),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () => _signOut(ref),
                child: const Text("Sign Out"),
              ),
            ],
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

  void _signOut(WidgetRef ref) async {
    await ref.read(authRepositoryProvider).logOut();

    ref.invalidate(userProvider);
    ref.invalidate(userExistsProvider);
    ref.invalidate(authStateProvider);
  }
}
