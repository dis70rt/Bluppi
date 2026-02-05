import 'package:bluppi/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<AuthStatus> get status {
    return _firebaseAuth.authStateChanges().map((User? user) {
      return user != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated;
    });
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    await _googleSignIn.initialize();
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: null, 
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Google Sign-In failed or cancelled: $e');
    }
  }

  @override
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
  }

  @override
  Future<void> logOut() async {
    try {
      await _ensureGoogleSignInInitialized();
      await _googleSignIn.signOut();
    } catch (_) {}
    await _firebaseAuth.signOut();
  }
}