enum AuthStatus {
  authenticated,
  unauthenticated,
  unknown,
}

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<void> logIn({required String username, required String password});
  Future<void> logInWithGoogle();
  Future<void> logOut();
}