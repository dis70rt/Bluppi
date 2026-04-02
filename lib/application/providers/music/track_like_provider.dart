import 'package:bluppi/data/grpc/repositories/track_service_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackLikeArg {
  final String trackId;
  final bool? initialIsLiked;

  const TrackLikeArg({required this.trackId, this.initialIsLiked});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackLikeArg && other.trackId == trackId);

  @override
  int get hashCode => trackId.hashCode;
}

class TrackLikeNotifier extends AsyncNotifier<bool> {
  final TrackLikeArg arg;
  TrackLikeNotifier(this.arg);

  @override
  Future<bool> build() async {
    if (arg.initialIsLiked != null) return arg.initialIsLiked!;
    final repo = ref.read(trackServiceProvider);
    return await repo.isTrackLiked(arg.trackId);
  }

  Future<void> toggleLike() async {
    if (state.isLoading || state.hasError) return;

    final repo = ref.read(trackServiceProvider);
    final prevState = state.value ?? false;

    state = AsyncData(!prevState);

    try {
      if (prevState) {
        await repo.unlikeTrack(arg.trackId);
      } else {
        await repo.likeTrack(arg.trackId);
      }
    } catch (e) {
      state = AsyncData(prevState);
    }
  }
}

final trackLikeProvider = AsyncNotifierProvider.family
    .autoDispose<TrackLikeNotifier, bool, TrackLikeArg>(
      (arg) => TrackLikeNotifier(arg),
    );
