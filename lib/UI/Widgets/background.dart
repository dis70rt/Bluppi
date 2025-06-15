import 'package:flutter/material.dart';
import 'package:synqit/Constants/colors.dart';

class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _alignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween:
              AlignmentTween(begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: AlignmentTween(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: AlignmentTween(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: AlignmentTween(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1.0,
        ),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _alignmentAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: BackgroundColor.gradientColors,
              begin: _alignmentAnimation.value,
              end: Alignment(
                -_alignmentAnimation.value.x,
                -_alignmentAnimation.value.y,
              ),
            ),
          ),
        );
      },
    );
  }
}
