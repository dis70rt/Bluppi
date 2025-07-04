import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Provider/UserProvider/auth_provider.dart';
import 'package:bluppi/UI/Widgets/background.dart';
import 'package:bluppi/Utils/snackbar.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final authState = ref.watch(authProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedGradientBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  _buildLogo(size),
                  const Spacer(flex: 1),
                  _buildTagline(),
                  const Spacer(flex: 2),
                  _buildGoogleLoginButton(context, ref, isLoading),
                  const SizedBox(height: 16),
                  _buildTermsText(),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(Size size) {
    return Column(
      children: [
        SizedBox(
          width: size.width * 0.4,
          height: size.width * 0.4,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/icons/launcher.png',
                fit: BoxFit.contain,
                width: size.width * 0.25,
                height: size.width * 0.25,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTagline() {
    return Column(
      children: [
        const Text(
          "Sync. Amplify. Connect.",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.surface,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Experience music like never before.",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.surface.withValues(alpha: 0.8),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGoogleLoginButton(
      BuildContext context, WidgetRef ref, bool isLoading) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: RawMaterialButton(
        fillColor: const Color.fromARGB(255, 244, 244, 244),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: isLoading
            ? null
            : () async {
                try {
                  await ref.read(authProvider.notifier).signInWithGoogle();
                } catch (e) {
                  if (context.mounted) {
                    showSnackBar(
                      context: context,
                      message: "Error signing in. Please try again.",
                      icon: const FaIcon(
                        FontAwesomeIcons.circleExclamation,
                        color: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.accent.withValues(alpha: 0.8),
                    ),
                  ),
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/icons/google.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                          color: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'By continuing, you agree to our Terms of Service and Privacy Policy',
        style: TextStyle(
          fontSize: 12,
          color: AppColors.surface.withValues(alpha: 0.6),
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
