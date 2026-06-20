import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import '../../core/utilities/extensions/color_extensions.dart';
import 'leading_icon.dart';
import 'screen_title.dart';

class DonationHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const DonationHeader({super.key, this.title = "", this.subtitle = ""});

  @override
  Widget build(BuildContext context) {
    return IcobaContainer(
      width: double.infinity,
      borderRadius: BorderRadius.circular(16.r),
      padding: EdgeInsets.all(24.w),
      image: DecorationImage(
        image: AssetImage(AppAsset.donation),
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(
          ColorPath.brandColor.withCustomOpacity(.5),
          BlendMode.srcOver,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeadingIcon(addPadding: false),
          SizedBox(height: 40.h),
          ScreenTitle(
            title: title,
            subtitle: subtitle,
            titleColor: ColorPath.white,
            titleFontSize: 18.sp,
            subtitleColor: ColorPath.white,
            subtitleFontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}
