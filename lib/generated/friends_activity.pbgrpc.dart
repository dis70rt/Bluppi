// This is a generated file - do not edit.
//
// Generated from friends_activity.proto.

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

import 'friends_activity.pb.dart' as $0;

export 'friends_activity.pb.dart';

@$pb.GrpcServiceName('friends_activity.FriendsActivityService')
class FriendsActivityServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  FriendsActivityServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetFriendsFeedResponse> getFriendsFeed(
    $0.GetFriendsFeedRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFriendsFeed, request, options: options);
  }

  // method descriptors

  static final _$getFriendsFeed =
      $grpc.ClientMethod<$0.GetFriendsFeedRequest, $0.GetFriendsFeedResponse>(
          '/friends_activity.FriendsActivityService/GetFriendsFeed',
          ($0.GetFriendsFeedRequest value) => value.writeToBuffer(),
          $0.GetFriendsFeedResponse.fromBuffer);
}

@$pb.GrpcServiceName('friends_activity.FriendsActivityService')
abstract class FriendsActivityServiceBase extends $grpc.Service {
  $core.String get $name => 'friends_activity.FriendsActivityService';

  FriendsActivityServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetFriendsFeedRequest,
            $0.GetFriendsFeedResponse>(
        'GetFriendsFeed',
        getFriendsFeed_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFriendsFeedRequest.fromBuffer(value),
        ($0.GetFriendsFeedResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetFriendsFeedResponse> getFriendsFeed_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetFriendsFeedRequest> $request) async {
    return getFriendsFeed($call, await $request);
  }

  $async.Future<$0.GetFriendsFeedResponse> getFriendsFeed(
      $grpc.ServiceCall call, $0.GetFriendsFeedRequest request);
}
