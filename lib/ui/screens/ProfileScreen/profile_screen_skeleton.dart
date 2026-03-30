import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreenSkeleton extends StatelessWidget {
  const ProfileScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 130,
              child: Bone(width: double.infinity, height: 130),
            ),

            // FOR THE LESS OPACITY
            Container(height: 131, color: Colors.black.withAlpha(100)),

            Padding(
              padding: const EdgeInsets.only(top: 85),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMockHeader(context),
                      _buildMockStats(),
                      const SizedBox(height: 16),
                      _buildMockButtons(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(color: Colors.white10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMockHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
                width: 4,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Bone(borderRadius: BorderRadius.circular(24)),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Bone.text(fontSize: 24, words: 2),
              SizedBox(width: 8),
              Icon(Icons.male, size: 24),
            ],
          ),

          SizedBox(height: 8),
          Row(
            children: [
              const Bone.text(fontSize: 15, words: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Bone.circle(size: 3),
              ),
              const Bone.text(fontSize: 14, words: 1),
            ],
          ),
          const SizedBox(height: 12),

          const Bone.multiText(lines: 2, fontSize: 14),
          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(3, (index) {
              return Bone(
                width: 80,
                height: 28,
                borderRadius: BorderRadius.circular(8),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMockStats() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _mockStatColumn(),
          const SizedBox(width: 20),
          _mockStatColumn(),
        ],
      ),
    );
  }

  Widget _mockStatColumn() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Bone.text(fontSize: 14, words: 1),
        SizedBox(width: 5),
        Bone.text(fontSize: 14, words: 1),
      ],
    );
  }

  Widget _buildMockButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Bone(height: 44, borderRadius: BorderRadius.circular(12)),
        ),
        const SizedBox(width: 8),
        Bone(width: 44, height: 44, borderRadius: BorderRadius.circular(12)),
      ],
    );
  }
}
