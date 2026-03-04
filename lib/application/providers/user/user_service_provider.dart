import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:bluppi/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userByIdProvider = FutureProvider.family.autoDispose<UserModel, String>((ref, String userId) async {
  final userService = ref.watch(userServiceClientRepositoryProvider);
  return await userService.getUserById(userId);
});