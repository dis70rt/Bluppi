// This is a generated file - do not edit.
//
// Generated from presences.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $1;

import 'presences.pb.dart' as $0;

export 'presences.pb.dart';

@$pb.GrpcServiceName('presences.PresenceGateway')
class PresenceGatewayClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  PresenceGatewayClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$0.PresenceUpdate> subscribePresence(
    $0.SubscribeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$subscribePresence, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$subscribePresence =
      $grpc.ClientMethod<$0.SubscribeRequest, $0.PresenceUpdate>(
          '/presences.PresenceGateway/SubscribePresence',
          ($0.SubscribeRequest value) => value.writeToBuffer(),
          $0.PresenceUpdate.fromBuffer);
}

@$pb.GrpcServiceName('presences.PresenceGateway')
abstract class PresenceGatewayServiceBase extends $grpc.Service {
  $core.String get $name => 'presences.PresenceGateway';

  PresenceGatewayServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SubscribeRequest, $0.PresenceUpdate>(
        'SubscribePresence',
        subscribePresence_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SubscribeRequest.fromBuffer(value),
        ($0.PresenceUpdate value) => value.writeToBuffer()));
  }

  $async.Stream<$0.PresenceUpdate> subscribePresence_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SubscribeRequest> $request) async* {
    yield* subscribePresence($call, await $request);
  }

  $async.Stream<$0.PresenceUpdate> subscribePresence(
      $grpc.ServiceCall call, $0.SubscribeRequest request);
}

@$pb.GrpcServiceName('presences.InternalPresence')
class InternalPresenceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  InternalPresenceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> recordHeartbeat(
    $0.HeartBeatRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$recordHeartbeat, request, options: options);
  }

  // method descriptors

  static final _$recordHeartbeat =
      $grpc.ClientMethod<$0.HeartBeatRequest, $1.Empty>(
          '/presences.InternalPresence/RecordHeartbeat',
          ($0.HeartBeatRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('presences.InternalPresence')
abstract class InternalPresenceServiceBase extends $grpc.Service {
  $core.String get $name => 'presences.InternalPresence';

  InternalPresenceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HeartBeatRequest, $1.Empty>(
        'RecordHeartbeat',
        recordHeartbeat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HeartBeatRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> recordHeartbeat_Pre($grpc.ServiceCall $call,
      $async.Future<$0.HeartBeatRequest> $request) async {
    return recordHeartbeat($call, await $request);
  }

  $async.Future<$1.Empty> recordHeartbeat(
      $grpc.ServiceCall call, $0.HeartBeatRequest request);
}
