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

@$pb.GrpcServiceName('ListeningParty.RoomStreamService')
class RoomStreamServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$joinRoomStream = $grpc.ClientMethod<$5.JoinRoomStreamRequest, $5.RoomStreamSnapshot>(
      '/ListeningParty.RoomStreamService/JoinRoomStream',
      ($5.JoinRoomStreamRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.RoomStreamSnapshot.fromBuffer(value));
  static final _$streamRoomUpdates = $grpc.ClientMethod<$5.StreamRoomUpdatesRequest, $5.RoomStreamUpdate>(
      '/ListeningParty.RoomStreamService/StreamRoomUpdates',
      ($5.StreamRoomUpdatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.RoomStreamUpdate.fromBuffer(value));

  RoomStreamServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$5.RoomStreamSnapshot> joinRoomStream($5.JoinRoomStreamRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$joinRoomStream, request, options: options);
  }

  $grpc.ResponseStream<$5.RoomStreamUpdate> streamRoomUpdates($5.StreamRoomUpdatesRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamRoomUpdates, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.RoomStreamService')
abstract class RoomStreamServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.RoomStreamService';

  RoomStreamServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.JoinRoomStreamRequest, $5.RoomStreamSnapshot>(
        'JoinRoomStream',
        joinRoomStream_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.JoinRoomStreamRequest.fromBuffer(value),
        ($5.RoomStreamSnapshot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.StreamRoomUpdatesRequest, $5.RoomStreamUpdate>(
        'StreamRoomUpdates',
        streamRoomUpdates_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $5.StreamRoomUpdatesRequest.fromBuffer(value),
        ($5.RoomStreamUpdate value) => value.writeToBuffer()));
  }

  $async.Future<$5.RoomStreamSnapshot> joinRoomStream_Pre($grpc.ServiceCall $call, $async.Future<$5.JoinRoomStreamRequest> $request) async {
    return joinRoomStream($call, await $request);
  }

  $async.Stream<$5.RoomStreamUpdate> streamRoomUpdates_Pre($grpc.ServiceCall $call, $async.Future<$5.StreamRoomUpdatesRequest> $request) async* {
    yield* streamRoomUpdates($call, await $request);
  }

  $async.Future<$5.RoomStreamSnapshot> joinRoomStream($grpc.ServiceCall call, $5.JoinRoomStreamRequest request);
  $async.Stream<$5.RoomStreamUpdate> streamRoomUpdates($grpc.ServiceCall call, $5.StreamRoomUpdatesRequest request);
}
