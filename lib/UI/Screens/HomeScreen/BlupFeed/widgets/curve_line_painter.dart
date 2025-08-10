import 'package:flutter/material.dart';

class CurvedLinePainter extends CustomPainter {
  final double curveTargetY;
  final double curveRadius;

  CurvedLinePainter({required this.curveTargetY, this.curveRadius = 25});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade900
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width / 2, 0);

    path.lineTo(size.width / 2, curveTargetY - curveRadius);

    path.quadraticBezierTo(
      size.width / 2,
      curveTargetY,
      size.width / 2 + curveRadius,
      curveTargetY,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CurvedLinePainter oldDelegate) =>
      oldDelegate.curveTargetY != curveTargetY ||
      oldDelegate.curveRadius != curveRadius;
}
