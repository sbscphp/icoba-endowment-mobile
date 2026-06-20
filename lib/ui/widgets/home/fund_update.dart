import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_painter/custom_progress_bar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

class FundUpdate extends StatefulWidget {
  const FundUpdate({super.key});

  @override
  State<FundUpdate> createState() => _FundUpdateState();
}

class _FundUpdateState extends State<FundUpdate> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return IcobaContainer(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 16.h),
      bgColor: colorScheme.whiteText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fund Update",
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          IcobaContainer(
            padding: EdgeInsets.all(12.w),
            bgColor: ColorPath.athensGrey8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ICOBA School Donation ",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.brandColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TweenAnimationBuilder<double>(
                        // key: ValueKey(vm.percentage),
                        tween: Tween<double>(begin: 0.0, end: 40),
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return SizedBox(
                            width: double.infinity,
                            // height: 8.h,
                            child: CustomPaint(
                              painter: CustomProgressBar(
                                percentage: value,
                                backgroundColor: ColorPath.gullGrey.withValues(
                                  alpha: .2,
                                ),
                                strokeWidth: 8.w,
                                activeColor: ColorPath.primaryYellow,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text("40%", style: textTheme.bodySmall?.copyWith()),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  "₦12,000 of ₦16,000,000.",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.brandColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
