//
//  Generated code. Do not modify.
//  source: protobuf/user.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $7;

export 'user.pb.dart';

@$pb.GrpcServiceName('ListeningParty.UserService')
class UserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$getUser = $grpc.ClientMethod<$7.GetUserRequest, $7.User>(
      '/ListeningParty.UserService/GetUser',
      ($7.GetUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.User.fromBuffer(value));

  UserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$7.User> getUser($7.GetUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUser, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.GetUserRequest, $7.User>(
        'GetUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetUserRequest.fromBuffer(value),
        ($7.User value) => value.writeToBuffer()));
  }

  $async.Future<$7.User> getUser_Pre($grpc.ServiceCall $call, $async.Future<$7.GetUserRequest> $request) async {
    return getUser($call, await $request);
  }

  $async.Future<$7.User> getUser($grpc.ServiceCall call, $7.GetUserRequest request);
}
