//
//  Generated code. Do not modify.
//  source: protobuf/events.proto
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

import 'events.pb.dart' as $0;

export 'events.pb.dart';

@$pb.GrpcServiceName('ListeningParty.EventStreamService')
class EventStreamServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$streamRoomEvents = $grpc.ClientMethod<$0.StreamRoomEventsRequest, $0.RoomEvent>(
      '/ListeningParty.EventStreamService/StreamRoomEvents',
      ($0.StreamRoomEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RoomEvent.fromBuffer(value));
  static final _$streamPlaybackEvents = $grpc.ClientMethod<$0.StreamPlaybackEventsRequest, $0.PlaybackEvent>(
      '/ListeningParty.EventStreamService/StreamPlaybackEvents',
      ($0.StreamPlaybackEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PlaybackEvent.fromBuffer(value));

  EventStreamServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseStream<$0.RoomEvent> streamRoomEvents($0.StreamRoomEventsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamRoomEvents, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$0.PlaybackEvent> streamPlaybackEvents($0.StreamPlaybackEventsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamPlaybackEvents, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.EventStreamService')
abstract class EventStreamServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.EventStreamService';

  EventStreamServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StreamRoomEventsRequest, $0.RoomEvent>(
        'StreamRoomEvents',
        streamRoomEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StreamRoomEventsRequest.fromBuffer(value),
        ($0.RoomEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StreamPlaybackEventsRequest, $0.PlaybackEvent>(
        'StreamPlaybackEvents',
        streamPlaybackEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StreamPlaybackEventsRequest.fromBuffer(value),
        ($0.PlaybackEvent value) => value.writeToBuffer()));
  }

  $async.Stream<$0.RoomEvent> streamRoomEvents_Pre($grpc.ServiceCall $call, $async.Future<$0.StreamRoomEventsRequest> $request) async* {
    yield* streamRoomEvents($call, await $request);
  }

  $async.Stream<$0.PlaybackEvent> streamPlaybackEvents_Pre($grpc.ServiceCall $call, $async.Future<$0.StreamPlaybackEventsRequest> $request) async* {
    yield* streamPlaybackEvents($call, await $request);
  }

  $async.Stream<$0.RoomEvent> streamRoomEvents($grpc.ServiceCall call, $0.StreamRoomEventsRequest request);
  $async.Stream<$0.PlaybackEvent> streamPlaybackEvents($grpc.ServiceCall call, $0.StreamPlaybackEventsRequest request);
}
@$pb.GrpcServiceName('ListeningParty.EventLogService')
class EventLogServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$logEvent = $grpc.ClientMethod<$0.LogEventRequest, $0.PlaybackEventLog>(
      '/ListeningParty.EventLogService/LogEvent',
      ($0.LogEventRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PlaybackEventLog.fromBuffer(value));
  static final _$getEventHistory = $grpc.ClientMethod<$0.GetEventHistoryRequest, $0.GetEventHistoryResponse>(
      '/ListeningParty.EventLogService/GetEventHistory',
      ($0.GetEventHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetEventHistoryResponse.fromBuffer(value));

  EventLogServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.PlaybackEventLog> logEvent($0.LogEventRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$logEvent, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetEventHistoryResponse> getEventHistory($0.GetEventHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEventHistory, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.EventLogService')
abstract class EventLogServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.EventLogService';

  EventLogServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LogEventRequest, $0.PlaybackEventLog>(
        'LogEvent',
        logEvent_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LogEventRequest.fromBuffer(value),
        ($0.PlaybackEventLog value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetEventHistoryRequest, $0.GetEventHistoryResponse>(
        'GetEventHistory',
        getEventHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetEventHistoryRequest.fromBuffer(value),
        ($0.GetEventHistoryResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PlaybackEventLog> logEvent_Pre($grpc.ServiceCall $call, $async.Future<$0.LogEventRequest> $request) async {
    return logEvent($call, await $request);
  }

  $async.Future<$0.GetEventHistoryResponse> getEventHistory_Pre($grpc.ServiceCall $call, $async.Future<$0.GetEventHistoryRequest> $request) async {
    return getEventHistory($call, await $request);
  }

  $async.Future<$0.PlaybackEventLog> logEvent($grpc.ServiceCall call, $0.LogEventRequest request);
  $async.Future<$0.GetEventHistoryResponse> getEventHistory($grpc.ServiceCall call, $0.GetEventHistoryRequest request);
}
