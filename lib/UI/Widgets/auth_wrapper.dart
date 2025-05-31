import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Provider/auth_provider.dart';
import 'package:synqit/Provider/user_provider/user_provider.dart';
import 'package:synqit/UI/Screens/create_account_screen.dart';
import 'package:synqit/UI/Screens/login_screen.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return authState.when(
      loading: () => const _LoadingScreen(message: "Authenticating..."),
      error: (error, _) => _ErrorScreen(
        error: "Authentication error: $error",
        onRetry: () => ref.refresh(authProvider),
      ),
      data: (authResult) {
        if (authResult.user == null) {
          return const LoginScreen();
        }

        final userProfileState = ref.watch(userProvider);
        return userProfileState.when(
          loading: () =>
              const _LoadingScreen(message: "Loading your profile..."),
          error: (error, _) {
            if (error is UserProfileNotFoundException) {
              return CreateAccountScreen(user: authResult.user!);
            }

            return _ErrorScreen(
              error: "Profile error: $error",
              onRetry: () {
                ref.read(userProvider.notifier).refresh();
              },
              allowSignOut: true,
              ref: ref,
            );
          },
          data: (userModel) {
            if (userModel == null) {
              log("AuthWrapper: userModel is null despite userProvider succeeding.");
              return CreateAccountScreen(user: authResult.user!);
            }

            return const MainScreenWidget();
          },
        );
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  final String message;

  const _LoadingScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;
  final bool allowSignOut;
  final WidgetRef? ref;

  const _ErrorScreen({
    required this.error,
    this.onRetry,
    this.allowSignOut = false,
    this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              if (onRetry != null)
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text("Retry"),
                ),
              if (allowSignOut && ref != null) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => ref!.read(authProvider.notifier).signOut(),
                  child: const Text("Sign Out"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
