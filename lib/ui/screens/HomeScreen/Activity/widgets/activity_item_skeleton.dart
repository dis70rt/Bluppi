import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/constants.dart';

class NoteBubbleSkeleton extends StatelessWidget {
  const NoteBubbleSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 115, minWidth: 72),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: BluppiColors.surface,
            borderRadius: NoteStyle.bubbleRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(102),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ılı ',
                    style: TextStyle(
                      fontSize: 10,
                      color: NoteStyle.musicBarColor,
                    ),
                  ),
                  SizedBox(width: 4),
                  Flexible(
                    child: Bone.text(words: 1, style: TextStyle(fontSize: 11)),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Bone.text(words: 1, style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),

        const Positioned(bottom: -9, left: 12, child: Bone.circle(size: 9)),

        const Positioned(bottom: -16, left: 19, child: Bone.circle(size: 5)),
      ],
    );
  }
}

class ActivityItemSkeleton extends StatelessWidget {
  const ActivityItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        width: 80,

        child: Opacity(
          opacity: 1.0,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: NoteStyle.offlineRing, width: 2.0),
                      ),
                    ),
                    child: const Bone.circle(size: 60),
                  ),
                  const SizedBox(height: 6),

                  const SizedBox(
                    width: 80,
                    child: Center(
                      child: Bone.text(
                        words: 1,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NoteBubbleSkeleton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityListSkeleton extends StatelessWidget {
  final int itemCount;

  const ActivityListSkeleton({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,

      child: SizedBox(
        height: 130,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return const ActivityItemSkeleton();
          },
        ),
      ),
    );
  }
}
