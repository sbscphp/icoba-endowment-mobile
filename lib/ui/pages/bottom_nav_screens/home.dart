import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/bottom_nav_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/display_image.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/fund_update.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/quicklinks.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/recent_donation.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/recent_pledge.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';
import 'package:icoba_endowment_mobile/ui/widgets/notification_icon.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  ScrollController controller = ScrollController();
  int currentPage = 0;

  @override
  void initState() {
    controller.addListener(_onScroll);

    super.initState();
  }

  void _onScroll() {
    // Calculate current page based on scroll position
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * .45;
    final double separatorWidth = 16.w;
    final double itemWidth = cardWidth + separatorWidth;

    final int page = (controller.offset / itemWidth).round();

    if (page != currentPage && page >= 0 && page < 3) {
      setState(() {
        currentPage = page;
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onScroll);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userVm = ref.watch(userViewModel);
    final dashboardVm = ref.watch(dashboardViewModel);

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
            onPressed: () {
              ref.read(bottomNavViewModel).setCurrentIndex(3);
            },
            firstName: userVm.firstName,
            lastName: userVm.lastName,
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
                    "Welcome back, ${userVm.firstName}",
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
                            controller: controller,
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
                                  color: getSummaryColor(index),
                                ),
                                bgColor: getSummaryColor(
                                  index,
                                ).withCustomOpacity(.1),
                                borderRadius: BorderRadius.circular(12.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getSummaryHeader(index),
                                      style: textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 8.w),
                                    if (index == 0)
                                      Flexible(
                                        child: Text(
                                          "${dashboardVm.donationCount}",
                                          style: textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    if (index == 1)
                                      Flexible(
                                        child: NairaDisplay(
                                          amount: dashboardVm.totalDonation,
                                          fontSize: 14.sp,
                                          textAlign: TextAlign.left,
                                          currencyCode: dashboardVm.currency,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (index == 2)
                                      Flexible(
                                        child: NairaDisplay(
                                          amount: dashboardVm.totalPledges,
                                          fontSize: 14.sp,
                                          textAlign: TextAlign.left,
                                          currencyCode: dashboardVm.currency,
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
                                color: index == currentPage
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

  String getSummaryHeader(int index) {
    switch (index) {
      case 0:
        return "No of times donated";
      case 1:
        return "Donations by you";
      case 2:
        return "Pledges by you";

      default:
        return "N/A";
    }
  }

  Color getSummaryColor(int index) {
    switch (index) {
      case 0:
        return ColorPath.brandColor;
      case 1:
        return ColorPath.primaryYellow;
      case 2:
        return ColorPath.sundownPink;

      default:
        return ColorPath.brandColor;
    }
  }
}
