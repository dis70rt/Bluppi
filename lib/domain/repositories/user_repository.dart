import 'package:bluppi/domain/models/create_user_model.dart';
import 'package:bluppi/domain/models/user_model.dart';
import 'package:bluppi/domain/models/user_summary_model.dart';

abstract class UserRepository {
  Future<UserModel> createUser(CreateUserModel user);
  Future<UserModel> getUserById(String id);
  Future<UserModel> getCurrentUser();
  Future<UserModel> getUserByUsername(String username);
  Future<bool> checkUserExists(String id);
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<bool> isFollowing(String followeeId);
  Future<(List<UserSummaryModel>, String)> getSuggestedFriends(String nextCursor, {int limit = 10});
}