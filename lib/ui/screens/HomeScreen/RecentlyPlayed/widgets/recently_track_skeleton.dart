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
        // FIX: Replaced the empty Container with a Bone
        child: const Bone(), 
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
      enabled: true,
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