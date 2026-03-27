// This is a generated file - do not edit.
//
// Generated from users.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'users.pb.dart' as $0;

export 'users.pb.dart';

@$pb.GrpcServiceName('users.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UserServiceClient(super.channel, {super.options, super.interceptors});

  /// --- Core User CRUD ---
  $grpc.ResponseFuture<$0.UserResponse> createUser(
    $0.CreateUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserResponse> getUserById(
    $0.GetUserByIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserById, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserResponse> getUserByUsername(
    $0.GetUserByUsernameRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserByUsername, request, options: options);
  }

  $grpc.ResponseFuture<$0.UserResponse> updateUser(
    $0.UpdateUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteUserResponse> deleteUser(
    $0.DeleteUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteUser, request, options: options);
  }

  /// --- Checks & Search ---
  $grpc.ResponseFuture<$0.SearchUsersResponse> searchUsers(
    $0.SearchUsersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchUsers, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckExistenceResponse> checkUsername(
    $0.CheckUsernameRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkUsername, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckExistenceResponse> checkEmail(
    $0.CheckEmailRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkEmail, request, options: options);
  }

  $grpc.ResponseFuture<$0.CheckExistenceResponse> checkUserExists(
    $0.CheckUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkUserExists, request, options: options);
  }

  /// --- Stats & History ---
  $grpc.ResponseFuture<$0.UserStatsResponse> getUserStats(
    $0.GetUserStatsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserStats, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> addRecentSearch(
    $0.AddRecentSearchRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addRecentSearch, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecentSearchesResponse> getRecentSearches(
    $0.GetRecentSearchesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRecentSearches, request, options: options);
  }

  /// --- Follow System ---
  $grpc.ResponseFuture<$0.StatusResponse> followUser(
    $0.FollowUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$followUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> unfollowUser(
    $0.UnfollowUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unfollowUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFollowersResponse> getFollowers(
    $0.GetFollowersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFollowers, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFollowingResponse> getFollowing(
    $0.GetFollowingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFollowing, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsFollowingResponse> isFollowing(
    $0.IsFollowingRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$isFollowing, request, options: options);
  }

  $grpc.ResponseFuture<$0.SuggestFriendsResponse> getSuggestedFriends(
    $0.SuggestFriendsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSuggestedFriends, request, options: options);
  }

  // method descriptors

  static final _$createUser =
      $grpc.ClientMethod<$0.CreateUserRequest, $0.UserResponse>(
          '/users.UserService/CreateUser',
          ($0.CreateUserRequest value) => value.writeToBuffer(),
          $0.UserResponse.fromBuffer);
  static final _$getUserById =
      $grpc.ClientMethod<$0.GetUserByIdRequest, $0.UserResponse>(
          '/users.UserService/GetUserById',
          ($0.GetUserByIdRequest value) => value.writeToBuffer(),
          $0.UserResponse.fromBuffer);
  static final _$getUserByUsername =
      $grpc.ClientMethod<$0.GetUserByUsernameRequest, $0.UserResponse>(
          '/users.UserService/GetUserByUsername',
          ($0.GetUserByUsernameRequest value) => value.writeToBuffer(),
          $0.UserResponse.fromBuffer);
  static final _$updateUser =
      $grpc.ClientMethod<$0.UpdateUserRequest, $0.UserResponse>(
          '/users.UserService/UpdateUser',
          ($0.UpdateUserRequest value) => value.writeToBuffer(),
          $0.UserResponse.fromBuffer);
  static final _$deleteUser =
      $grpc.ClientMethod<$0.DeleteUserRequest, $0.DeleteUserResponse>(
          '/users.UserService/DeleteUser',
          ($0.DeleteUserRequest value) => value.writeToBuffer(),
          $0.DeleteUserResponse.fromBuffer);
  static final _$searchUsers =
      $grpc.ClientMethod<$0.SearchUsersRequest, $0.SearchUsersResponse>(
          '/users.UserService/SearchUsers',
          ($0.SearchUsersRequest value) => value.writeToBuffer(),
          $0.SearchUsersResponse.fromBuffer);
  static final _$checkUsername =
      $grpc.ClientMethod<$0.CheckUsernameRequest, $0.CheckExistenceResponse>(
          '/users.UserService/CheckUsername',
          ($0.CheckUsernameRequest value) => value.writeToBuffer(),
          $0.CheckExistenceResponse.fromBuffer);
  static final _$checkEmail =
      $grpc.ClientMethod<$0.CheckEmailRequest, $0.CheckExistenceResponse>(
          '/users.UserService/CheckEmail',
          ($0.CheckEmailRequest value) => value.writeToBuffer(),
          $0.CheckExistenceResponse.fromBuffer);
  static final _$checkUserExists =
      $grpc.ClientMethod<$0.CheckUserRequest, $0.CheckExistenceResponse>(
          '/users.UserService/CheckUserExists',
          ($0.CheckUserRequest value) => value.writeToBuffer(),
          $0.CheckExistenceResponse.fromBuffer);
  static final _$getUserStats =
      $grpc.ClientMethod<$0.GetUserStatsRequest, $0.UserStatsResponse>(
          '/users.UserService/GetUserStats',
          ($0.GetUserStatsRequest value) => value.writeToBuffer(),
          $0.UserStatsResponse.fromBuffer);
  static final _$addRecentSearch =
      $grpc.ClientMethod<$0.AddRecentSearchRequest, $0.StatusResponse>(
          '/users.UserService/AddRecentSearch',
          ($0.AddRecentSearchRequest value) => value.writeToBuffer(),
          $0.StatusResponse.fromBuffer);
  static final _$getRecentSearches = $grpc.ClientMethod<
          $0.GetRecentSearchesRequest, $0.RecentSearchesResponse>(
      '/users.UserService/GetRecentSearches',
      ($0.GetRecentSearchesRequest value) => value.writeToBuffer(),
      $0.RecentSearchesResponse.fromBuffer);
  static final _$followUser =
      $grpc.ClientMethod<$0.FollowUserRequest, $0.StatusResponse>(
          '/users.UserService/FollowUser',
          ($0.FollowUserRequest value) => value.writeToBuffer(),
          $0.StatusResponse.fromBuffer);
  static final _$unfollowUser =
      $grpc.ClientMethod<$0.UnfollowUserRequest, $0.StatusResponse>(
          '/users.UserService/UnfollowUser',
          ($0.UnfollowUserRequest value) => value.writeToBuffer(),
          $0.StatusResponse.fromBuffer);
  static final _$getFollowers =
      $grpc.ClientMethod<$0.GetFollowersRequest, $0.GetFollowersResponse>(
          '/users.UserService/GetFollowers',
          ($0.GetFollowersRequest value) => value.writeToBuffer(),
          $0.GetFollowersResponse.fromBuffer);
  static final _$getFollowing =
      $grpc.ClientMethod<$0.GetFollowingRequest, $0.GetFollowingResponse>(
          '/users.UserService/GetFollowing',
          ($0.GetFollowingRequest value) => value.writeToBuffer(),
          $0.GetFollowingResponse.fromBuffer);
  static final _$isFollowing =
      $grpc.ClientMethod<$0.IsFollowingRequest, $0.IsFollowingResponse>(
          '/users.UserService/IsFollowing',
          ($0.IsFollowingRequest value) => value.writeToBuffer(),
          $0.IsFollowingResponse.fromBuffer);
  static final _$getSuggestedFriends =
      $grpc.ClientMethod<$0.SuggestFriendsRequest, $0.SuggestFriendsResponse>(
          '/users.UserService/GetSuggestedFriends',
          ($0.SuggestFriendsRequest value) => value.writeToBuffer(),
          $0.SuggestFriendsResponse.fromBuffer);
}

@$pb.GrpcServiceName('users.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'users.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateUserRequest, $0.UserResponse>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateUserRequest.fromBuffer(value),
        ($0.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserByIdRequest, $0.UserResponse>(
        'GetUserById',
        getUserById_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserByIdRequest.fromBuffer(value),
        ($0.UserResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserByUsernameRequest, $0.UserResponse>(
            'GetUserByUsername',
            getUserByUsername_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserByUsernameRequest.fromBuffer(value),
            ($0.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateUserRequest, $0.UserResponse>(
        'UpdateUser',
        updateUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateUserRequest.fromBuffer(value),
        ($0.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteUserRequest, $0.DeleteUserResponse>(
        'DeleteUser',
        deleteUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteUserRequest.fromBuffer(value),
        ($0.DeleteUserResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchUsersRequest, $0.SearchUsersResponse>(
            'SearchUsers',
            searchUsers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SearchUsersRequest.fromBuffer(value),
            ($0.SearchUsersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CheckUsernameRequest, $0.CheckExistenceResponse>(
            'CheckUsername',
            checkUsername_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CheckUsernameRequest.fromBuffer(value),
            ($0.CheckExistenceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CheckEmailRequest, $0.CheckExistenceResponse>(
            'CheckEmail',
            checkEmail_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CheckEmailRequest.fromBuffer(value),
            ($0.CheckExistenceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CheckUserRequest, $0.CheckExistenceResponse>(
            'CheckUserExists',
            checkUserExists_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CheckUserRequest.fromBuffer(value),
            ($0.CheckExistenceResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserStatsRequest, $0.UserStatsResponse>(
            'GetUserStats',
            getUserStats_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserStatsRequest.fromBuffer(value),
            ($0.UserStatsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AddRecentSearchRequest, $0.StatusResponse>(
            'AddRecentSearch',
            addRecentSearch_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AddRecentSearchRequest.fromBuffer(value),
            ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecentSearchesRequest,
            $0.RecentSearchesResponse>(
        'GetRecentSearches',
        getRecentSearches_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecentSearchesRequest.fromBuffer(value),
        ($0.RecentSearchesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FollowUserRequest, $0.StatusResponse>(
        'FollowUser',
        followUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FollowUserRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnfollowUserRequest, $0.StatusResponse>(
        'UnfollowUser',
        unfollowUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnfollowUserRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetFollowersRequest, $0.GetFollowersResponse>(
            'GetFollowers',
            getFollowers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetFollowersRequest.fromBuffer(value),
            ($0.GetFollowersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetFollowingRequest, $0.GetFollowingResponse>(
            'GetFollowing',
            getFollowing_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetFollowingRequest.fromBuffer(value),
            ($0.GetFollowingResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.IsFollowingRequest, $0.IsFollowingResponse>(
            'IsFollowing',
            isFollowing_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.IsFollowingRequest.fromBuffer(value),
            ($0.IsFollowingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SuggestFriendsRequest,
            $0.SuggestFriendsResponse>(
        'GetSuggestedFriends',
        getSuggestedFriends_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SuggestFriendsRequest.fromBuffer(value),
        ($0.SuggestFriendsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.UserResponse> createUser_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateUserRequest> $request) async {
    return createUser($call, await $request);
  }

  $async.Future<$0.UserResponse> createUser(
      $grpc.ServiceCall call, $0.CreateUserRequest request);

  $async.Future<$0.UserResponse> getUserById_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetUserByIdRequest> $request) async {
    return getUserById($call, await $request);
  }

  $async.Future<$0.UserResponse> getUserById(
      $grpc.ServiceCall call, $0.GetUserByIdRequest request);

  $async.Future<$0.UserResponse> getUserByUsername_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetUserByUsernameRequest> $request) async {
    return getUserByUsername($call, await $request);
  }

  $async.Future<$0.UserResponse> getUserByUsername(
      $grpc.ServiceCall call, $0.GetUserByUsernameRequest request);

  $async.Future<$0.UserResponse> updateUser_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateUserRequest> $request) async {
    return updateUser($call, await $request);
  }

  $async.Future<$0.UserResponse> updateUser(
      $grpc.ServiceCall call, $0.UpdateUserRequest request);

  $async.Future<$0.DeleteUserResponse> deleteUser_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteUserRequest> $request) async {
    return deleteUser($call, await $request);
  }

  $async.Future<$0.DeleteUserResponse> deleteUser(
      $grpc.ServiceCall call, $0.DeleteUserRequest request);

  $async.Future<$0.SearchUsersResponse> searchUsers_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SearchUsersRequest> $request) async {
    return searchUsers($call, await $request);
  }

  $async.Future<$0.SearchUsersResponse> searchUsers(
      $grpc.ServiceCall call, $0.SearchUsersRequest request);

  $async.Future<$0.CheckExistenceResponse> checkUsername_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckUsernameRequest> $request) async {
    return checkUsername($call, await $request);
  }

  $async.Future<$0.CheckExistenceResponse> checkUsername(
      $grpc.ServiceCall call, $0.CheckUsernameRequest request);

  $async.Future<$0.CheckExistenceResponse> checkEmail_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckEmailRequest> $request) async {
    return checkEmail($call, await $request);
  }

  $async.Future<$0.CheckExistenceResponse> checkEmail(
      $grpc.ServiceCall call, $0.CheckEmailRequest request);

  $async.Future<$0.CheckExistenceResponse> checkUserExists_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckUserRequest> $request) async {
    return checkUserExists($call, await $request);
  }

  $async.Future<$0.CheckExistenceResponse> checkUserExists(
      $grpc.ServiceCall call, $0.CheckUserRequest request);

  $async.Future<$0.UserStatsResponse> getUserStats_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetUserStatsRequest> $request) async {
    return getUserStats($call, await $request);
  }

  $async.Future<$0.UserStatsResponse> getUserStats(
      $grpc.ServiceCall call, $0.GetUserStatsRequest request);

  $async.Future<$0.StatusResponse> addRecentSearch_Pre($grpc.ServiceCall $call,
      $async.Future<$0.AddRecentSearchRequest> $request) async {
    return addRecentSearch($call, await $request);
  }

  $async.Future<$0.StatusResponse> addRecentSearch(
      $grpc.ServiceCall call, $0.AddRecentSearchRequest request);

  $async.Future<$0.RecentSearchesResponse> getRecentSearches_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetRecentSearchesRequest> $request) async {
    return getRecentSearches($call, await $request);
  }

  $async.Future<$0.RecentSearchesResponse> getRecentSearches(
      $grpc.ServiceCall call, $0.GetRecentSearchesRequest request);

  $async.Future<$0.StatusResponse> followUser_Pre($grpc.ServiceCall $call,
      $async.Future<$0.FollowUserRequest> $request) async {
    return followUser($call, await $request);
  }

  $async.Future<$0.StatusResponse> followUser(
      $grpc.ServiceCall call, $0.FollowUserRequest request);

  $async.Future<$0.StatusResponse> unfollowUser_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UnfollowUserRequest> $request) async {
    return unfollowUser($call, await $request);
  }

  $async.Future<$0.StatusResponse> unfollowUser(
      $grpc.ServiceCall call, $0.UnfollowUserRequest request);

  $async.Future<$0.GetFollowersResponse> getFollowers_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFollowersRequest> $request) async {
    return getFollowers($call, await $request);
  }

  $async.Future<$0.GetFollowersResponse> getFollowers(
      $grpc.ServiceCall call, $0.GetFollowersRequest request);

  $async.Future<$0.GetFollowingResponse> getFollowing_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFollowingRequest> $request) async {
    return getFollowing($call, await $request);
  }

  $async.Future<$0.GetFollowingResponse> getFollowing(
      $grpc.ServiceCall call, $0.GetFollowingRequest request);

  $async.Future<$0.IsFollowingResponse> isFollowing_Pre($grpc.ServiceCall $call,
      $async.Future<$0.IsFollowingRequest> $request) async {
    return isFollowing($call, await $request);
  }

  $async.Future<$0.IsFollowingResponse> isFollowing(
      $grpc.ServiceCall call, $0.IsFollowingRequest request);

  $async.Future<$0.SuggestFriendsResponse> getSuggestedFriends_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SuggestFriendsRequest> $request) async {
    return getSuggestedFriends($call, await $request);
  }

  $async.Future<$0.SuggestFriendsResponse> getSuggestedFriends(
      $grpc.ServiceCall call, $0.SuggestFriendsRequest request);
}
