import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopTracksSkeleton extends StatelessWidget {
  final int count;

  const TopTracksSkeleton({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header skeleton
          const Bone.text(fontSize: 18, words: 2),
          const SizedBox(height: 16),

          // Track tile skeletons
          ...List.generate(count, (index) => _buildSkeletonTile(index)),
        ],
      ),
    );
  }

  Widget _buildSkeletonTile(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // Rank number
          SizedBox(
            width: 28,
            child: Bone.text(
              fontSize: 15,
              words: 1,
            ),
          ),
          const SizedBox(width: 12),

          // Album art
          Bone(
            width: 48,
            height: 48,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(width: 12),

          // Track info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Bone.text(fontSize: 15, words: 3),
                SizedBox(height: 2),
                Bone.text(fontSize: 13, words: 2),
              ],
            ),
          ),

          // Play count
          const Bone.text(fontSize: 12, words: 1),
        ],
      ),
    );
  }
}

/// Minimal skeleton matching the profile_screen_skeleton layout for the
/// top tracks section. Used inside ProfileScreenSkeleton.
class TopTracksSectionSkeleton extends StatelessWidget {
  const TopTracksSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Bone.text(fontSize: 18, words: 2),
        const SizedBox(height: 16),
        ...List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Bone.text(fontSize: 15, words: 1),
                ),
                const SizedBox(width: 12),
                Bone(
                  width: 48,
                  height: 48,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Bone.text(fontSize: 15, words: 3),
                      SizedBox(height: 2),
                      Bone.text(fontSize: 13, words: 2),
                    ],
                  ),
                ),
                const Bone.text(fontSize: 12, words: 1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
