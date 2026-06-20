import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomTabIndicator extends Decoration {
//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _CustomTabIndicatorPainter();
//   }
// }

// class _CustomTabIndicatorPainter extends BoxPainter {
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     final Paint paint = Paint();
//     paint.color = Colors.white;
//     paint.style = PaintingStyle.fill;

//     final Rect rect =
//         Offset(offset.dx, offset.dy) &
//         Size(configuration.size!.width, configuration.size!.height);
//     final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(100.r));
//     canvas.drawRRect(rRect, paint);
//   }
// }

class CustomTabIndicator extends Decoration {
  final Color bgColor;
  final Color? borderColor;
  final double radius;
  final double borderWidth;

  const CustomTabIndicator({
    required this.bgColor,
    this.borderColor,
    this.radius = 3,
    this.borderWidth = 2.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter(
      bgColor: bgColor,
      borderColor: borderColor,
      radius: radius,
      borderWidth: borderWidth,
    );
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  final Color bgColor;
  final Color? borderColor;
  final double radius;
  final double borderWidth;

  _CustomTabIndicatorPainter({
    required this.bgColor,
    required this.borderColor,
    required this.radius,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Draw background (optional)
    final Paint bgPaint = Paint();
    bgPaint.color = bgColor;
    bgPaint.style = PaintingStyle.fill;

    final Rect rect =
        Offset(offset.dx, offset.dy) &
        Size(configuration.size!.width, configuration.size!.height);
    final RRect rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(radius.r),
    );
    canvas.drawRRect(rRect, bgPaint);

    // Draw bottom border/underline
    if (borderColor != null) {
      final Paint borderPaint = Paint();
      borderPaint.color = borderColor!;
      borderPaint.strokeWidth = borderWidth;
      borderPaint.style = PaintingStyle.stroke;

      // Draw line at the bottom of the tab
      final double startX = offset.dx;
      final double endX = offset.dx + configuration.size!.width;
      final double y = offset.dy + configuration.size!.height;

      canvas.drawLine(Offset(startX, y), Offset(endX, y), borderPaint);
    }
  }
}
