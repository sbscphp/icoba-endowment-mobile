import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav_screens/home.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav_screens/leaderboard.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav_screens/portfolio.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav_screens/profile.dart';

import '../../core/constants/app_theme/custom_color_scheme.dart';
import '../widgets/bottom_nav_items.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  List<Widget> screens = [
    Home(),
    Leaderboard(),
    Portfolio(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        extendBody: true,
        // extendBodyBehindAppBar: false,
        // appBar: AppBar(
        //   title: Row(
        //     children: [
        //       Text(
        //         "Home",
        //         style: textTheme.bodyLarge?.copyWith(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 18.sp,
        //         ),
        //       ),
        //     ],
        //   ),
        //   centerTitle: false,

        //   actions: [
        //     CustomAssetViewer(asset: AppAsset.notification),
        //     SizedBox(width: 8.w),
        //     DisplayImage(
        //       image: null,
        //       firstName: "A",
        //       lastName: "B",
        //       size: 28,
        //       fontSize: 10.sp,
        //     ),
        //     SizedBox(width: 16.w),
        //   ],
        // ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h),
          child: Container(
            padding: EdgeInsets.only(top: 6.h, bottom: 6.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.whiteText,
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withCustomOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(bottomNavItems().length, (index) {
                final item = bottomNavItems()[index];
                final isSelected = currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorPath.athensGrey4
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 6.h,
                      ),
                      margin: EdgeInsets.only(left: 4, right: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // icon
                          IconTheme(
                            data: IconThemeData(
                              color: isSelected
                                  ? colorScheme.textPrimary
                                  : colorScheme.textSecondary,
                              size: 24.r,
                            ),
                            child: isSelected ? item.activeIcon : item.icon,
                          ),
                          SizedBox(height: 4.h),
                          // label
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                item.label ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? colorScheme.textPrimary
                                      : colorScheme.textTertiary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        body: IndexedStack(index: currentIndex, children: screens),
        // Container(
        //   color: ColorPath.athensGrey4,
        //   width: double.infinity,
        //   height: double.infinity,
        //   child: Column(children: [Text("Hello")]),
        // ),
      ),
    );
  }
}
