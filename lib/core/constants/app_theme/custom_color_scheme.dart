import 'package:flutter/material.dart';
import '../color_path.dart';

extension CustomColorScheme on ColorScheme {
  // Custom text color variants
  Color get brandColor =>
      brightness == Brightness.light ? ColorPath.brandColor : Colors.white;

  //text
  Color get textPrimary =>
      brightness == Brightness.light ? ColorPath.ebonyBlack : Colors.white;
  Color get textSecondary =>
      brightness == Brightness.light ? ColorPath.fiordGrey : Colors.white;
  Color get textTertiary =>
      brightness == Brightness.light ? ColorPath.gullGrey : Colors.white;

  Color get whiteText =>
      brightness == Brightness.light ? Colors.white : Colors.black;
  Color get redText => brightness == Brightness.light
      ? ColorPath.crimsonRed
      : const Color.fromARGB(255, 255, 89, 95);
  Color get greenText => ColorPath.funGreen;

  Color get iconColor =>
      brightness == Brightness.light ? ColorPath.brandColor : ColorPath.white;
  Color get containerColor => brightness == Brightness.light
      ? ColorPath.white
      : ColorPath.midnightBlue;

  // Color get textSecondary => brightness == Brightness.light ? Colors.black54 : Colors.white70;
  // Color get textTertiary => brightness == Brightness.light ? Colors.black38 : Colors
}
