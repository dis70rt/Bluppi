import 'dart:developer';

import 'package:bluppi/domain/models/create_user_model.dart';
import 'package:bluppi/domain/repositories/user_repository.dart';
import 'package:bluppi/generated/users.pbgrpc.dart' as proto;
import 'package:bluppi/domain/models/user_model.dart';
import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceClientRepositoryProvider = Provider<UserServiceClientRepository>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = proto.UserServiceClient(channel);
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
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final request = proto.FollowUserRequest(followerId: userId, followeeId: currentUserId);
    await _client.followUser(request);
  }

  @override
  Future<void> unfollowUser(String userId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final request = proto.UnfollowUserRequest(followerId: userId, followeeId: currentUserId);
    await _client.unfollowUser(request);
  }

  @override
  Future<bool> isFollowing(String followeeId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final request = proto.IsFollowingRequest(followerId: currentUserId, followeeId: followeeId);
    final response = await _client.isFollowing(request);
    return response.isFollowing;
  }
}