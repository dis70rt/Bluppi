import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StackedTrackCardsSkeleton extends StatelessWidget {
  const StackedTrackCardsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 100.0;
    const double peekOffset = 10.0;
    const double scaleStep = 0.05;
    const int visibleStackCount = 3;

    const double totalHeight =
        cardHeight + (visibleStackCount * peekOffset) + 20;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: totalHeight,
          width: constraints.maxWidth,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              for (int i = visibleStackCount; i >= 0; i--)
                _buildStaticAnimatedCard(
                  delta: i.toDouble(),
                  maxWidth: constraints.maxWidth,
                  visibleStackCount: visibleStackCount,
                  peekOffset: peekOffset,
                  scaleStep: scaleStep,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStaticAnimatedCard({
    required double delta,
    required double maxWidth,
    required int visibleStackCount,
    required double peekOffset,
    required double scaleStep,
  }) {
    double yOffset = -(delta * peekOffset);
    double scale = 1.0 - (delta * scaleStep);
    double opacity = (visibleStackCount - delta).clamp(0.0, 1.0);

    return Positioned(
      top: 10 + (visibleStackCount * peekOffset) + yOffset,
      child: Opacity(
        opacity: opacity,
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: SizedBox(width: maxWidth, child: const _SkeletonTrackCard()),
        ),
      ),
    );
  }
}

class _SkeletonTrackCard extends StatelessWidget {
  const _SkeletonTrackCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      height: 100,
      decoration: BoxDecoration(
        color: BluppiColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: BluppiColors.divider.withAlpha(255),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Bone.square(size: 76, borderRadius: BorderRadius.circular(10)),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Bone.text(
                    words: 3,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Bone.text(
                    words: 2,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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