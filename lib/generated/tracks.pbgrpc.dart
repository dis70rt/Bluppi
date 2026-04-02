// This is a generated file - do not edit.
//
// Generated from tracks.proto.

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

import 'tracks.pb.dart' as $0;

export 'tracks.pb.dart';

@$pb.GrpcServiceName('tracks.TrackService')
class TrackServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TrackServiceClient(super.channel, {super.options, super.interceptors});

  /// --- Core Track CRUD ---
  $grpc.ResponseFuture<$0.TrackResponse> getTrack(
    $0.GetTrackRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTrack, request, options: options);
  }

  /// --- Search & Discovery ---
  $grpc.ResponseFuture<$0.SearchTracksResponse> searchTracks(
    $0.SearchTracksRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchTracks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTracksResponse> getPopularTracks(
    $0.GetPopularTracksRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPopularTracks, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTracksResponse> getTracksByGenre(
    $0.GetTracksByGenreRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTracksByGenre, request, options: options);
  }

  /// --- User Track Interactions ---
  $grpc.ResponseFuture<$0.StatusResponse> likeTrack(
    $0.LikeTrackRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$likeTrack, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> unlikeTrack(
    $0.UnlikeTrackRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unlikeTrack, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLikedTracksResponse> getLikedTracks(
    $0.GetLikedTracksRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getLikedTracks, request, options: options);
  }

  $grpc.ResponseFuture<$0.IsTrackLikedResponse> isTrackLiked(
    $0.IsTrackLikedRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$isTrackLiked, request, options: options);
  }

  /// --- Track History ---
  $grpc.ResponseFuture<$0.StatusResponse> addTrackToHistory(
    $0.AddTrackToHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addTrackToHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTrackHistoryResponse> getTrackHistory(
    $0.GetTrackHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTrackHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.StatusResponse> clearTrackHistory(
    $0.ClearTrackHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$clearTrackHistory, request, options: options);
  }

  /// --- Recommendations ---
  $grpc.ResponseFuture<$0.GetRecommendationsResponse> getRecommendations(
    $0.GetRecommendationsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRecommendations, request, options: options);
  }

  $grpc.ResponseFuture<$0.DiscoverTracksResponse> weeklyDiscoverTracks(
    $0.DiscoverTracksRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$weeklyDiscoverTracks, request, options: options);
  }

  /// --- Top Tracks (Profile) ---
  $grpc.ResponseFuture<$0.GetUserTopTracksResponse> getUserTopTracks(
    $0.GetUserTopTracksRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserTopTracks, request, options: options);
  }

  // method descriptors

  static final _$getTrack =
      $grpc.ClientMethod<$0.GetTrackRequest, $0.TrackResponse>(
          '/tracks.TrackService/GetTrack',
          ($0.GetTrackRequest value) => value.writeToBuffer(),
          $0.TrackResponse.fromBuffer);
  static final _$searchTracks =
      $grpc.ClientMethod<$0.SearchTracksRequest, $0.SearchTracksResponse>(
          '/tracks.TrackService/SearchTracks',
          ($0.SearchTracksRequest value) => value.writeToBuffer(),
          $0.SearchTracksResponse.fromBuffer);
  static final _$getPopularTracks =
      $grpc.ClientMethod<$0.GetPopularTracksRequest, $0.GetTracksResponse>(
          '/tracks.TrackService/GetPopularTracks',
          ($0.GetPopularTracksRequest value) => value.writeToBuffer(),
          $0.GetTracksResponse.fromBuffer);
  static final _$getTracksByGenre =
      $grpc.ClientMethod<$0.GetTracksByGenreRequest, $0.GetTracksResponse>(
          '/tracks.TrackService/GetTracksByGenre',
          ($0.GetTracksByGenreRequest value) => value.writeToBuffer(),
          $0.GetTracksResponse.fromBuffer);
  static final _$likeTrack =
      $grpc.ClientMethod<$0.LikeTrackRequest, $0.StatusResponse>(
          '/tracks.TrackService/LikeTrack',
          ($0.LikeTrackRequest value) => value.writeToBuffer(),
          $0.StatusResponse.fromBuffer);
  static final _$unlikeTrack =
      $grpc.ClientMethod<$0.UnlikeTrackRequest, $0.StatusResponse>(
          '/tracks.TrackService/UnlikeTrack',
          ($0.UnlikeTrackRequest value) => value.writeToBuffer(),
          $0.StatusResponse.fromBuffer);
  static final _$getLikedTracks =
      $grpc.ClientMethod<$0.GetLikedTracksRequest, $0.GetLikedTracksResponse>(
          '/tracks.TrackService/GetLikedTracks',
          ($0.GetLikedTracksRequest value) => value.writeToBuffer(),
          $0.GetLikedTracksResponse.fromBuffer);
  static final _$isTrackLiked =
      $grpc.ClientMethod<$0.IsTrackLikedRequest, $0.IsTrackLikedResponse>(
          '/tracks.TrackService/IsTrackLiked',
          ($0.IsTrackLikedRequest value) => value.writeToBuffer(),
          $0.IsTrackLikedResponse.fromBuffer);
  static final _$addTrackToHistory =
      $grpc.ClientMethod<$0.AddTrackToHistoryRequest, $0.StatusResponse>(
          '/tracks.TrackService/AddTrackToHistory',
          ($0.AddTrackToHistoryRequest value) => value.writeToBuffer(),
          $0.StatusResponse.fromBuffer);
  static final _$getTrackHistory =
      $grpc.ClientMethod<$0.GetTrackHistoryRequest, $0.GetTrackHistoryResponse>(
          '/tracks.TrackService/GetTrackHistory',
          ($0.GetTrackHistoryRequest value) => value.writeToBuffer(),
          $0.GetTrackHistoryResponse.fromBuffer);
  static final _$clearTrackHistory =
      $grpc.ClientMethod<$0.ClearTrackHistoryRequest, $0.StatusResponse>(
          '/tracks.TrackService/ClearTrackHistory',
          ($0.ClearTrackHistoryRequest value) => value.writeToBuffer(),
          $0.StatusResponse.fromBuffer);
  static final _$getRecommendations = $grpc.ClientMethod<
          $0.GetRecommendationsRequest, $0.GetRecommendationsResponse>(
      '/tracks.TrackService/GetRecommendations',
      ($0.GetRecommendationsRequest value) => value.writeToBuffer(),
      $0.GetRecommendationsResponse.fromBuffer);
  static final _$weeklyDiscoverTracks =
      $grpc.ClientMethod<$0.DiscoverTracksRequest, $0.DiscoverTracksResponse>(
          '/tracks.TrackService/WeeklyDiscoverTracks',
          ($0.DiscoverTracksRequest value) => value.writeToBuffer(),
          $0.DiscoverTracksResponse.fromBuffer);
  static final _$getUserTopTracks = $grpc.ClientMethod<
          $0.GetUserTopTracksRequest, $0.GetUserTopTracksResponse>(
      '/tracks.TrackService/GetUserTopTracks',
      ($0.GetUserTopTracksRequest value) => value.writeToBuffer(),
      $0.GetUserTopTracksResponse.fromBuffer);
}

@$pb.GrpcServiceName('tracks.TrackService')
abstract class TrackServiceBase extends $grpc.Service {
  $core.String get $name => 'tracks.TrackService';

  TrackServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetTrackRequest, $0.TrackResponse>(
        'GetTrack',
        getTrack_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTrackRequest.fromBuffer(value),
        ($0.TrackResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchTracksRequest, $0.SearchTracksResponse>(
            'SearchTracks',
            searchTracks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SearchTracksRequest.fromBuffer(value),
            ($0.SearchTracksResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetPopularTracksRequest, $0.GetTracksResponse>(
            'GetPopularTracks',
            getPopularTracks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetPopularTracksRequest.fromBuffer(value),
            ($0.GetTracksResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetTracksByGenreRequest, $0.GetTracksResponse>(
            'GetTracksByGenre',
            getTracksByGenre_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetTracksByGenreRequest.fromBuffer(value),
            ($0.GetTracksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LikeTrackRequest, $0.StatusResponse>(
        'LikeTrack',
        likeTrack_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LikeTrackRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlikeTrackRequest, $0.StatusResponse>(
        'UnlikeTrack',
        unlikeTrack_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnlikeTrackRequest.fromBuffer(value),
        ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLikedTracksRequest,
            $0.GetLikedTracksResponse>(
        'GetLikedTracks',
        getLikedTracks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLikedTracksRequest.fromBuffer(value),
        ($0.GetLikedTracksResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.IsTrackLikedRequest, $0.IsTrackLikedResponse>(
            'IsTrackLiked',
            isTrackLiked_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.IsTrackLikedRequest.fromBuffer(value),
            ($0.IsTrackLikedResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AddTrackToHistoryRequest, $0.StatusResponse>(
            'AddTrackToHistory',
            addTrackToHistory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AddTrackToHistoryRequest.fromBuffer(value),
            ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTrackHistoryRequest,
            $0.GetTrackHistoryResponse>(
        'GetTrackHistory',
        getTrackHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTrackHistoryRequest.fromBuffer(value),
        ($0.GetTrackHistoryResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ClearTrackHistoryRequest, $0.StatusResponse>(
            'ClearTrackHistory',
            clearTrackHistory_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ClearTrackHistoryRequest.fromBuffer(value),
            ($0.StatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecommendationsRequest,
            $0.GetRecommendationsResponse>(
        'GetRecommendations',
        getRecommendations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecommendationsRequest.fromBuffer(value),
        ($0.GetRecommendationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DiscoverTracksRequest,
            $0.DiscoverTracksResponse>(
        'WeeklyDiscoverTracks',
        weeklyDiscoverTracks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DiscoverTracksRequest.fromBuffer(value),
        ($0.DiscoverTracksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserTopTracksRequest,
            $0.GetUserTopTracksResponse>(
        'GetUserTopTracks',
        getUserTopTracks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserTopTracksRequest.fromBuffer(value),
        ($0.GetUserTopTracksResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.TrackResponse> getTrack_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetTrackRequest> $request) async {
    return getTrack($call, await $request);
  }

  $async.Future<$0.TrackResponse> getTrack(
      $grpc.ServiceCall call, $0.GetTrackRequest request);

  $async.Future<$0.SearchTracksResponse> searchTracks_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SearchTracksRequest> $request) async {
    return searchTracks($call, await $request);
  }

  $async.Future<$0.SearchTracksResponse> searchTracks(
      $grpc.ServiceCall call, $0.SearchTracksRequest request);

  $async.Future<$0.GetTracksResponse> getPopularTracks_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPopularTracksRequest> $request) async {
    return getPopularTracks($call, await $request);
  }

  $async.Future<$0.GetTracksResponse> getPopularTracks(
      $grpc.ServiceCall call, $0.GetPopularTracksRequest request);

  $async.Future<$0.GetTracksResponse> getTracksByGenre_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTracksByGenreRequest> $request) async {
    return getTracksByGenre($call, await $request);
  }

  $async.Future<$0.GetTracksResponse> getTracksByGenre(
      $grpc.ServiceCall call, $0.GetTracksByGenreRequest request);

  $async.Future<$0.StatusResponse> likeTrack_Pre($grpc.ServiceCall $call,
      $async.Future<$0.LikeTrackRequest> $request) async {
    return likeTrack($call, await $request);
  }

  $async.Future<$0.StatusResponse> likeTrack(
      $grpc.ServiceCall call, $0.LikeTrackRequest request);

  $async.Future<$0.StatusResponse> unlikeTrack_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UnlikeTrackRequest> $request) async {
    return unlikeTrack($call, await $request);
  }

  $async.Future<$0.StatusResponse> unlikeTrack(
      $grpc.ServiceCall call, $0.UnlikeTrackRequest request);

  $async.Future<$0.GetLikedTracksResponse> getLikedTracks_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetLikedTracksRequest> $request) async {
    return getLikedTracks($call, await $request);
  }

  $async.Future<$0.GetLikedTracksResponse> getLikedTracks(
      $grpc.ServiceCall call, $0.GetLikedTracksRequest request);

  $async.Future<$0.IsTrackLikedResponse> isTrackLiked_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.IsTrackLikedRequest> $request) async {
    return isTrackLiked($call, await $request);
  }

  $async.Future<$0.IsTrackLikedResponse> isTrackLiked(
      $grpc.ServiceCall call, $0.IsTrackLikedRequest request);

  $async.Future<$0.StatusResponse> addTrackToHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AddTrackToHistoryRequest> $request) async {
    return addTrackToHistory($call, await $request);
  }

  $async.Future<$0.StatusResponse> addTrackToHistory(
      $grpc.ServiceCall call, $0.AddTrackToHistoryRequest request);

  $async.Future<$0.GetTrackHistoryResponse> getTrackHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTrackHistoryRequest> $request) async {
    return getTrackHistory($call, await $request);
  }

  $async.Future<$0.GetTrackHistoryResponse> getTrackHistory(
      $grpc.ServiceCall call, $0.GetTrackHistoryRequest request);

  $async.Future<$0.StatusResponse> clearTrackHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ClearTrackHistoryRequest> $request) async {
    return clearTrackHistory($call, await $request);
  }

  $async.Future<$0.StatusResponse> clearTrackHistory(
      $grpc.ServiceCall call, $0.ClearTrackHistoryRequest request);

  $async.Future<$0.GetRecommendationsResponse> getRecommendations_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetRecommendationsRequest> $request) async {
    return getRecommendations($call, await $request);
  }

  $async.Future<$0.GetRecommendationsResponse> getRecommendations(
      $grpc.ServiceCall call, $0.GetRecommendationsRequest request);

  $async.Future<$0.DiscoverTracksResponse> weeklyDiscoverTracks_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DiscoverTracksRequest> $request) async {
    return weeklyDiscoverTracks($call, await $request);
  }

  $async.Future<$0.DiscoverTracksResponse> weeklyDiscoverTracks(
      $grpc.ServiceCall call, $0.DiscoverTracksRequest request);

  $async.Future<$0.GetUserTopTracksResponse> getUserTopTracks_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserTopTracksRequest> $request) async {
    return getUserTopTracks($call, await $request);
  }

  $async.Future<$0.GetUserTopTracksResponse> getUserTopTracks(
      $grpc.ServiceCall call, $0.GetUserTopTracksRequest request);
}
