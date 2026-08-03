import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/debouncer.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

import '../../core/constants/app_theme/custom_color_scheme.dart';
import '../../core/constants/color_path.dart';
import '../../core/data/enum/view_state.dart';
import '../../core/utilities/extensions/color_extensions.dart';
import 'app_loader.dart';
import 'bottom_sheets/base_bottom_sheet.dart';
import 'bottom_sheets/leaderboard_filter_bs.dart';
import 'clickable.dart';
import 'custom_svg.dart';
import 'donor.dart';
import 'listview_items/leaderboard_donor_item.dart';
import 'naira_display.dart';

class LeaderboardDonations extends ConsumerStatefulWidget {
  const LeaderboardDonations({super.key});

  @override
  ConsumerState<LeaderboardDonations> createState() =>
      _LeaderboardDonationsState();
}

class _LeaderboardDonationsState extends ConsumerState<LeaderboardDonations> {
  ScrollController scrollController = ScrollController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _setScrollListener();
      _donorScrollListener();
    });
  }

  void _setScrollListener() {
    final vm = ref.watch(dashboardViewModel);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //check paginated state
        if (vm.paginatedState != ViewState.error) {
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy &&
              vm.leaderBoardSets.length < vm.setPledgetotal) {
            //fetch more
            vm.getLeaderBoardSets(firstCall: false, sortDirection: 'desc');
          }
        }
      }
    });
  }

  void _donorScrollListener() {
    final vm = ref.watch(dashboardViewModel);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //check paginated state
        if (vm.paginatedState != ViewState.error) {
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy &&
              vm.leaderBoardSets.length < vm.donorPledgetotal &&
              vm.selectedDonationViewType != "sets") {
            //fetch more
            vm.getLeaderBoardDonors(firstCall: false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;
    final dashboardVm = ref.watch(dashboardViewModel);

    return Container(
      color: ColorPath.athensGrey4,
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
      child: IcobaContainer(
        padding: EdgeInsets.all(16.w),
        child: Builder(
          builder: (context) {
            if (dashboardVm.leaderboardState == ViewState.busy) {
              return AppLoader();
            }
            if (dashboardVm.leaderboardState == ViewState.error) {
              return ErrorState(
                message: dashboardVm.message,
                onPressed: () {
                  dashboardVm.getLeaderBoardDonors();
                },
              );
            }

            if (dashboardVm.leaderBoardDonors.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: EmptyState(
                  asset: AppAsset.empty,
                  title: "No Donations Yet",
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                if (dashboardVm.selectedDonationViewType == "sets") {
                  dashboardVm.getLeaderBoardSets(sortDirection: 'desc');
                } else {
                  dashboardVm.getLeaderBoardDonors();
                }
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                controller: scrollController,

                child: Column(
                  children: [
                    if (dashboardVm.selectedDonationViewType == "sets")
                      Column(
                        children: [
                          if (dashboardVm.setDonationOne != null)
                            IcobaContainer(
                              border: Border.all(
                                color: ColorPath.primaryYellow,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              padding: EdgeInsets.all(16.h),
                              bgColor: ColorPath.primaryYellow
                                  .withCustomOpacity(.1),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomAssetViewer(
                                    asset: AppAsset.first,
                                    useColorFilter: false,
                                  ),
                                  SizedBox(width: 8.w),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Set ${dashboardVm.setDonationOne?.set?.setNumber}",
                                          style: textTheme.bodySmall,
                                        ),
                                        NairaDisplay(
                                          amount:
                                              double.tryParse(
                                                dashboardVm
                                                        .setDonationOne
                                                        ?.amountInNgn ??
                                                    "0",
                                              ) ??
                                              0,
                                          isRoundUpAmount: true,
                                          fontFamily: "Fraunces",
                                        ),
                                        // Text(
                                        //   "₦15 m",
                                        //   style: textTheme.bodyLarge?.copyWith(
                                        //     fontFamily: "Fraunces",
                                        //   ),
                                        // ),
                                      ],
                                    ),
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
                                  bgColor: ColorPath.indigo.withCustomOpacity(
                                    .1,
                                  ),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomAssetViewer(
                                        asset: AppAsset.second,
                                        useColorFilter: false,
                                      ),
                                      SizedBox(width: 8.w),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Set ${dashboardVm.setDonationTwo?.set?.setNumber}",
                                              style: textTheme.bodySmall,
                                            ),
                                            NairaDisplay(
                                              amount:
                                                  double.tryParse(
                                                    dashboardVm
                                                            .setDonationTwo
                                                            ?.amountInNgn ??
                                                        "0",
                                                  ) ??
                                                  0,
                                              isRoundUpAmount: true,
                                              fontFamily: "Fraunces",
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: IcobaContainer(
                                  border: Border.all(
                                    color: ColorPath.lightBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                  padding: EdgeInsets.all(16.h),
                                  bgColor: ColorPath.lightBlue
                                      .withCustomOpacity(.1),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomAssetViewer(
                                        asset: AppAsset.third,
                                        useColorFilter: false,
                                      ),
                                      SizedBox(width: 8.w),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Set ${dashboardVm.setDonationThree?.set?.setNumber}",
                                              style: textTheme.bodySmall,
                                            ),
                                            NairaDisplay(
                                              amount:
                                                  double.tryParse(
                                                    dashboardVm
                                                            .setDonationThree
                                                            ?.amountInNgn ??
                                                        "0",
                                                  ) ??
                                                  0,
                                              isRoundUpAmount: true,
                                              fontFamily: "Fraunces",
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
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
                              onChanged: (value) {
                                _debouncer.performAction(
                                  action: () async {
                                    if (value.isEmpty) {
                                      setState(() {
                                        isSearch = false;
                                      });
                                      if (dashboardVm
                                              .selectedDonationViewType ==
                                          "sets") {
                                        dashboardVm.getLeaderBoardSets(
                                          sortDirection: 'desc',
                                          firstCall: false,
                                          isSearch: true,
                                        );
                                      } else {
                                        dashboardVm.getLeaderBoardDonors(
                                          firstCall: false,
                                          isSearch: true,
                                        );
                                      }
                                    } else {
                                      setState(() {
                                        isSearch = true;
                                      });
                                      if (dashboardVm
                                              .selectedDonationViewType ==
                                          "sets") {
                                        dashboardVm.getLeaderBoardSets(
                                          sortDirection: 'desc',
                                          firstCall: false,
                                          searchQuery: value,
                                          isSearch: true,
                                        );
                                      } else {
                                        dashboardVm.getLeaderBoardDonors(
                                          firstCall: false,
                                          searchQuery: value,
                                          isSearch: true,
                                        );
                                      }
                                    }
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.search),
                                border: InputBorder.none,
                                hintText:
                                    "Search ${dashboardVm.selectedDonationViewType}",
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
                        Clickable(
                          onPressed: () {
                            baseBottomSheet(
                              context: context,
                              content: LeaderboardFilterBs(),
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorPath.athensGrey9),
                            ),
                            child: Icon(Icons.filter_list),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),
                    dashboardVm.selectedDonationViewType == "sets"
                        ? ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final donorSet =
                                  dashboardVm.leaderBoardSets[index];
                              return LeaderboardSetItem(donorSet: donorSet);
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.h),
                            itemCount: dashboardVm.leaderBoardSets.length,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final donor =
                                  dashboardVm.leaderBoardDonors[index];
                              return Donor(
                                donorName: donor.displayName,
                                setNumber: donor.info,
                                amount:
                                    double.tryParse(donor.totalAmount ?? '0') ??
                                    0,
                                currencyCode: donor.currency,
                                date: donor.lastDonationAt,
                                tagColor: ColorPath.dynamicColor(
                                  donor.tier?.baseColor,
                                  ColorPath.brandColor,
                                ),
                                tagText: donor.donorType?.label,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.h),
                            itemCount: dashboardVm.leaderBoardDonors.length,
                          ),
                    if (dashboardVm.paginatedState == ViewState.busy)
                      Column(
                        children: [
                          SizedBox(height: 6.h),
                          LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: ColorPath.brandColor,
                          ),
                          SizedBox(height: 6.h),
                        ],
                      ),
                    if (dashboardVm.paginatedState == ViewState.error)
                      ErrorState(
                        onPressed: () async {
                          dashboardVm.getLeaderBoardDonors(firstCall: false);
                          dashboardVm.getLeaderBoardSets(
                            firstCall: false,
                            sortDirection: 'desc',
                          );
                        },
                        isPaginationType: true,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
