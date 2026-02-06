import 'package:bluppi/data/auth/account_status_provider.dart';
import 'package:bluppi/domain/models/account_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (status) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (status == AccountStatus.needsProfile) {
            context.go('/create-profile');
          } else {
            context.go('/');
          }
        });
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: const Center(child: CircularProgressIndicator()));
      },
    );
  }
}