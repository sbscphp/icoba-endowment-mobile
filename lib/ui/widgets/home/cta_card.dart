import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

import '../../../core/constants/color_path.dart';
import '../clickable.dart';

class CTACard extends StatelessWidget {
  final void Function()? onPressed;
  final String asset;
  final String ctaText;
  final double? verticalPadding;
  final bool isLoading;
  const CTACard({
    super.key,
    required this.asset,
    required this.ctaText,
    this.verticalPadding,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Clickable(
      onPressed: onPressed,
      child: IcobaContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 7.w,
          vertical: verticalPadding ?? 12.h,
        ),
        bgColor: ColorPath.athensGrey8,
        child: Column(
          children: [
            CustomAssetViewer(asset: asset, useColorFilter: false),
            SizedBox(height: 8.h),
            FittedBox(
              child: Text(
                ctaText,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: ColorPath.oxfordBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
