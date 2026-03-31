import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentTrackCardSkeleton extends StatelessWidget {
  const RecentTrackCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Stack(
          children: [
            const Positioned.fill(child: Bone()),

            Positioned(
              bottom: 8,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Bone.text(
                    words: 2,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Bone.text(
                          words: 1,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      // const SizedBox(width: 16),
                      const Bone.text(words: 1, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentlyPlayedListSkeleton extends StatelessWidget {
  final int itemCount;

  const RecentlyPlayedListSkeleton({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return const RecentTrackCardSkeleton();
          },
        ),
      ),
    );
  }
}
