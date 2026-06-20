import 'package:flutter/material.dart';

class DonutRangeSliderThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
  final double holeRadius;

  DonutRangeSliderThumbShape({this.thumbRadius = 12.0, this.holeRadius = 4.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }


  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool? isEnabled,
        bool? isDiscrete,
        // required TextPainter labelPainter,
        // required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        TextDirection? textDirection,
        // required double value,
        Thumb? thumb,
        bool isOnTop = false,
        bool isPressed = false,
      }) {
    final Canvas canvas = context.canvas;

    // Draw the outer circle
    final Paint outerCirclePaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, outerCirclePaint);

    // Draw the inner circle to create the donut hole
    final Paint innerCirclePaint = Paint()
      ..color = sliderTheme.overlayColor ?? Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, holeRadius, innerCirclePaint);
  }
}