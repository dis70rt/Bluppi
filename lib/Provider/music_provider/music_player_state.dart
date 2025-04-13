import 'package:equatable/equatable.dart';
import 'package:synqit/Data/Models/last_track_model.dart';

enum PlayerStatus {
  initial,
  loading,
  loaded,
  playing,
  paused,
  completed,
  error
} 

class MusicPlayerState extends Equatable{
  final PlayerStatus status;
  final LastTrack? currentTrack;
  final Duration position;
  final Duration bufferedPosition;
  final Duration? duration;
  final String? errorMessage;
  final bool isSeeking;

  const MusicPlayerState({
    this.status = PlayerStatus.initial,
    this.currentTrack,
    this.position = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.duration,
    this.errorMessage,
    this.isSeeking = false,
  });

  bool get isLoading => status == PlayerStatus.loading;
  bool get isPlaying => status == PlayerStatus.playing;
  bool get hasError => status == PlayerStatus.error;

  MusicPlayerState copyWith({
    PlayerStatus? status,
    LastTrack? currentTrack,
    Duration? position,
    Duration? bufferedPosition,
    Duration? duration,
    String? errorMessage,
    bool? clearError,
    bool? isSeeking,
  }) {
    return MusicPlayerState(
      status: status ?? this.status,
      currentTrack: currentTrack ?? this.currentTrack,
      position: position ?? this.position,
      bufferedPosition: bufferedPosition ?? this.bufferedPosition,
      duration: duration ?? this.duration,
      errorMessage:
          clearError == true ? null : errorMessage ?? this.errorMessage,
      isSeeking: isSeeking ?? this.isSeeking,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentTrack,
        position,
        bufferedPosition,
        duration,
        errorMessage,
        isSeeking,
      ];
}
