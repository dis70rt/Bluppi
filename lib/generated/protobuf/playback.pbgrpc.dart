//
//  Generated code. Do not modify.
//  source: protobuf/playback.proto
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

import 'playback.pb.dart' as $1;

export 'playback.pb.dart';

@$pb.GrpcServiceName('ListeningParty.PlaybackService')
class PlaybackServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$play = $grpc.ClientMethod<$1.PlayRequest, $1.PlaybackState>(
      '/ListeningParty.PlaybackService/Play',
      ($1.PlayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PlaybackState.fromBuffer(value));
  static final _$pause = $grpc.ClientMethod<$1.PauseRequest, $1.PlaybackState>(
      '/ListeningParty.PlaybackService/Pause',
      ($1.PauseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PlaybackState.fromBuffer(value));
  static final _$seek = $grpc.ClientMethod<$1.SeekRequest, $1.PlaybackState>(
      '/ListeningParty.PlaybackService/Seek',
      ($1.SeekRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PlaybackState.fromBuffer(value));
  static final _$skip = $grpc.ClientMethod<$1.SkipRequest, $1.PlaybackState>(
      '/ListeningParty.PlaybackService/Skip',
      ($1.SkipRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PlaybackState.fromBuffer(value));
  static final _$getPlaybackState = $grpc.ClientMethod<$1.GetPlaybackStateRequest, $1.PlaybackState>(
      '/ListeningParty.PlaybackService/GetPlaybackState',
      ($1.GetPlaybackStateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PlaybackState.fromBuffer(value));
  static final _$syncPlayback = $grpc.ClientMethod<$1.SyncPlaybackRequest, $1.PlaybackState>(
      '/ListeningParty.PlaybackService/SyncPlayback',
      ($1.SyncPlaybackRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PlaybackState.fromBuffer(value));

  PlaybackServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.PlaybackState> play($1.PlayRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$play, request, options: options);
  }

  $grpc.ResponseFuture<$1.PlaybackState> pause($1.PauseRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pause, request, options: options);
  }

  $grpc.ResponseFuture<$1.PlaybackState> seek($1.SeekRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$seek, request, options: options);
  }

  $grpc.ResponseFuture<$1.PlaybackState> skip($1.SkipRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$skip, request, options: options);
  }

  $grpc.ResponseFuture<$1.PlaybackState> getPlaybackState($1.GetPlaybackStateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlaybackState, request, options: options);
  }

  $grpc.ResponseFuture<$1.PlaybackState> syncPlayback($1.SyncPlaybackRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncPlayback, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.PlaybackService')
abstract class PlaybackServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.PlaybackService';

  PlaybackServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.PlayRequest, $1.PlaybackState>(
        'Play',
        play_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PlayRequest.fromBuffer(value),
        ($1.PlaybackState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PauseRequest, $1.PlaybackState>(
        'Pause',
        pause_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PauseRequest.fromBuffer(value),
        ($1.PlaybackState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SeekRequest, $1.PlaybackState>(
        'Seek',
        seek_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SeekRequest.fromBuffer(value),
        ($1.PlaybackState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SkipRequest, $1.PlaybackState>(
        'Skip',
        skip_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SkipRequest.fromBuffer(value),
        ($1.PlaybackState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetPlaybackStateRequest, $1.PlaybackState>(
        'GetPlaybackState',
        getPlaybackState_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetPlaybackStateRequest.fromBuffer(value),
        ($1.PlaybackState value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SyncPlaybackRequest, $1.PlaybackState>(
        'SyncPlayback',
        syncPlayback_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SyncPlaybackRequest.fromBuffer(value),
        ($1.PlaybackState value) => value.writeToBuffer()));
  }

  $async.Future<$1.PlaybackState> play_Pre($grpc.ServiceCall $call, $async.Future<$1.PlayRequest> $request) async {
    return play($call, await $request);
  }

  $async.Future<$1.PlaybackState> pause_Pre($grpc.ServiceCall $call, $async.Future<$1.PauseRequest> $request) async {
    return pause($call, await $request);
  }

  $async.Future<$1.PlaybackState> seek_Pre($grpc.ServiceCall $call, $async.Future<$1.SeekRequest> $request) async {
    return seek($call, await $request);
  }

  $async.Future<$1.PlaybackState> skip_Pre($grpc.ServiceCall $call, $async.Future<$1.SkipRequest> $request) async {
    return skip($call, await $request);
  }

  $async.Future<$1.PlaybackState> getPlaybackState_Pre($grpc.ServiceCall $call, $async.Future<$1.GetPlaybackStateRequest> $request) async {
    return getPlaybackState($call, await $request);
  }

  $async.Future<$1.PlaybackState> syncPlayback_Pre($grpc.ServiceCall $call, $async.Future<$1.SyncPlaybackRequest> $request) async {
    return syncPlayback($call, await $request);
  }

  $async.Future<$1.PlaybackState> play($grpc.ServiceCall call, $1.PlayRequest request);
  $async.Future<$1.PlaybackState> pause($grpc.ServiceCall call, $1.PauseRequest request);
  $async.Future<$1.PlaybackState> seek($grpc.ServiceCall call, $1.SeekRequest request);
  $async.Future<$1.PlaybackState> skip($grpc.ServiceCall call, $1.SkipRequest request);
  $async.Future<$1.PlaybackState> getPlaybackState($grpc.ServiceCall call, $1.GetPlaybackStateRequest request);
  $async.Future<$1.PlaybackState> syncPlayback($grpc.ServiceCall call, $1.SyncPlaybackRequest request);
}
