import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Provider/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            loginButton(context, ref),
            const SizedBox(height: 10),
            logoutButton(context, ref)
          ],
        ),
      ));
  }
}

Widget loginButton(BuildContext context, WidgetRef ref) {
  return Center(
    child: MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () => ref.read(authProvider.notifier).signInWithSpotify(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
            color: Spotify.primary,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.spotify,
                color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Text(
              "Continue with Spotify",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget logoutButton(BuildContext context, WidgetRef ref) {
  return Center(
    child: MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () => ref.read(authProvider.notifier).signOut(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
            // color: Spotify.primary,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.arrowRightFromBracket,
                color: Theme.of(context).primaryColorLight, size: 14,),
            const SizedBox(width: 12),
            Text(
              "Sign Out",
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ),
      ),
    ),
  );
}


