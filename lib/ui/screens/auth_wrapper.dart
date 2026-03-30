import 'package:bluppi/data/auth/account_status_provider.dart';
import 'package:bluppi/domain/models/account_status.dart';
import 'package:bluppi/ui/screens/HomeScreen/home_loading_screen.dart';
import 'package:bluppi/ui/screens/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const SizedBox.shrink();
    }

    final statusAsync = ref.watch(accountStatusProvider(user.uid));

    return statusAsync.when(
      loading: () => const LoadingHome(),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (status) {
        if (status == AccountStatus.needsProfile) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/create-profile');
          });
          return const LoadingHome();
        }
        return const HomeScreen();
      },
    );
  }
}