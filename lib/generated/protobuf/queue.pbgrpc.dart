//
//  Generated code. Do not modify.
//  source: protobuf/queue.proto
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

import '../google/protobuf/empty.pb.dart' as $3;
import 'queue.pb.dart' as $2;

export 'queue.pb.dart';

@$pb.GrpcServiceName('ListeningParty.QueueService')
class QueueServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$addToQueue = $grpc.ClientMethod<$2.AddToQueueRequest, $2.RoomQueueItem>(
      '/ListeningParty.QueueService/AddToQueue',
      ($2.AddToQueueRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.RoomQueueItem.fromBuffer(value));
  static final _$removeFromQueue = $grpc.ClientMethod<$2.RemoveFromQueueRequest, $3.Empty>(
      '/ListeningParty.QueueService/RemoveFromQueue',
      ($2.RemoveFromQueueRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Empty.fromBuffer(value));
  static final _$getQueue = $grpc.ClientMethod<$2.GetQueueRequest, $2.GetQueueResponse>(
      '/ListeningParty.QueueService/GetQueue',
      ($2.GetQueueRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetQueueResponse.fromBuffer(value));
  static final _$clearQueue = $grpc.ClientMethod<$2.ClearQueueRequest, $3.Empty>(
      '/ListeningParty.QueueService/ClearQueue',
      ($2.ClearQueueRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Empty.fromBuffer(value));

  QueueServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$2.RoomQueueItem> addToQueue($2.AddToQueueRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addToQueue, request, options: options);
  }

  $grpc.ResponseFuture<$3.Empty> removeFromQueue($2.RemoveFromQueueRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeFromQueue, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetQueueResponse> getQueue($2.GetQueueRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQueue, request, options: options);
  }

  $grpc.ResponseFuture<$3.Empty> clearQueue($2.ClearQueueRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$clearQueue, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.QueueService')
abstract class QueueServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.QueueService';

  QueueServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.AddToQueueRequest, $2.RoomQueueItem>(
        'AddToQueue',
        addToQueue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AddToQueueRequest.fromBuffer(value),
        ($2.RoomQueueItem value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.RemoveFromQueueRequest, $3.Empty>(
        'RemoveFromQueue',
        removeFromQueue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.RemoveFromQueueRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetQueueRequest, $2.GetQueueResponse>(
        'GetQueue',
        getQueue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetQueueRequest.fromBuffer(value),
        ($2.GetQueueResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ClearQueueRequest, $3.Empty>(
        'ClearQueue',
        clearQueue_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ClearQueueRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$2.RoomQueueItem> addToQueue_Pre($grpc.ServiceCall $call, $async.Future<$2.AddToQueueRequest> $request) async {
    return addToQueue($call, await $request);
  }

  $async.Future<$3.Empty> removeFromQueue_Pre($grpc.ServiceCall $call, $async.Future<$2.RemoveFromQueueRequest> $request) async {
    return removeFromQueue($call, await $request);
  }

  $async.Future<$2.GetQueueResponse> getQueue_Pre($grpc.ServiceCall $call, $async.Future<$2.GetQueueRequest> $request) async {
    return getQueue($call, await $request);
  }

  $async.Future<$3.Empty> clearQueue_Pre($grpc.ServiceCall $call, $async.Future<$2.ClearQueueRequest> $request) async {
    return clearQueue($call, await $request);
  }

  $async.Future<$2.RoomQueueItem> addToQueue($grpc.ServiceCall call, $2.AddToQueueRequest request);
  $async.Future<$3.Empty> removeFromQueue($grpc.ServiceCall call, $2.RemoveFromQueueRequest request);
  $async.Future<$2.GetQueueResponse> getQueue($grpc.ServiceCall call, $2.GetQueueRequest request);
  $async.Future<$3.Empty> clearQueue($grpc.ServiceCall call, $2.ClearQueueRequest request);
}
