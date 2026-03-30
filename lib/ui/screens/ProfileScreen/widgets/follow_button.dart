import 'package:bluppi/application/providers/user/follow_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FollowButton extends ConsumerWidget {
  final FollowArg args;
  const FollowButton({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final followState = ref.watch(followStatsProvider(args));
    final followNotifier = ref.read(followStatsProvider(args).notifier);

    final glassColor = BluppiColors.surfaceRaised;
    final activeColor = const Color(0xFF2D3BFF);

    if (followState.isFollowing == null) {
      return Skeletonizer(
        enabled: true,
        child: SizedBox(
          height: 44,
          width: 100,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: glassColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Follow", style: TextStyle(fontSize: 15)), 
          ),
        ),
      );
    }

    final isFollowing = followState.isFollowing!;

    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: followState.isLoading ? null : () => followNotifier.toggleFollow(),
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing ? glassColor : activeColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: (isFollowing ? glassColor : activeColor).withAlpha(128),
          disabledForegroundColor: Colors.white.withAlpha(128),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          isFollowing ? "Following" : "Follow",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15, 
            fontWeight: isFollowing ? FontWeight.w600 : FontWeight.bold,
          ),
        ),
      ),
    );
  }
}