import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_tab_bar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/display_image.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donor.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

import '../../widgets/notification_icon.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    //init tab controller
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Text(
              "Leaderboard",
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomTabBar(
              context: context,
              controller: _controller,
              tabTitles: ["Donations", "Pledges"],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [Donations(), Pledges()],
            ),
          ),
        ],
      ),
    );
  }
}

class Donations extends StatelessWidget {
  const Donations({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: ColorPath.athensGrey4,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
      child: IcobaContainer(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (1 + 1 == 2)
                Column(
                  children: [
                    IcobaContainer(
                      border: Border.all(color: ColorPath.primaryYellow),
                      borderRadius: BorderRadius.circular(16.r),
                      padding: EdgeInsets.all(16.h),
                      bgColor: ColorPath.primaryYellow.withCustomOpacity(.1),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAssetViewer(
                            asset: AppAsset.first,
                            useColorFilter: false,
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            children: [
                              Text("Set ‘95", style: textTheme.bodySmall),
                              Text(
                                "₦15 m",
                                style: textTheme.bodyLarge?.copyWith(
                                  fontFamily: "Fraunces",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: IcobaContainer(
                            border: Border.all(color: ColorPath.indigo),
                            borderRadius: BorderRadius.circular(16.r),
                            padding: EdgeInsets.all(16.h),
                            bgColor: ColorPath.indigo.withCustomOpacity(.1),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomAssetViewer(
                                  asset: AppAsset.second,
                                  useColorFilter: false,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  children: [
                                    Text("Set ‘95", style: textTheme.bodySmall),
                                    Text(
                                      "₦12 m",
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontFamily: "Fraunces",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: IcobaContainer(
                            border: Border.all(color: ColorPath.lightBlue),
                            borderRadius: BorderRadius.circular(16.r),
                            padding: EdgeInsets.all(16.h),
                            bgColor: ColorPath.lightBlue.withCustomOpacity(.1),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomAssetViewer(
                                  asset: AppAsset.third,
                                  useColorFilter: false,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  children: [
                                    Text("Set ‘95", style: textTheme.bodySmall),
                                    Text(
                                      "₦10 m",
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontFamily: "Fraunces",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),

              //??SearchBar and Filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.r),
                        border: Border.all(color: ColorPath.athensGrey9),
                      ),
                      child: TextField(
                        cursorColor: ColorPath.brandColor,
                        cursorHeight: 15.h,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.search),
                          border: InputBorder.none,
                          hintText: "Search donors",
                          hintStyle: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.textTertiary,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorPath.athensGrey9),
                    ),
                    child: Icon(Icons.filter_list),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              1 + 1 == 2
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return IcobaContainer(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 16.h,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: ColorPath.athensGrey9),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPath.primaryYellow
                                      .withCustomOpacity(.4),
                                ),
                                child: Center(
                                  child: Text(
                                    "1st",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: ColorPath.brandColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  "Set ‘95",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.textPrimary,
                                  ),
                                ),
                              ),
                              NairaDisplay(
                                amount: 120000,
                                fontSize: 12.sp,
                                color: ColorPath.brandColor,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: 13,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Donor();
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: 3,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pledges extends StatelessWidget {
  const Pledges({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: ColorPath.athensGrey4,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
      child: IcobaContainer(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (1 + 1 == 2)
                Column(
                  children: [
                    IcobaContainer(
                      border: Border.all(color: ColorPath.primaryYellow),
                      borderRadius: BorderRadius.circular(16.r),
                      padding: EdgeInsets.all(16.h),
                      bgColor: ColorPath.primaryYellow.withCustomOpacity(.1),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAssetViewer(
                            asset: AppAsset.first,
                            useColorFilter: false,
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            children: [
                              Text("Set ‘95", style: textTheme.bodySmall),
                              Text(
                                "₦15 m",
                                style: textTheme.bodyLarge?.copyWith(
                                  fontFamily: "Fraunces",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: IcobaContainer(
                            border: Border.all(color: ColorPath.indigo),
                            borderRadius: BorderRadius.circular(16.r),
                            padding: EdgeInsets.all(16.h),
                            bgColor: ColorPath.indigo.withCustomOpacity(.1),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomAssetViewer(
                                  asset: AppAsset.second,
                                  useColorFilter: false,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  children: [
                                    Text("Set ‘95", style: textTheme.bodySmall),
                                    Text(
                                      "₦12 m",
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontFamily: "Fraunces",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: IcobaContainer(
                            border: Border.all(color: ColorPath.lightBlue),
                            borderRadius: BorderRadius.circular(16.r),
                            padding: EdgeInsets.all(16.h),
                            bgColor: ColorPath.lightBlue.withCustomOpacity(.1),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomAssetViewer(
                                  asset: AppAsset.third,
                                  useColorFilter: false,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  children: [
                                    Text("Set ‘95", style: textTheme.bodySmall),
                                    Text(
                                      "₦10 m",
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontFamily: "Fraunces",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),

              //??SearchBar and Filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.r),
                        border: Border.all(color: ColorPath.athensGrey9),
                      ),
                      child: TextField(
                        cursorColor: ColorPath.brandColor,
                        cursorHeight: 15.h,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.search),
                          border: InputBorder.none,
                          hintText: "Search donors",
                          hintStyle: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.textTertiary,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorPath.athensGrey9),
                    ),
                    child: Icon(Icons.filter_list),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              1 + 1 == 2
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return IcobaContainer(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 16.h,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: ColorPath.athensGrey9),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPath.primaryYellow
                                      .withCustomOpacity(.4),
                                ),
                                child: Center(
                                  child: Text(
                                    "1st",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: ColorPath.brandColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  "Set ‘95",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.textPrimary,
                                  ),
                                ),
                              ),
                              NairaDisplay(
                                amount: 120000,
                                fontSize: 12.sp,
                                color: ColorPath.brandColor,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: 13,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Donor();
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: 3,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
