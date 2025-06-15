//
//  Generated code. Do not modify.
//  source: protobuf/track.proto
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

import 'track.pb.dart' as $6;

export 'track.pb.dart';

@$pb.GrpcServiceName('ListeningParty.TrackService')
class TrackServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$getTrack = $grpc.ClientMethod<$6.GetTrackRequest, $6.Track>(
      '/ListeningParty.TrackService/GetTrack',
      ($6.GetTrackRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.Track.fromBuffer(value));
  static final _$searchTracks = $grpc.ClientMethod<$6.SearchTracksRequest, $6.SearchTracksResponse>(
      '/ListeningParty.TrackService/SearchTracks',
      ($6.SearchTracksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.SearchTracksResponse.fromBuffer(value));

  TrackServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$6.Track> getTrack($6.GetTrackRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTrack, request, options: options);
  }

  $grpc.ResponseFuture<$6.SearchTracksResponse> searchTracks($6.SearchTracksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchTracks, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.TrackService')
abstract class TrackServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.TrackService';

  TrackServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.GetTrackRequest, $6.Track>(
        'GetTrack',
        getTrack_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.GetTrackRequest.fromBuffer(value),
        ($6.Track value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.SearchTracksRequest, $6.SearchTracksResponse>(
        'SearchTracks',
        searchTracks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.SearchTracksRequest.fromBuffer(value),
        ($6.SearchTracksResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.Track> getTrack_Pre($grpc.ServiceCall $call, $async.Future<$6.GetTrackRequest> $request) async {
    return getTrack($call, await $request);
  }

  $async.Future<$6.SearchTracksResponse> searchTracks_Pre($grpc.ServiceCall $call, $async.Future<$6.SearchTracksRequest> $request) async {
    return searchTracks($call, await $request);
  }

  $async.Future<$6.Track> getTrack($grpc.ServiceCall call, $6.GetTrackRequest request);
  $async.Future<$6.SearchTracksResponse> searchTracks($grpc.ServiceCall call, $6.SearchTracksRequest request);
}
