//
//  Generated code. Do not modify.
//  source: protobuf/streaming.proto
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

import 'streaming.pb.dart' as $5;

export 'streaming.pb.dart';

@$pb.GrpcServiceName('ListeningParty.SyncService')
class SyncServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$sendHostCommand = $grpc.ClientMethod<$5.HostCommand, $5.ServerResponse>(
      '/ListeningParty.SyncService/SendHostCommand',
      ($5.HostCommand value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.ServerResponse.fromBuffer(value));
  static final _$timingSync = $grpc.ClientMethod<$5.SyncRequest, $5.SyncReply>(
      '/ListeningParty.SyncService/TimingSync',
      ($5.SyncRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.SyncReply.fromBuffer(value));
  static final _$memberSync = $grpc.ClientMethod<$5.MemberStatus, $5.ServerBroadcast>(
      '/ListeningParty.SyncService/MemberSync',
      ($5.MemberStatus value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.ServerBroadcast.fromBuffer(value));

  SyncServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$5.ServerResponse> sendHostCommand($async.Stream<$5.HostCommand> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendHostCommand, request, options: options);
  }

  $grpc.ResponseFuture<$5.SyncReply> timingSync($5.SyncRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$timingSync, request, options: options);
  }

  $grpc.ResponseStream<$5.ServerBroadcast> memberSync($async.Stream<$5.MemberStatus> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$memberSync, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.SyncService')
abstract class SyncServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.SyncService';

  SyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.HostCommand, $5.ServerResponse>(
        'SendHostCommand',
        sendHostCommand,
        true,
        true,
        ($core.List<$core.int> value) => $5.HostCommand.fromBuffer(value),
        ($5.ServerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SyncRequest, $5.SyncReply>(
        'TimingSync',
        timingSync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SyncRequest.fromBuffer(value),
        ($5.SyncReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MemberStatus, $5.ServerBroadcast>(
        'MemberSync',
        memberSync,
        true,
        true,
        ($core.List<$core.int> value) => $5.MemberStatus.fromBuffer(value),
        ($5.ServerBroadcast value) => value.writeToBuffer()));
  }

  $async.Future<$5.SyncReply> timingSync_Pre($grpc.ServiceCall $call, $async.Future<$5.SyncRequest> $request) async {
    return timingSync($call, await $request);
  }

  $async.Stream<$5.ServerResponse> sendHostCommand($grpc.ServiceCall call, $async.Stream<$5.HostCommand> request);
  $async.Future<$5.SyncReply> timingSync($grpc.ServiceCall call, $5.SyncRequest request);
  $async.Stream<$5.ServerBroadcast> memberSync($grpc.ServiceCall call, $async.Stream<$5.MemberStatus> request);
}
