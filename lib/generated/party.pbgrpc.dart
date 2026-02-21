// This is a generated file - do not edit.
//
// Generated from party.proto.

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

import 'party.pb.dart' as $0;

export 'party.pb.dart';

/// Service
@$pb.GrpcServiceName('ListeningParty.SyncService')
class SyncServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SyncServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.SyncResponse> clockSync(
    $0.SyncRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$clockSync, request, options: options);
  }

  // method descriptors

  static final _$clockSync =
      $grpc.ClientMethod<$0.SyncRequest, $0.SyncResponse>(
          '/ListeningParty.SyncService/ClockSync',
          ($0.SyncRequest value) => value.writeToBuffer(),
          $0.SyncResponse.fromBuffer);
}

@$pb.GrpcServiceName('ListeningParty.SyncService')
abstract class SyncServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.SyncService';

  SyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SyncRequest, $0.SyncResponse>(
        'ClockSync',
        clockSync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SyncRequest.fromBuffer(value),
        ($0.SyncResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SyncResponse> clockSync_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SyncRequest> $request) async {
    return clockSync($call, await $request);
  }

  $async.Future<$0.SyncResponse> clockSync(
      $grpc.ServiceCall call, $0.SyncRequest request);
}
