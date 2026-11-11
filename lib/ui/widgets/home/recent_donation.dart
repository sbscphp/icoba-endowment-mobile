import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
// import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
// import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
// import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/listview_items/recent_donor_item.dart';

import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/dashboard/dashboard_vm.dart';
import '../error_state.dart';

// import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class RecentDonation extends ConsumerStatefulWidget {
  const RecentDonation({super.key});

  @override
  ConsumerState<RecentDonation> createState() => _RecentDonationState();
}

class _RecentDonationState extends ConsumerState<RecentDonation> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _fetchData();
  //   });
  //   super.initState();
  // }

  // void _fetchData() {
  //   ref.read(dashboardViewModel).getTransactions();
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final dashboardVm = ref.watch(dashboardViewModel);
    // final userVm = ref.watch(userViewModel);

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
                "Recent donations",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // if (dashboardVm.transactions.length > 5)
              //   Clickable(
              //     onPressed: () {
              //       pushNavigation(
              //         context: context,
              //         widget: RecentDonations(),
              //         routeName: NamedRoutes.recentDonations,
              //       );
              //     },
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
          SizedBox(height: 12.h),
          Builder(
            builder: (context) {
              if (dashboardVm.secondState == ViewState.busy) {
                return AppLoader();
              }
              if (dashboardVm.secondState == ViewState.error) {
                // if (true) {
                return Center(
                  child: ErrorState(
                    message: dashboardVm.message,
                    onPressed: () async {
                      dashboardVm.getRecentDonations();
                    },
                  ),
                );
              }
              if (dashboardVm.donors.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: EmptyState(
                    asset: AppAsset.empty,
                    title: "We are yet to record any Donation",
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = dashboardVm.donors[index];
                  return RecentDonorItem(donor: data);
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: dashboardVm.donors.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
