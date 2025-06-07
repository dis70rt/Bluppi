import 'package:flutter/foundation.dart';
import 'package:synqit/Data/Models/track_model.dart';

enum PlayerStatus { initial, loading, playing, paused, completed, error, ready }

@immutable
class MusicPlayerState {
  final PlayerStatus status;
  final Duration position;
  final Duration bufferedPosition;
  final Duration? duration;
  final bool isSeeking;
  final String? errorMessage;
  final Track? track;

  const MusicPlayerState({
    this.status = PlayerStatus.initial,
    this.position = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.duration,
    this.isSeeking = false,
    this.errorMessage,
    this.track,
  });

  bool get isLoading => status == PlayerStatus.loading;
  bool get isPlaying => status == PlayerStatus.playing;
  bool get hasError => status == PlayerStatus.error;

  MusicPlayerState copyWith({
    PlayerStatus? status,
    Duration? position,
    Duration? bufferedPosition,
    Duration? duration,
    bool? isSeeking,
    String? errorMessage,
    Track? track,
    bool clearError = false,
    bool clearDuration = false,
    bool clearTrack = false,
  }) {
    return MusicPlayerState(
      status: status ?? this.status,
      position: position ?? this.position,
      bufferedPosition: bufferedPosition ?? this.bufferedPosition,
      duration: clearDuration ? null : (duration ?? this.duration),
      isSeeking: isSeeking ?? this.isSeeking,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      track: clearTrack ? null : (track ?? this.track),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicPlayerState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          position == other.position &&
          bufferedPosition == other.bufferedPosition &&
          duration == other.duration &&
          isSeeking == other.isSeeking &&
          errorMessage == other.errorMessage &&
          track?.trackId == other.track?.trackId;

  @override
  int get hashCode =>
      status.hashCode ^
      position.hashCode ^
      bufferedPosition.hashCode ^
      duration.hashCode ^
      isSeeking.hashCode ^
      errorMessage.hashCode ^
      (track?.trackId.hashCode ?? 0);

  @override
  String toString() {
    return 'MusicPlayerState(status: $status, position: $position, bufferedPosition: $bufferedPosition, duration: $duration, isSeeking: $isSeeking, errorMessage: $errorMessage, track: ${track?.trackName})';
  }
}
