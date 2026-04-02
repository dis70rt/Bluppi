import 'package:bluppi/application/providers/music/track_like_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';

class TrackLikeButton extends ConsumerWidget {
  final String trackId;
  final bool? initialIsLiked;

  const TrackLikeButton({
    super.key,
    required this.trackId,
    this.initialIsLiked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arg = TrackLikeArg(
      trackId: trackId,
      initialIsLiked: initialIsLiked,
    );
    final likeState = ref.watch(trackLikeProvider(arg));

    return likeState.when(
      data: (isLiked) {
        return LikeButton(
          size: 24.0,
          isLiked: isLiked,

          circleColor: const CircleColor(
            start: Colors.redAccent,
            end: Colors.red,
          ),

          bubblesColor: const BubblesColor(
            dotPrimaryColor: Colors.redAccent,
            dotSecondaryColor: Colors.white,
          ),

          likeBuilder: (bool isCurrentlyLiked) {
            return Icon(
              isCurrentlyLiked ? Icons.favorite : Icons.favorite_border,
              color: isCurrentlyLiked ? Colors.redAccent : Colors.white,
              size: 24.0,
            );
          },

          onTap: (bool isCurrentlyLiked) async {
            ref.read(trackLikeProvider(arg).notifier).toggleLike();

            return !isCurrentlyLiked;
          },
        );
      },

      loading: () => const Padding(
        padding: EdgeInsets.all(4.0),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white54,
          ),
        ),
      ),

      error: (error, stackTrace) => IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: const Icon(Icons.error_outline, size: 24, color: Colors.grey),
        onPressed: () {
          ref.invalidate(trackLikeProvider(arg));
        },
      ),
    );
  }
}
