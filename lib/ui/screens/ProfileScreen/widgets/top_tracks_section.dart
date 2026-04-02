import 'package:bluppi/application/providers/music/user_top_tracks_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/top_track_tile.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/top_tracks_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopTracksSection extends ConsumerWidget {
  final String userId;

  const TopTracksSection({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topTracksAsync = ref.watch(userTopTracksProvider(userId));

    return topTracksAsync.when(
      data: (tracks) {
        if (tracks.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Tracks",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: BluppiColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(tracks.length, (index) {
              return TopTrackTile(
                track: tracks[index],
                rank: index + 1,
              );
            }),
          ],
        );
      },
      loading: () => const TopTracksSkeleton(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
