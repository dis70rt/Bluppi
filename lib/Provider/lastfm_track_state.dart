import 'package:equatable/equatable.dart';
import 'package:synqit/Data/Models/track_model.dart';

abstract class TrackState extends Equatable {
  const TrackState();

  @override
  List<Object?> get props => [];
}

class TrackInitial extends TrackState {}

class TrackLoading extends TrackState {}

class TrackSuccess extends TrackState {
  final List<Track> searchResults;
  final Track? bestResult;
  final List<Track> suggestedTracks;

  const TrackSuccess({
    required this.searchResults,
    this.bestResult,
    required this.suggestedTracks,
  });

  @override
  List<Object?> get props => [searchResults, bestResult, suggestedTracks];
}

class TrackError extends TrackState {
  final String message;

  const TrackError(this.message);

  @override
  List<Object> get props => [message];
}
