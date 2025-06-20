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

  static final _$measureTiming = $grpc.ClientMethod<$5.SyncMeasurement, $5.SyncResponse>(
      '/ListeningParty.SyncService/MeasureTiming',
      ($5.SyncMeasurement value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.SyncResponse.fromBuffer(value));
  static final _$bidirectionalSync = $grpc.ClientMethod<$5.ClientState, $5.PlaybackCommand>(
      '/ListeningParty.SyncService/BidirectionalSync',
      ($5.ClientState value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.PlaybackCommand.fromBuffer(value));

  SyncServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$5.SyncResponse> measureTiming($5.SyncMeasurement request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$measureTiming, request, options: options);
  }

  $grpc.ResponseStream<$5.PlaybackCommand> bidirectionalSync($async.Stream<$5.ClientState> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$bidirectionalSync, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.SyncService')
abstract class SyncServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.SyncService';

  SyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.SyncMeasurement, $5.SyncResponse>(
        'MeasureTiming',
        measureTiming_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SyncMeasurement.fromBuffer(value),
        ($5.SyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.ClientState, $5.PlaybackCommand>(
        'BidirectionalSync',
        bidirectionalSync,
        true,
        true,
        ($core.List<$core.int> value) => $5.ClientState.fromBuffer(value),
        ($5.PlaybackCommand value) => value.writeToBuffer()));
  }

  $async.Future<$5.SyncResponse> measureTiming_Pre($grpc.ServiceCall $call, $async.Future<$5.SyncMeasurement> $request) async {
    return measureTiming($call, await $request);
  }

  $async.Future<$5.SyncResponse> measureTiming($grpc.ServiceCall call, $5.SyncMeasurement request);
  $async.Stream<$5.PlaybackCommand> bidirectionalSync($grpc.ServiceCall call, $async.Stream<$5.ClientState> request);
}
