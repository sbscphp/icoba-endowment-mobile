import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_path.dart';

class BsHeader extends StatelessWidget {
  const BsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 75.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: ColorPath.athensGrey4,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            SizedBox(height: 4.h),
            Divider(color: ColorPath.athensGrey4),
          ],
        );
  }
}