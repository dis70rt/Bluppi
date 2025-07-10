import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentlyPlayedProgressIndicator extends StatelessWidget {
  const RecentlyPlayedProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Skeletonizer.zone(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (_, __) => SizedBox(
                  width: 200,
                  height: 100,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Bone(width: 200, height: 100),
                  ),
                )),
      ),
    );
  }
}
