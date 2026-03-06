// This is a generated file - do not edit.
//
// Generated from rooms.proto.

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

import 'rooms.pb.dart' as $0;

export 'rooms.pb.dart';

@$pb.GrpcServiceName('room.RoomService')
class RoomServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  RoomServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.Room> createRoom(
    $0.CreateRoomRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createRoom, request, options: options);
  }

  $grpc.ResponseFuture<$0.Room> getRoom(
    $0.GetRoomRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRoom, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListRoomsResponse> listRooms(
    $0.ListRoomsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listRooms, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> joinRoom(
    $0.JoinRoomRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$joinRoom, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> leaveRoom(
    $0.LeaveRoomRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$leaveRoom, request, options: options);
  }

  $grpc.ResponseStream<$0.RoomEvent> subscribeToRoomEvents(
    $0.SubscribeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$subscribeToRoomEvents, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.GetListenersResponse> getListeners(
    $0.GetListenersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getListeners, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> sendLiveChatMessage(
    $0.SendLiveChatMessageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sendLiveChatMessage, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> inviteUserToRoom(
    $0.InviteUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$inviteUserToRoom, request, options: options);
  }

  // method descriptors

  static final _$createRoom = $grpc.ClientMethod<$0.CreateRoomRequest, $0.Room>(
      '/room.RoomService/CreateRoom',
      ($0.CreateRoomRequest value) => value.writeToBuffer(),
      $0.Room.fromBuffer);
  static final _$getRoom = $grpc.ClientMethod<$0.GetRoomRequest, $0.Room>(
      '/room.RoomService/GetRoom',
      ($0.GetRoomRequest value) => value.writeToBuffer(),
      $0.Room.fromBuffer);
  static final _$listRooms =
      $grpc.ClientMethod<$0.ListRoomsRequest, $0.ListRoomsResponse>(
          '/room.RoomService/ListRooms',
          ($0.ListRoomsRequest value) => value.writeToBuffer(),
          $0.ListRoomsResponse.fromBuffer);
  static final _$joinRoom = $grpc.ClientMethod<$0.JoinRoomRequest, $1.Empty>(
      '/room.RoomService/JoinRoom',
      ($0.JoinRoomRequest value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$leaveRoom = $grpc.ClientMethod<$0.LeaveRoomRequest, $1.Empty>(
      '/room.RoomService/LeaveRoom',
      ($0.LeaveRoomRequest value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$subscribeToRoomEvents =
      $grpc.ClientMethod<$0.SubscribeRequest, $0.RoomEvent>(
          '/room.RoomService/SubscribeToRoomEvents',
          ($0.SubscribeRequest value) => value.writeToBuffer(),
          $0.RoomEvent.fromBuffer);
  static final _$getListeners =
      $grpc.ClientMethod<$0.GetListenersRequest, $0.GetListenersResponse>(
          '/room.RoomService/GetListeners',
          ($0.GetListenersRequest value) => value.writeToBuffer(),
          $0.GetListenersResponse.fromBuffer);
  static final _$sendLiveChatMessage =
      $grpc.ClientMethod<$0.SendLiveChatMessageRequest, $1.Empty>(
          '/room.RoomService/SendLiveChatMessage',
          ($0.SendLiveChatMessageRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$inviteUserToRoom =
      $grpc.ClientMethod<$0.InviteUserRequest, $1.Empty>(
          '/room.RoomService/InviteUserToRoom',
          ($0.InviteUserRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
}

@$pb.GrpcServiceName('room.RoomService')
abstract class RoomServiceBase extends $grpc.Service {
  $core.String get $name => 'room.RoomService';

  RoomServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateRoomRequest, $0.Room>(
        'CreateRoom',
        createRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateRoomRequest.fromBuffer(value),
        ($0.Room value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRoomRequest, $0.Room>(
        'GetRoom',
        getRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRoomRequest.fromBuffer(value),
        ($0.Room value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListRoomsRequest, $0.ListRoomsResponse>(
        'ListRooms',
        listRooms_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListRoomsRequest.fromBuffer(value),
        ($0.ListRoomsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JoinRoomRequest, $1.Empty>(
        'JoinRoom',
        joinRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JoinRoomRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LeaveRoomRequest, $1.Empty>(
        'LeaveRoom',
        leaveRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.LeaveRoomRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubscribeRequest, $0.RoomEvent>(
        'SubscribeToRoomEvents',
        subscribeToRoomEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SubscribeRequest.fromBuffer(value),
        ($0.RoomEvent value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetListenersRequest, $0.GetListenersResponse>(
            'GetListeners',
            getListeners_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetListenersRequest.fromBuffer(value),
            ($0.GetListenersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendLiveChatMessageRequest, $1.Empty>(
        'SendLiveChatMessage',
        sendLiveChatMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SendLiveChatMessageRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InviteUserRequest, $1.Empty>(
        'InviteUserToRoom',
        inviteUserToRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InviteUserRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Room> createRoom_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateRoomRequest> $request) async {
    return createRoom($call, await $request);
  }

  $async.Future<$0.Room> createRoom(
      $grpc.ServiceCall call, $0.CreateRoomRequest request);

  $async.Future<$0.Room> getRoom_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetRoomRequest> $request) async {
    return getRoom($call, await $request);
  }

  $async.Future<$0.Room> getRoom(
      $grpc.ServiceCall call, $0.GetRoomRequest request);

  $async.Future<$0.ListRoomsResponse> listRooms_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListRoomsRequest> $request) async {
    return listRooms($call, await $request);
  }

  $async.Future<$0.ListRoomsResponse> listRooms(
      $grpc.ServiceCall call, $0.ListRoomsRequest request);

  $async.Future<$1.Empty> joinRoom_Pre($grpc.ServiceCall $call,
      $async.Future<$0.JoinRoomRequest> $request) async {
    return joinRoom($call, await $request);
  }

  $async.Future<$1.Empty> joinRoom(
      $grpc.ServiceCall call, $0.JoinRoomRequest request);

  $async.Future<$1.Empty> leaveRoom_Pre($grpc.ServiceCall $call,
      $async.Future<$0.LeaveRoomRequest> $request) async {
    return leaveRoom($call, await $request);
  }

  $async.Future<$1.Empty> leaveRoom(
      $grpc.ServiceCall call, $0.LeaveRoomRequest request);

  $async.Stream<$0.RoomEvent> subscribeToRoomEvents_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SubscribeRequest> $request) async* {
    yield* subscribeToRoomEvents($call, await $request);
  }

  $async.Stream<$0.RoomEvent> subscribeToRoomEvents(
      $grpc.ServiceCall call, $0.SubscribeRequest request);

  $async.Future<$0.GetListenersResponse> getListeners_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetListenersRequest> $request) async {
    return getListeners($call, await $request);
  }

  $async.Future<$0.GetListenersResponse> getListeners(
      $grpc.ServiceCall call, $0.GetListenersRequest request);

  $async.Future<$1.Empty> sendLiveChatMessage_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SendLiveChatMessageRequest> $request) async {
    return sendLiveChatMessage($call, await $request);
  }

  $async.Future<$1.Empty> sendLiveChatMessage(
      $grpc.ServiceCall call, $0.SendLiveChatMessageRequest request);

  $async.Future<$1.Empty> inviteUserToRoom_Pre($grpc.ServiceCall $call,
      $async.Future<$0.InviteUserRequest> $request) async {
    return inviteUserToRoom($call, await $request);
  }

  $async.Future<$1.Empty> inviteUserToRoom(
      $grpc.ServiceCall call, $0.InviteUserRequest request);
}
