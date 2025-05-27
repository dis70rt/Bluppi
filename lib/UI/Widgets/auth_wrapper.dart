import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Provider/auth_provider.dart';
import 'package:synqit/Provider/chat_provider/socket_provider.dart';
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
      data: (authResult) {
        final firebaseUser = authResult.user;

        if (firebaseUser == null) {
          return const LoginScreen();
        } else {
          final userProfileAsyncValue = ref.watch(userProvider);
          return userProfileAsyncValue.when(
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stackTrace) {
              if (error is UserProfileNotFoundException) {
                return CreateAccountScreen(user: firebaseUser);
              } else {
                return Scaffold(
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Error loading user profile:"),
                      Text(error.toString()),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            ref.read(authProvider.notifier).signOut();
                          },
                          child: const Text("Try Logging Out"))
                    ],
                  )),
                );
              }
            },
            data: (userModel) {
              if (userModel != null) {
                Future.microtask(() {
                  ref.read(socketProvider.notifier).initialize(userModel.id);
                });
                return const MainScreenWidget();
              } else {
                log("AuthWrapper: userModel is null despite userProvider succeeding.");
                return CreateAccountScreen(user: firebaseUser);
              }
            },
          );
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text("Authentication Error: $error")),
      ),
    );
  }
}
