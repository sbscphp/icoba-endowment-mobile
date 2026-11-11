import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/leaderboard_vm.dart';
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
    final leaderboardVm = ref.watch(leaderboardViewModel);

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
                      leaderboardVm.selectedDonationViewType = "donors";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: leaderboardVm.selectedDonationViewType == "donors"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: leaderboardVm.selectedDonationViewType == "donors"
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
                      leaderboardVm.selectedDonationViewType = "sets";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: leaderboardVm.selectedDonationViewType == "sets"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: leaderboardVm.selectedDonationViewType == "sets"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("Alumni set"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Clickable(
                  onPressed: () {
                    setState(() {
                      leaderboardVm.selectedDonationViewType = "houses";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: leaderboardVm.selectedDonationViewType == "houses"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: leaderboardVm.selectedDonationViewType == "houses"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("Houses"),
                  ),
                ),
              ),

              SizedBox(width: 8.w),
              Expanded(child: SizedBox()),
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

class _LeaderboardPledgeFilterBsState
    extends ConsumerState<LeaderboardPledgeFilterBs> {
  @override
  Widget build(BuildContext context) {
    final leaderboardVm = ref.watch(leaderboardViewModel);

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
                      leaderboardVm.selectedPledgeViewType = "donors";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: leaderboardVm.selectedPledgeViewType == "donors"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: leaderboardVm.selectedPledgeViewType == "donors"
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
                      leaderboardVm.selectedPledgeViewType = "sets";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: leaderboardVm.selectedPledgeViewType == "sets"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: leaderboardVm.selectedPledgeViewType == "sets"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("Alumni set"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Clickable(
                  onPressed: () {
                    setState(() {
                      leaderboardVm.selectedPledgeViewType = "houses";
                    });
                  },
                  child: IcobaContainer(
                    bgColor: leaderboardVm.selectedPledgeViewType == "houses"
                        ? ColorPath.iceBlue
                        : null,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    border: Border.all(
                      color: leaderboardVm.selectedPledgeViewType == "houses"
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                    ),
                    child: Text("Houses"),
                  ),
                ),
              ),

              SizedBox(width: 8.w),
              Expanded(child: SizedBox()),
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
