import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeAppBarSkeleton extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeAppBarSkeleton({super.key});

  static const double appBarHeight = 80.0;
  static const double avatarRadius = 22.0;
  static const double horizontalPadding = 16.0;

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: appBarHeight,
      backgroundColor: Theme.of(context).colorScheme.surface,
      automaticallyImplyLeading: false,
      titleSpacing: horizontalPadding,
      title: const Row(
        children: [
          Bone.circle(size: avatarRadius * 2),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(words: 2, style: TextStyle(fontSize: 13)),
                SizedBox(height: 4),

                Bone.text(
                  words: 2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Bone.circle(size: 40.0),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Bone.circle(size: 40.0),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
