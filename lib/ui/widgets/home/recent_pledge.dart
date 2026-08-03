import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
// import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
// import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donor.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/listview_items/Screens/recent_pledges.dart'
    show RecentPledges;

import '../../../core/data/enum/view_state.dart';
import '../error_state.dart';
// import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class RecentPledge extends ConsumerStatefulWidget {
  const RecentPledge({super.key});

  @override
  ConsumerState<RecentPledge> createState() => _RecentPledgeState();
}

class _RecentPledgeState extends ConsumerState<RecentPledge> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _fetchData();
  //   });
  //   super.initState();
  // }

  void _fetchData() {
    ref.read(donationViewModel).getPledges();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final vm = ref.watch(donationViewModel);
    final userVm = ref.watch(userViewModel);

    return IcobaContainer(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 16.h),
      bgColor: colorScheme.whiteText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your pledges History",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (vm.pledges.length > 5)
                Clickable(
                  onPressed: () {
                    pushNavigation(
                      context: context,
                      widget: RecentPledges(),
                      routeName: NamedRoutes.recentPledges,
                    );
                  },
                  child: Text(
                    "View all",
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.brandColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Builder(
            builder: (context) {
              if (vm.dashboardState == ViewState.busy) {
                return AppLoader();
              }
              if (vm.dashboardState == ViewState.error) {
                return ErrorState(
                  message: vm.message,
                  onPressed: () {
                    _fetchData();
                  },
                );
              }
              if (vm.pledges.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: EmptyState(
                    asset: AppAsset.empty,
                    title: "You are yet to make a pledge",
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = vm.pledges[index];
                  return Donor(
                    amount: double.tryParse(data.committedAmount ?? "0"),
                    currencyCode: data.currency,
                    donorName: data.campaign?.name,
                    setNumber: userVm.setName,
                    showTagRow: false,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: vm.pledges.length >= 5 ? 5 : vm.pledges.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
