import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';

import '../icoba_container.dart';
import 'bottom_sheet_header.dart';

class LeaderboardFilterBs extends ConsumerStatefulWidget {
  const LeaderboardFilterBs({super.key});

  @override
  ConsumerState<LeaderboardFilterBs> createState() =>
      _LeaderboardFilterBsState();
}

class _LeaderboardFilterBsState extends ConsumerState<LeaderboardFilterBs> {
  @override
  Widget build(BuildContext context) {
    final dashboardVm = ref.watch(dashboardViewModel);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeader(headerTitle: 'Filter'),
          SizedBox(height: 15.h),
          Text("Donor type", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: Clickable(
                  onPressed: () {
                    setState(() {
                      dashboardVm.selectedDonationViewType = "donors";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: dashboardVm.selectedDonationViewType == "donors"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: dashboardVm.selectedDonationViewType == "donors"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("All donors"),
                  ),
                ),
              ),

              SizedBox(width: 8.w),
              Expanded(
                child: Clickable(
                  onPressed: () {
                    setState(() {
                      dashboardVm.selectedDonationViewType = "sets";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: dashboardVm.selectedDonationViewType == "sets"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: dashboardVm.selectedDonationViewType == "sets"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("Alumni set"),
                  ),
                ),
              ),
            ],
          ),

          //button
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () {
              popNavigation(context: context);
            },
            buttonText: "Confirm",
          ),
        ],
      ),
    );
  }
}




///Pledge
class LeaderboardPledgeFilterBs extends ConsumerStatefulWidget {
  const LeaderboardPledgeFilterBs({super.key});

  @override
  ConsumerState<LeaderboardPledgeFilterBs> createState() =>
      _LeaderboardPledgeFilterBsState();
}

class _LeaderboardPledgeFilterBsState extends ConsumerState<LeaderboardPledgeFilterBs> {
  @override
  Widget build(BuildContext context) {
    final dashboardVm = ref.watch(dashboardViewModel);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeader(headerTitle: 'Filter'),
          SizedBox(height: 15.h),
          Text("Donor type", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: Clickable(
                  onPressed: () {
                    setState(() {
                      dashboardVm.selectedPledgeViewType = "donors";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: dashboardVm.selectedPledgeViewType == "donors"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: dashboardVm.selectedPledgeViewType == "donors"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("All donors"),
                  ),
                ),
              ),

              SizedBox(width: 8.w),
              Expanded(
                child: Clickable(
                  onPressed: () {
                    setState(() {
                      dashboardVm.selectedPledgeViewType = "sets";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: dashboardVm.selectedPledgeViewType == "sets"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: dashboardVm.selectedPledgeViewType == "sets"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("Alumni set"),
                  ),
                ),
              ),
            ],
          ),

          //button
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () {
              popNavigation(context: context);
            },
            buttonText: "Confirm",
          ),
        ],
      ),
    );
  }
}
