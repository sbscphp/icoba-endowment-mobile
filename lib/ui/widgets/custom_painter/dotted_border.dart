import 'package:flutter/material.dart';

enum DottedBorderSide { top, right, bottom, left }

class DottedBorder extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;
  final bool isCircle; // NEW: determines if shape is circular
  final Set<DottedBorderSide> sides; // NEW: specify which sides to draw

  DottedBorder({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = BorderRadius.zero,
    this.isCircle = false,
    this.sides = const {DottedBorderSide.top, DottedBorderSide.right, DottedBorderSide.bottom, DottedBorderSide.left}, // NEW: default draws all sides
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (isCircle) {
      // For circles, we'll draw arcs for specified sides
      _drawCircularBorder(canvas, size, paint);
    } else {
      _drawRectangularBorder(canvas, size, paint);
    }
  }

  void _drawCircularBorder(Canvas canvas, Size size, Paint paint) {
    final radius = size.shortestSide / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);
    
    // For circular borders, we'll divide into 4 quarters
    final sweepAngle = 3.14159 / 2; // 90 degrees in radians
    
    if (sides.contains(DottedBorderSide.top)) {
      _drawDashedArc(canvas, rect, -3.14159 / 2, sweepAngle, paint);
    }
    if (sides.contains(DottedBorderSide.right)) {
      _drawDashedArc(canvas, rect, 0, sweepAngle, paint);
    }
    if (sides.contains(DottedBorderSide.bottom)) {
      _drawDashedArc(canvas, rect, 3.14159 / 2, sweepAngle, paint);
    }
    if (sides.contains(DottedBorderSide.left)) {
      _drawDashedArc(canvas, rect, 3.14159, sweepAngle, paint);
    }
  }

  void _drawRectangularBorder(Canvas canvas, Size size, Paint paint) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    // Create paths for each side
    if (sides.contains(DottedBorderSide.top)) {
      final topPath = Path();
      
      // Start from top-left corner (after radius)
      if (rrect.tlRadiusX > 0) {
        topPath.moveTo(0, rrect.tlRadiusY);
        topPath.arcToPoint(
          Offset(rrect.tlRadiusX, 0),
          radius: Radius.circular(rrect.tlRadiusX),
        );
      } else {
        topPath.moveTo(0, 0);
      }
      
      // Draw top line
      topPath.lineTo(size.width - rrect.trRadiusX, 0);
      
      // Handle top-right corner
      if (rrect.trRadiusX > 0) {
        topPath.arcToPoint(
          Offset(size.width, rrect.trRadiusY),
          radius: Radius.circular(rrect.trRadiusX),
        );
      }
      
      _drawDashedPath(canvas, topPath, paint);
    }

    if (sides.contains(DottedBorderSide.right)) {
      final rightPath = Path();
      
      // Start from top-right corner (after radius)
      if (rrect.trRadiusY > 0) {
        rightPath.moveTo(size.width, rrect.trRadiusY);
      } else {
        rightPath.moveTo(size.width, 0);
      }
      
      // Draw right line
      rightPath.lineTo(size.width, size.height - rrect.brRadiusY);
      
      // Handle bottom-right corner
      if (rrect.brRadiusY > 0) {
        rightPath.arcToPoint(
          Offset(size.width - rrect.brRadiusX, size.height),
          radius: Radius.circular(rrect.brRadiusY),
        );
      }
      
      _drawDashedPath(canvas, rightPath, paint);
    }

    if (sides.contains(DottedBorderSide.bottom)) {
      final bottomPath = Path();
      
      // Start from bottom-right corner (after radius)
      if (rrect.brRadiusX > 0) {
        bottomPath.moveTo(size.width, size.height - rrect.brRadiusY);
        bottomPath.arcToPoint(
          Offset(size.width - rrect.brRadiusX, size.height),
          radius: Radius.circular(rrect.brRadiusX),
        );
      } else {
        bottomPath.moveTo(size.width, size.height);
      }
      
      // Draw bottom line
      bottomPath.lineTo(rrect.blRadiusX, size.height);
      
      // Handle bottom-left corner
      if (rrect.blRadiusX > 0) {
        bottomPath.arcToPoint(
          Offset(0, size.height - rrect.blRadiusY),
          radius: Radius.circular(rrect.blRadiusX),
        );
      }
      
      _drawDashedPath(canvas, bottomPath, paint);
    }

    if (sides.contains(DottedBorderSide.left)) {
      final leftPath = Path();
      
      // Start from bottom-left corner (after radius)
      if (rrect.blRadiusY > 0) {
        leftPath.moveTo(0, size.height - rrect.blRadiusY);
      } else {
        leftPath.moveTo(0, size.height);
      }
      
      // Draw left line
      leftPath.lineTo(0, rrect.tlRadiusY);
      
      // Handle top-left corner
      if (rrect.tlRadiusY > 0) {
        leftPath.arcToPoint(
          Offset(rrect.tlRadiusX, 0),
          radius: Radius.circular(rrect.tlRadiusY),
        );
      }
      
      _drawDashedPath(canvas, leftPath, paint);
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final length = dashWidth;
        final tangent = pathMetric.getTangentForOffset(distance);
        final nextDistance = (distance + length).clamp(0.0, pathMetric.length);
        final nextTangent = pathMetric.getTangentForOffset(nextDistance);
        
        if (tangent != null && nextTangent != null) {
          canvas.drawLine(tangent.position, nextTangent.position, paint);
        }
        distance += dashWidth + dashSpace;
      }
    }
  }

  void _drawDashedArc(Canvas canvas, Rect rect, double startAngle, double sweepAngle, Paint paint) {
    final radius = rect.width / 2;
    final pie = 3.14159;
    final circumference = 2 * pie * radius;
    final arcLength = (sweepAngle / (2 * pie)) * circumference;
    
    double currentAngle = startAngle;
    double distance = 0.0;
    
    while (distance < arcLength) {
      final dashAngle = (dashWidth / radius);
      final endAngle = currentAngle + dashAngle;
      
      canvas.drawArc(rect, currentAngle, dashAngle, false, paint);
      
      currentAngle = endAngle + (dashSpace / radius);
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant DottedBorder oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.isCircle != isCircle ||
        !oldDelegate.sides.containsAll(sides) ||
        !sides.containsAll(oldDelegate.sides);
  }
}