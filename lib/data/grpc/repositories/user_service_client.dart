import 'package:bluppi/data/auth/auth_interceptor.dart';
import 'package:bluppi/domain/models/create_user_model.dart';
import 'package:bluppi/domain/models/follow_user_entry_model.dart';
import 'package:bluppi/domain/models/user_summary_model.dart';
import 'package:bluppi/domain/repositories/user_repository.dart';
import 'package:bluppi/generated/users.pbgrpc.dart' as proto;
import 'package:bluppi/domain/models/user_model.dart';
import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceClientRepositoryProvider = Provider<UserServiceClientRepository>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = proto.UserServiceClient(
    channel,
    interceptors: [AuthInterceptor()],
    );
  return UserServiceClientRepository(client);
});

final userExistsProvider = FutureProvider.family<bool, String>((ref, userId) async {
  return ref.read(userServiceClientRepositoryProvider).checkUserExists(userId);
});

class UserServiceClientRepository implements UserRepository {
  final proto.UserServiceClient _client;

  UserServiceClientRepository(this._client);

  @override
  Future<UserModel> createUser(CreateUserModel user) async {
    final request = user.toProto();
    final response = await _client.createUser(request);
    return UserModel.fromProto(response.user);
  }

  @override
  Future<UserModel> getUserById(String id) async {
    final request = proto.GetUserByIdRequest(userId: id);
    final response = await _client.getUserById(request);
    return UserModel.fromProto(response.user);
  }

  @override
  Future<bool> checkUserExists(String id) async {
    final request = proto.CheckUserRequest(id: id);
    final response = await _client.checkUserExists(request);
    return response.exists;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final request = proto.GetUserByIdRequest(userId: currentUser.uid);
    final response = await _client.getUserById(request);
    return UserModel.fromProto(response.user);
  }

  @override
  Future<UserModel> getUserByUsername(String username) async {
    final request = proto.GetUserByUsernameRequest(username: username);
    final response = await _client.getUserByUsername(request);
    return UserModel.fromProto(response.user);
  }

  @override
  Future<void> followUser(String userId) async {
    final request = proto.FollowUserRequest(followeeId: userId);
    await _client.followUser(request);
  }

  @override
  Future<void> unfollowUser(String userId) async {
    final request = proto.UnfollowUserRequest(followeeId: userId);
    await _client.unfollowUser(request);
  }

  @override
  Future<bool> isFollowing(String followeeId) async {
    final request = proto.IsFollowingRequest(followeeId: followeeId);
    final response = await _client.isFollowing(request);
    return response.isFollowing;
  }

  @override
  Future<(List<UserSummaryModel>,String)> getSuggestedFriends(String nextCursor, {int limit = 10}) async {
    final request = proto.SuggestFriendsRequest(limit: limit, nextCursor: nextCursor);
    final response = await _client.getSuggestedFriends(request);
    final users = response.users.map((proto.UserSummary p) => UserSummaryModel.fromProto(p)).toList();

    return (users, response.nextCursor);
  }

  @override
  Future<(List<FollowUserEntryModel>, String, bool)> getFollowers(String userId, String nextCursor, {int limit = 20}) async {
    final request = proto.GetFollowersRequest(userId: userId, limit: limit, cursor: nextCursor);
    final response = await _client.getFollowers(request);
    final followers = response.followers.map((proto.FollowUserEntry p) => FollowUserEntryModel.fromProto(p)).toList();
    return (followers, response.nextCursor, response.hasMore);
  }

  @override
  Future<(List<FollowUserEntryModel>, String, bool)> getFollowings(String userId, String nextCursor, {int limit = 20}) async {
    final request = proto.GetFollowingRequest(userId: userId, limit: limit, cursor: nextCursor);
    final response = await _client.getFollowing(request);
    final followings = response.following.map((proto.FollowUserEntry p) => FollowUserEntryModel.fromProto(p)).toList();
    return (followings, response.nextCursor, response.hasMore);
  }

  @override
  Future<UserModel> updateUser({
    String? name,
    String? bio,
    String? country,
    String? phone,
    String? profilePic,
    List<String>? favoriteGenres,
    String? gender,
  }) async {
    final request = proto.UpdateUserRequest();
    if (name != null) request.name = name;
    if (bio != null) request.bio = bio;
    if (country != null) request.country = country;
    if (phone != null) request.phone = phone;
    if (profilePic != null) request.profilePic = profilePic;
    if (favoriteGenres != null) request.favoriteGenres.addAll(favoriteGenres);
    if (gender != null) request.gender = gender;
    final response = await _client.updateUser(request);
    return UserModel.fromProto(response.user);
  }
}