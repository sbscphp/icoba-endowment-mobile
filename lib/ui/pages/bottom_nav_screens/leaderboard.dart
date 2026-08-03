import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/bottom_nav_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard_vm.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_tab_bar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/display_image.dart';
import 'package:icoba_endowment_mobile/ui/widgets/leaderboard_donations.dart';
import 'package:icoba_endowment_mobile/ui/widgets/leaderboard_pledges.dart';
// import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/user/user_vm.dart';
import '../../widgets/notification_icon.dart';

class Leaderboard extends ConsumerStatefulWidget {
  const Leaderboard({super.key});

  @override
  ConsumerState<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends ConsumerState<Leaderboard>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    //init tab controller
    _controller = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  void _fetchData() {
    final dashboardVm = ref.read(dashboardViewModel);

    //fetch leaderboard DONATIONS Donors
    dashboardVm.getLeaderBoardDonors();

    //fetch leaderboard DONATIONS sets
    dashboardVm.getLeaderBoardSets(sortDirection: 'desc');

    //fetch leaderboard PLEDGES Donors[pledges]
    dashboardVm.getLeaderBoardDonors(scope: "pledges");

    //fetch leaderboard PLEDGES sets[pledges]
    dashboardVm.getLeaderBoardSets(scope: "pledges", sortDirection: 'desc');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userVm = ref.watch(userViewModel);
    // final dashboardVm = ref.watch(dashboardViewModel);

    // final colorScheme = Theme.of(context).colorScheme;

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
              children: [LeaderboardDonations(), LeaderboardPledges()],
            ),
          ),
        ],
      ),
    );
  }
}
