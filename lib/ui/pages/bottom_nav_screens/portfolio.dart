import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/display_image.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donor.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Text(
              "Portfolio",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
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
            //INFO CARD
            IcobaContainer(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DisplayImage(
                        image: null,
                        firstName: "A",
                        lastName: "B",
                        size: 56,
                        fontSize: 10.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sheriff Olusanya Jacobs",
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "sherif@gmail.com\n199/20 set",
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (1 + 1 == 2)
                        CustomAssetViewer(
                          asset: AppAsset.bronzeBadge,
                          height: 56.h,
                          width: 56.w,
                          useColorFilter: false,
                        ),
                    ],
                  ),

                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 70.h,
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
                                border: Border.all(
                                  color: ColorPath.primaryYellow,
                                ),
                                bgColor: ColorPath.primaryYellow
                                    .withCustomOpacity(.1),
                                borderRadius: BorderRadius.circular(12.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Donations by you",
                                      style: textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 8.w),
                                    NairaDisplay(amount: 0, fontSize: 16),
                                    // Text(
                                    //   "0",
                                    //   style: textTheme.bodyLarge?.copyWith(
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 16.w),
                            itemCount: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //RECOGNITION
            if (1 + 1 == 2)
              IcobaContainer(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recognition",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // if (1 + 1 == 3)
                        //   Clickable(
                        //     onPressed: () {},
                        //     child: Text(
                        //       "View all",
                        //       style: textTheme.bodyMedium?.copyWith(
                        //         fontWeight: FontWeight.bold,
                        //         color: colorScheme.brandColor,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    1 + 1 == 3
                        ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: EmptyState(
                              asset: AppAsset.empty,
                              title: "You are yet to get a recognition",
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 16.h),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Certificate of Endowment "),
                                        SizedBox(height: 4.h),
                                        Row(
                                          children: [
                                            CustomAssetViewer(
                                              asset: AppAsset.calendar,
                                              useColorFilter: false,
                                              height: 12,
                                              width: 12,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              DateUtilities.monthDayYear(
                                                date: DateTime.now(),
                                              ),
                                              style: textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: colorScheme
                                                        .textTertiary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IcobaTag(),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => Column(
                              children: [
                                SizedBox(height: 6.h),
                                Divider(color: ColorPath.athensGrey8),
                                SizedBox(height: 6.h),
                              ],
                            ),
                            itemCount: 3,
                          ),
                  ],
                ),
              ),
            //DONATION HISTORY
            if (1 + 1 == 2)
              IcobaContainer(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your donation history",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // if (1 + 1 == 3)
                        //   Clickable(
                        //     onPressed: () {},
                        //     child: Text(
                        //       "View all",
                        //       style: textTheme.bodyMedium?.copyWith(
                        //         fontWeight: FontWeight.bold,
                        //         color: colorScheme.brandColor,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    1 + 1 == 3
                        ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: EmptyState(
                              asset: AppAsset.empty,
                              title: "You are yet to make a donation",
                              onPressed: () {},
                              ctaText: "Donate now",
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 16.h),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Donor();
                            },
                            separatorBuilder: (context, index) => Column(
                              children: [
                                SizedBox(height: 6.h),
                                Divider(color: ColorPath.athensGrey8),
                                SizedBox(height: 6.h),
                              ],
                            ),
                            itemCount: 3,
                          ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
