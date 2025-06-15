import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' hide OAuthProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:synqit/Provider/MusicProvider/current_track_provider.dart';
import 'package:synqit/Provider/MusicProvider/music_player_provider.dart';
import 'package:synqit/Provider/MusicProvider/queue_provider.dart';

class Auth {
  final User? user;

  Auth({required this.user});
}

final authProvider = AsyncNotifierProvider<AuthNotifier, Auth>(
  () => AuthNotifier(),
);

class AuthNotifier extends AsyncNotifier<Auth> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  StreamSubscription? _authStateSubscription;

  @override
  Future<Auth> build() async {
    _authStateSubscription?.cancel();

    _authStateSubscription = _firebaseAuth.authStateChanges().listen((user) {
      state = AsyncData(Auth(user: user));
    });

    ref.onDispose(() {
      _authStateSubscription?.cancel();
    });

    return Auth(user: _firebaseAuth.currentUser);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        state = AsyncData(Auth(user: _firebaseAuth.currentUser));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e, stack) {
      log('Error during Google sign-in: $e\n$stack');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signOut() async {
    try {
      state = const AsyncValue.loading();

      final musicPlayerNotifier = ref.read(musicPlayerProvider.notifier);
      await musicPlayerNotifier.stop();
      await musicPlayerNotifier.clearQueueAndStop();

      ref.read(currentTrackProvider.notifier).state = null;
      ref.read(queueProvider.notifier).clear();

      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();

      state = AsyncData(Auth(user: null));

      log("User signed out successfully");
    } catch (e, stack) {
      log("Error during sign out: $e");
      state = AsyncValue.error(e, stack);
    }
  }
}
