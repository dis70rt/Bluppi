import 'package:bluppi/domain/models/create_user_model.dart';
import 'package:bluppi/domain/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> createUser(CreateUserModel user);
  Future<UserModel> getUserById(String id);
  Future<bool> checkUserExists(String id);
}