import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/display_image.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/fund_update.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/quicklinks.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/recent_donation.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/notification_icon.dart';

import '../../../core/constants/app_asset.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Text(
              "Home",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          NotificationIcon(),
          SizedBox(width: 8.w),
          DisplayImage(
            image: null,
            firstName: "A",
            lastName: "B",
            size: 28,
            fontSize: 10.sp,
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Container(
        color: ColorPath.athensGrey4,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: ListView(
          padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
          children: [
            //Welcomback Widget
            IcobaContainer(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back, Sheriff",
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Your contribution is recognized and appreciated.\nThank you!",
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.textTertiary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 84.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return IcobaContainer(
                                width: MediaQuery.of(context).size.width * .55,
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 12.w,
                                ),
                                border: Border.all(color: ColorPath.brandColor),
                                bgColor: ColorPath.brandColor.withCustomOpacity(
                                  .1,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No of times donated",
                                      style: textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 8.w),
                                    Text(
                                      "0",
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 16.w),
                            itemCount: 3,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Container(
                              height: 8.h,
                              width: 17.w,
                              margin: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: index == 1
                                    ? ColorPath.brandColor
                                    : ColorPath.athensGrey3,
                              ),
                            ),
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Quick Actions Widget
            QuickLinks(),
            //Fund Update Widget
            FundUpdate(),
            //Fund Update Widget
            RecentDonation(),
            SizedBox(height: 75.h),
          ],
        ),
      ),
    );
  }
}
