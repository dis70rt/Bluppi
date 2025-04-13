import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Provider/auth_provider.dart';
import 'package:synqit/UI/Screens/login_screen.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return authState.when(
      data: (auth) {
        if (auth.user == null) {
          return const LoginScreen();
        } else {
          return const MainScreenWidget();
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text("Error: $error")),
      ),
    );
  }
}
