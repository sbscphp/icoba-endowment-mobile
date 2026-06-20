import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_theme/custom_color_scheme.dart';

class ScreenTitle extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final Color? titleColor;
  final Color? subtitleColor;

  const ScreenTitle({
    super.key,
    this.title,
    this.subtitle,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleColor,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final hText = title ?? '';
    final sS = subtitle ?? '';
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              hText,
              style: textTheme.bodyLarge?.copyWith(
                color: titleColor ?? colorScheme.textPrimary,
                fontSize: (titleFontSize ?? 18).sp,
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (sS.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              sS,
              style: textTheme.bodyLarge?.copyWith(
                color: subtitleColor ?? colorScheme.textTertiary,
                fontSize: (subtitleFontSize ?? 14).sp,
                letterSpacing: 0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
