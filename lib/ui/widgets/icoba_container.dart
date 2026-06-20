import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_theme/custom_color_scheme.dart';

class IcobaContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color? bgColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final DecorationImage? image;
  final BoxShape shape; 
  const IcobaContainer({
    super.key,
    this.boxShadow,
    this.height,
    this.borderRadius,
    this.border,
    this.bgColor,
    this.margin,
    required this.child,
    this.padding,
    this.width,
    this.gradient,
    this.image,
    this.shape = BoxShape.rectangle
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor ?? colorScheme.containerColor,
        border: border,
        gradient: gradient,
        boxShadow: boxShadow,
        image: image,
        shape: shape,
        borderRadius: shape != BoxShape.circle ? borderRadius ?? BorderRadius.all(Radius.circular(16.r)) : null,
      ),
      child: child,
    );
  }
}
