//
//  Generated code. Do not modify.
//  source: protobuf/room.proto
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
import 'room.pb.dart' as $4;

export 'room.pb.dart';

@$pb.GrpcServiceName('ListeningParty.RoomService')
class RoomServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$createRoom = $grpc.ClientMethod<$4.CreateRoomRequest, $4.Room>(
      '/ListeningParty.RoomService/CreateRoom',
      ($4.CreateRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.Room.fromBuffer(value));
  static final _$getRoom = $grpc.ClientMethod<$4.GetRoomRequest, $4.Room>(
      '/ListeningParty.RoomService/GetRoom',
      ($4.GetRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.Room.fromBuffer(value));
  static final _$updateRoom = $grpc.ClientMethod<$4.UpdateRoomRequest, $4.Room>(
      '/ListeningParty.RoomService/UpdateRoom',
      ($4.UpdateRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.Room.fromBuffer(value));
  static final _$deleteRoom = $grpc.ClientMethod<$4.DeleteRoomRequest, $3.Empty>(
      '/ListeningParty.RoomService/DeleteRoom',
      ($4.DeleteRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Empty.fromBuffer(value));
  static final _$listRooms = $grpc.ClientMethod<$4.ListRoomsRequest, $4.ListRoomsResponse>(
      '/ListeningParty.RoomService/ListRooms',
      ($4.ListRoomsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.ListRoomsResponse.fromBuffer(value));
  static final _$joinRoom = $grpc.ClientMethod<$4.JoinRoomRequest, $4.Room>(
      '/ListeningParty.RoomService/JoinRoom',
      ($4.JoinRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.Room.fromBuffer(value));
  static final _$leaveRoom = $grpc.ClientMethod<$4.LeaveRoomRequest, $3.Empty>(
      '/ListeningParty.RoomService/LeaveRoom',
      ($4.LeaveRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Empty.fromBuffer(value));
  static final _$inviteToRoom = $grpc.ClientMethod<$4.InviteToRoomRequest, $3.Empty>(
      '/ListeningParty.RoomService/InviteToRoom',
      ($4.InviteToRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Empty.fromBuffer(value));
  static final _$kickFromRoom = $grpc.ClientMethod<$4.KickFromRoomRequest, $3.Empty>(
      '/ListeningParty.RoomService/KickFromRoom',
      ($4.KickFromRoomRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Empty.fromBuffer(value));

  RoomServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$4.Room> createRoom($4.CreateRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRoom, request, options: options);
  }

  $grpc.ResponseFuture<$4.Room> getRoom($4.GetRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRoom, request, options: options);
  }

  $grpc.ResponseFuture<$4.Room> updateRoom($4.UpdateRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRoom, request, options: options);
  }

  $grpc.ResponseFuture<$3.Empty> deleteRoom($4.DeleteRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRoom, request, options: options);
  }

  $grpc.ResponseFuture<$4.ListRoomsResponse> listRooms($4.ListRoomsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRooms, request, options: options);
  }

  $grpc.ResponseFuture<$4.Room> joinRoom($4.JoinRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$joinRoom, request, options: options);
  }

  $grpc.ResponseFuture<$3.Empty> leaveRoom($4.LeaveRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$leaveRoom, request, options: options);
  }

  $grpc.ResponseFuture<$3.Empty> inviteToRoom($4.InviteToRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$inviteToRoom, request, options: options);
  }

  $grpc.ResponseFuture<$3.Empty> kickFromRoom($4.KickFromRoomRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$kickFromRoom, request, options: options);
  }
}

@$pb.GrpcServiceName('ListeningParty.RoomService')
abstract class RoomServiceBase extends $grpc.Service {
  $core.String get $name => 'ListeningParty.RoomService';

  RoomServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.CreateRoomRequest, $4.Room>(
        'CreateRoom',
        createRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.CreateRoomRequest.fromBuffer(value),
        ($4.Room value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetRoomRequest, $4.Room>(
        'GetRoom',
        getRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetRoomRequest.fromBuffer(value),
        ($4.Room value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UpdateRoomRequest, $4.Room>(
        'UpdateRoom',
        updateRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.UpdateRoomRequest.fromBuffer(value),
        ($4.Room value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.DeleteRoomRequest, $3.Empty>(
        'DeleteRoom',
        deleteRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.DeleteRoomRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ListRoomsRequest, $4.ListRoomsResponse>(
        'ListRooms',
        listRooms_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.ListRoomsRequest.fromBuffer(value),
        ($4.ListRoomsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.JoinRoomRequest, $4.Room>(
        'JoinRoom',
        joinRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.JoinRoomRequest.fromBuffer(value),
        ($4.Room value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.LeaveRoomRequest, $3.Empty>(
        'LeaveRoom',
        leaveRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.LeaveRoomRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.InviteToRoomRequest, $3.Empty>(
        'InviteToRoom',
        inviteToRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.InviteToRoomRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.KickFromRoomRequest, $3.Empty>(
        'KickFromRoom',
        kickFromRoom_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.KickFromRoomRequest.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$4.Room> createRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.CreateRoomRequest> $request) async {
    return createRoom($call, await $request);
  }

  $async.Future<$4.Room> getRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.GetRoomRequest> $request) async {
    return getRoom($call, await $request);
  }

  $async.Future<$4.Room> updateRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.UpdateRoomRequest> $request) async {
    return updateRoom($call, await $request);
  }

  $async.Future<$3.Empty> deleteRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.DeleteRoomRequest> $request) async {
    return deleteRoom($call, await $request);
  }

  $async.Future<$4.ListRoomsResponse> listRooms_Pre($grpc.ServiceCall $call, $async.Future<$4.ListRoomsRequest> $request) async {
    return listRooms($call, await $request);
  }

  $async.Future<$4.Room> joinRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.JoinRoomRequest> $request) async {
    return joinRoom($call, await $request);
  }

  $async.Future<$3.Empty> leaveRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.LeaveRoomRequest> $request) async {
    return leaveRoom($call, await $request);
  }

  $async.Future<$3.Empty> inviteToRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.InviteToRoomRequest> $request) async {
    return inviteToRoom($call, await $request);
  }

  $async.Future<$3.Empty> kickFromRoom_Pre($grpc.ServiceCall $call, $async.Future<$4.KickFromRoomRequest> $request) async {
    return kickFromRoom($call, await $request);
  }

  $async.Future<$4.Room> createRoom($grpc.ServiceCall call, $4.CreateRoomRequest request);
  $async.Future<$4.Room> getRoom($grpc.ServiceCall call, $4.GetRoomRequest request);
  $async.Future<$4.Room> updateRoom($grpc.ServiceCall call, $4.UpdateRoomRequest request);
  $async.Future<$3.Empty> deleteRoom($grpc.ServiceCall call, $4.DeleteRoomRequest request);
  $async.Future<$4.ListRoomsResponse> listRooms($grpc.ServiceCall call, $4.ListRoomsRequest request);
  $async.Future<$4.Room> joinRoom($grpc.ServiceCall call, $4.JoinRoomRequest request);
  $async.Future<$3.Empty> leaveRoom($grpc.ServiceCall call, $4.LeaveRoomRequest request);
  $async.Future<$3.Empty> inviteToRoom($grpc.ServiceCall call, $4.InviteToRoomRequest request);
  $async.Future<$3.Empty> kickFromRoom($grpc.ServiceCall call, $4.KickFromRoomRequest request);
}
