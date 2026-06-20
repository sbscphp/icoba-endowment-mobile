import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';

import '../../core/constants/color_path.dart';

class EmptyState extends StatelessWidget {
  final String asset;
  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;
  final String? ctaText;
  const EmptyState({
    super.key,
    required this.asset,
    required this.title,
    this.subtitle,
    this.onPressed,
    this.ctaText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAssetViewer(
            asset: asset,
            height: 120.h,
            width: 120.w,
            useColorFilter: false,
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.textPrimary,
            ),
          ),
          if (subtitle != null)
            Padding(
              padding: EdgeInsets.only(left: 59.w, right: 59.w, top: 8.h),
              child: Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (onPressed != null)
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    horizontal: 24.w,
                  ),
                  elevation: 0,
                  backgroundColor: ColorPath.brandColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Text(
                  ctaText ?? 'Add New',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ), // Button's label
              ),
            ),
        ],
      ),
    );
  }
}
