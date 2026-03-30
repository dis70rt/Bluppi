import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SuggestFriendsCardSkeleton extends StatelessWidget {
  const SuggestFriendsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withAlpha(51)),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bone.circle(size: 72),
            SizedBox(height: 16),
            Bone.text(
              words: 2,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Bone.text(words: 1, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class SuggestFriendsListSkeleton extends StatelessWidget {
  final int itemCount;

  const SuggestFriendsListSkeleton({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return const SuggestFriendsCardSkeleton();
        },
      ),
    );
  }
}
