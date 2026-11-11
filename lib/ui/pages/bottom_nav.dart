import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/bottom_nav_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/dashboard_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/events_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/transactions_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:upgrader/upgrader.dart';

import '../../core/constants/app_theme/custom_color_scheme.dart';
import '../../core/data/view_models/user/user_vm.dart';
import '../widgets/bottom_nav_items.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  @override
  void initState() {
    final userVm = ref.read(userViewModel);
    final dashboardVm = ref.read(dashboardViewModel);
    final donationVm = ref.read(donationViewModel);
    final eventsVm = ref.read(eventsViewModel);
    final transactionsVm = ref.read(transactionsViewModel);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //toggle logged in flag to true
      // ref.read(inactivityListenerViewModel).userLoggedIn = true;

      //fetch user profile details
      userVm.getUserProfile();

      //fetch dashboard Details
      dashboardVm.getDashboardSummary();
      //fetch events
      eventsVm.getEvents();

      //get recent donations
      dashboardVm.getRecentDonations();
      //get transactions
      transactionsVm.getTransactions();
      //Funds Data
      dashboardVm.getFundsData();
      //User recognitions
      userVm.getRecognitions();
      //User Pledges
      donationVm.getPledges();
    });
    //init push notification listeners
    //FirebaseMessagingUtils.pushNotificationListenerInit(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(bottomNavViewModel);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        extendBody: true,
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
                final isSelected = vm.currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      vm.setCurrentIndex(index);
                      setState(() {});
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
        body: UpgradeAlert(
          dialogStyle: Platform.isAndroid
              ? UpgradeDialogStyle.material
              : UpgradeDialogStyle.cupertino,
          child: IndexedStack(index: vm.currentIndex, children: vm.screens),
        ),
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
