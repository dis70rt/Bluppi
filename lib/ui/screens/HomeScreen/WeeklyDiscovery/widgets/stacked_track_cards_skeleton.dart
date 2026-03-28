import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StackedTrackCardsSkeleton extends StatelessWidget {
  const StackedTrackCardsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    const double totalHeight = 150.0; 

    return const SizedBox(
      height: totalHeight,
      width: double.infinity,
      child: Bone(
        height: totalHeight,
        width: double.infinity,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}