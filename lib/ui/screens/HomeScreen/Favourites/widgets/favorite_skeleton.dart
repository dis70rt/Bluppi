import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritesSkeleton extends StatelessWidget {
  const FavoritesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                spacing: 8,
                children: [
                  Bone.button(width: 60, height: 34, borderRadius: BorderRadius.circular(20)),
                  Bone.button(width: 110, height: 34, borderRadius: BorderRadius.circular(20)),
                  Bone.button(width: 120, height: 34, borderRadius: BorderRadius.circular(20)),
                  Bone.button(width: 90, height: 34, borderRadius: BorderRadius.circular(20)),
                ],
              ),
            ),
          ),

          // Track Count Skeleton
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Bone.text(
              words: 2,
              style: TextStyle(fontSize: 12),
            ),
          ),

          // Track List Skeleton
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const _SkeletonTrackTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonTrackTile extends StatelessWidget {
  const _SkeletonTrackTile();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Album Art Bone
          Bone.square(
            size: 56,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          SizedBox(width: 16),

          // Title & Artist Bones
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6, // Automatically spaces the text lines
              children: [
                Bone.text(
                  words: 4,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Bone.text(
                  words: 2,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Icon(Icons.favorite, size: 24),
        ],
      ),
    );
  }
}