import 'package:bluppi/domain/models/create_user_model.dart';
import 'package:bluppi/domain/models/follow_user_entry_model.dart';
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
  Future<(List<FollowUserEntryModel>, String, bool)> getFollowers(String userId, String nextCursor, {int limit = 20});
  Future<(List<FollowUserEntryModel>, String, bool)> getFollowings(String userId, String nextCursor, {int limit = 20});
  Future<UserModel> updateUser({String? name, String? bio, String? country, String? phone, String? profilePic, List<String>? favoriteGenres, String? gender});
}