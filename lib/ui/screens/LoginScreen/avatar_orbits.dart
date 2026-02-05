import 'dart:math' as math;
import 'package:flutter/material.dart';

class AvatarOrbits extends StatefulWidget {
  const AvatarOrbits({super.key});

  @override
  State<AvatarOrbits> createState() =>
      _AvatarOrbitsState();
}

class _AvatarOrbitsState extends State<AvatarOrbits>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<String> avatars = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final orbitBorderColor = (isDark ? Colors.white : Colors.black).withAlpha(
      20,
    );

    final dullBorderColor = (isDark ? Colors.white : Colors.black).withAlpha(
      30,
    );

    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: orbitBorderColor, width: 1.5),
            ),
          ),

          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: orbitBorderColor, width: 1.5),
            ),
          ),

          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.secondary.withAlpha(40),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/icons/launcher.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  ...List.generate(3, (index) {
                    final angle =
                        (index * (2 * math.pi / 3)) +
                        (_controller.value * 2 * math.pi);
                    return _buildOrbitItem(
                      radius: 160,
                      angle: angle,

                      image: AssetImage(avatars[index]),
                      borderColor: dullBorderColor,
                      bgColor: theme.scaffoldBackgroundColor,
                    );
                  }),

                  ...List.generate(2, (index) {
                    final angle =
                        (index * math.pi) -
                        (_controller.value * 2 * math.pi) +
                        1;
                    return _buildOrbitItem(
                      radius: 95,
                      angle: angle,

                      image: AssetImage(avatars[index + 3]),
                      borderColor: dullBorderColor,
                      bgColor: theme.scaffoldBackgroundColor,
                    );
                  }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrbitItem({
    required double radius,
    required double angle,
    required ImageProvider image,
    required Color borderColor,
    required Color bgColor,
  }) {
    return Transform.translate(
      offset: Offset(radius * math.cos(angle), radius * math.sin(angle)),
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),

          child: ClipOval(
            child: Opacity(
              opacity: 0.6,
              child: Image(
                image: image,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
