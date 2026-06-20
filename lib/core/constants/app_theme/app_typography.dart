import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_path.dart';

class AppTypography {
  // Standard body text sizes
  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );

  // For subheadings or prominent text
  static TextStyle titleSmall = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.normal,
  );

  // For titles or section headers
  static TextStyle titleMedium = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: ColorPath.brandColor,
  );
  static TextStyle titleLarge = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: ColorPath.brandColor,
  );
}
