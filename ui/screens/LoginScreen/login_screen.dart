import 'package:bluppi/core/utils/snackbar.dart';
import 'package:bluppi/ui/screens/LoginScreen/animated_background.dart';
import 'package:bluppi/ui/screens/LoginScreen/avatar_orbits.dart';
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
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  const AvatarOrbits(),

                  const Spacer(),

                  const OnboardingCarousel(),
                  const SizedBox(height: 40),

                  SlideToSignInBtn(
                    isLoading: isBusy,
                    onSlideComplete: _handleGoogleSignIn,
                    theme: theme,
                  ),
                  const SizedBox(height: 24),
                  _buildTermsText(theme),
                  const SizedBox(height: 16),
                ],
              ),
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