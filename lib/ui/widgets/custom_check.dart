import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';

class CustomCheck extends StatelessWidget {
  final bool isChecked;
  const CustomCheck({super.key, this.isChecked = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      width: 16.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: isChecked ? ColorPath.iceBlue : null,
        border: Border.all(
          color: isChecked ? ColorPath.brandColor : ColorPath.athensGrey4,
        ),
      ),
      child: isChecked
          ? Center(
              child: Icon(Icons.done, size: 14, fontWeight: FontWeight.bold),
            )
          : null,
    );
  }
}
