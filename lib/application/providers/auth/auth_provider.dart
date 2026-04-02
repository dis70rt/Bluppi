import 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:bluppi/application/providers/auth/logout_provider.dart';
import 'package:bluppi/data/auth/firebase_auth_repository.dart';
import 'package:bluppi/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository();
});

final authStateProvider = StreamProvider<AuthStatus>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.status;
});