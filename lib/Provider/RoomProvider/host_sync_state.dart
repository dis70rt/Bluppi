// ignore_for_file: constant_identifier_names

import 'package:bluppi/Data/Models/track_model.dart';

enum CommandType {
    PLAY,
    PAUSE,
    SEEK,
    TRACK_CHANGE,
    ADJUST_RATE,
}

class HostTrackCommandModel {
  String roomId;
  Track track;
  int startAtServerMs;
  int startPosition;
  String hostUserId;

  HostTrackCommandModel({
    required this.roomId,
    required this.track,
    required this.startAtServerMs,
    required this.startPosition,
    required this.hostUserId,
  });
}

class HostPositionUpdateModel {
  String roomId;
  int currentPositionMs;
  int serverTimestampMs;
  String hostUserId;

  HostPositionUpdateModel({
    required this.roomId,
    required this.currentPositionMs,
    required this.serverTimestampMs,
    required this.hostUserId,
  });
}

class HostPlaybackCommandModel {
  String roomId;
  CommandType type;
  int executeAtServerMs;
  int positionMs;
  String hostUserId;

  HostPlaybackCommandModel({
    required this.roomId,
    required this.type,
    required this.executeAtServerMs,
    required this.positionMs,
    required this.hostUserId,
  });
}

class HostCommandModel {
  final HostTrackCommandModel? trackCommand;
  final HostPositionUpdateModel? positionUpdate;
  final HostPlaybackCommandModel? controlCommand;

  HostCommandModel({
    this.trackCommand,
    this.positionUpdate,
    this.controlCommand,
  });

  bool get isTrackCommand => trackCommand != null;
  bool get isPositionUpdate => positionUpdate != null;
  bool get isControlCommand => controlCommand != null;
}

/*

*/