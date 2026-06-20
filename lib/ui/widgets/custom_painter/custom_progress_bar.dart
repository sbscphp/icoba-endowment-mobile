import 'package:flutter/material.dart';

import '../../../core/constants/color_path.dart';


class CustomProgressBar extends CustomPainter {
  final Color? activeColor;
  final double? percentage;
  final double strokeWidth;
  final Color backgroundColor;

  CustomProgressBar({
    this.strokeWidth = 12,
    this.activeColor = ColorPath.brandColor,
    this.percentage = 0,
    this.backgroundColor = ColorPath.athensGrey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final foregroundPaint = Paint()
      ..color = activeColor!
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw background line
    canvas.drawLine(Offset.zero, Offset(size.width, 0), backgroundPaint);

    // Draw progress line (convert percentage to decimal if needed)
    if (percentage! > 0) {
      final progress = percentage! > 1 ? percentage! / 100 : percentage!;
      canvas.drawLine(
        Offset.zero,
        Offset(size.width * progress, 0),
        foregroundPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomProgressBar oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}