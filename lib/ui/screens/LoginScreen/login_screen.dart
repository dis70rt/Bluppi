import 'dart:developer';

import 'package:bluppi/core/utils/snackbar.dart';
import 'package:bluppi/ui/screens/LoginScreen/infinite_scrolling.dart';
import 'package:bluppi/ui/screens/LoginScreen/onboarding_carousel.dart';
import 'package:bluppi/ui/screens/LoginScreen/slide_to_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bluppi/application/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).logInWithGoogle();
    } catch (e) {
      if (!mounted) return;
      showSnackBar(
        context: context,
        message: "Error signing in: $e",
        icon: const FaIcon(
          FontAwesomeIcons.circleExclamation,
          color: Colors.redAccent,
        ),
      );
      log("Error during Google Sign-In: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final theme = Theme.of(context);

    final isGlobalLoading = authState.isLoading;
    final isBusy = _isLoading || isGlobalLoading;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Stack(
        children: [
          const InfiniteScrolling(),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.primaryColor.withAlpha(128), 
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                const Spacer(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: const OnboardingCarousel(),
                ),
                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SlideToSignInBtn(
                    isLoading: isBusy,
                    onSlideComplete: _handleGoogleSignIn,
                    theme: theme,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildTermsText(theme),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsText(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'By continuing, you agree to our Terms of Service and Privacy Policy',
        style: theme.textTheme.bodySmall?.copyWith(fontSize: 12, height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }
}
