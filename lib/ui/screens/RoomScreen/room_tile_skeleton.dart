import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoomTileSkeleton extends StatelessWidget {
  const RoomTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: BluppiColors.surface.withAlpha(128),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Bone.square(
              size: 68,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Bone.text(
                    words: 2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  const Bone.text(words: 1, style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Bone.circle(size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Bone.text(
                          words: 3,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Bone(
                  width: 40,
                  height: 16,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    Bone.icon(size: 16),
                    SizedBox(width: 4),
                    Bone.text(words: 1, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
