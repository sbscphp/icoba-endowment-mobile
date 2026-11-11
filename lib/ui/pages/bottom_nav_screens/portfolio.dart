import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/bottom_nav_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/transactions_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/contribution_amount.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/display_image.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donor.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/recent_pledge.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/listview_items/Screens/recent_donations.dart';
import 'package:icoba_endowment_mobile/ui/widgets/listview_items/donation_history_item.dart';
import 'package:icoba_endowment_mobile/ui/widgets/listview_items/recognition.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

import '../../../core/data/view_models/dashboard/dashboard_vm.dart';
import '../../../core/data/view_models/user/user_vm.dart';

class Portfolio extends ConsumerStatefulWidget {
  const Portfolio({super.key});

  @override
  ConsumerState<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends ConsumerState<Portfolio> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userVm = ref.watch(userViewModel);
    final transactionsVm = ref.watch(transactionsViewModel);
    final dashboardVm = ref.watch(dashboardViewModel);

    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Text(
              "Portfolio",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
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
        child: RefreshIndicator(
          onRefresh: () async {
            transactionsVm.getTransactions();
          },
          child: ListView(
            padding: EdgeInsets.only(top: 24.h, bottom: 24.h),

            children: [
              //INFO CARD
              IcobaContainer(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        DisplayImage(
                          image: null,
                          firstName: userVm.firstName,
                          lastName: userVm.lastName,
                          size: 56,
                          fontSize: 10.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userVm.fullName,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${userVm.email}\n${userVm.setName == "N/A" ? "" : "${userVm.setName} set"}",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (userVm.tierBadgeUrl.isNotEmpty)
                          Image.network(
                            userVm.tierBadgeUrl,
                            height: 56.h,
                            width: 56.w,
                          ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 84.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return IcobaContainer(
                                  width:
                                      MediaQuery.of(context).size.width * .55,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getSummaryHeader(index),
                                        style: textTheme.bodySmall,
                                      ),
                                      SizedBox(height: 8.w),
                                      if (index == 0)
                                        Text(
                                          "${dashboardVm.donationCount}",
                                          style: textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (index == 1)
                                        NairaDisplay(
                                          amount: dashboardVm.totalDonation,
                                          fontSize: 14.sp,
                                          currencyCode: dashboardVm.currency,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      if (index == 2)
                                        NairaDisplay(
                                          amount: dashboardVm.totalPledges,
                                          fontSize: 14.sp,
                                          currencyCode: dashboardVm.currency,
                                          fontWeight: FontWeight.bold,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //RECOGNITION
              IcobaContainer(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recognition",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (userVm.recognitions.length > 5)
                          Clickable(
                            onPressed: () {},
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
                    SizedBox(height: 16.h),

                    Builder(
                      builder: (context) {
                        if (userVm.state == ViewState.busy) {
                          return AppLoader();
                        }
                        if (userVm.state == ViewState.error) {
                          return ErrorState(
                            message: userVm.message,
                            onPressed: () {
                              // _fetchData();
                            },
                          );
                        }
                        if (userVm.recognitions.isEmpty) {
                          return IcobaContainer(
                            margin: EdgeInsets.only(top: 24.h, bottom: 24.h),
                            child: Center(
                              child: EmptyState(
                                asset: AppAsset.empty,
                                title: "You are yet to make a donation",
                                ctaText: "Donate now",
                                onPressed: () {
                                  pushNavigation(
                                    context: context,
                                    widget: ContributionAmount(),
                                    routeName: NamedRoutes.contributionAmount,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 16.h),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final recognitionData = userVm.recognitions[index];
                            return RecognitionItem(
                              recognitionData: recognitionData,
                            );
                          },
                          separatorBuilder: (context, index) => Column(
                            children: [
                              SizedBox(height: 6.h),
                              Divider(color: ColorPath.athensGrey8),
                              SizedBox(height: 6.h),
                            ],
                          ),
                          itemCount: userVm.recognitions.length > 5
                              ? 5
                              : userVm.recognitions.length,
                        );
                      },
                    ),
                  ],
                ),
              ),
              //DONATION HISTORY
              IcobaContainer(
                padding: EdgeInsets.all(16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your donation history",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (transactionsVm.transactions.length > 5)
                          Clickable(
                            onPressed: () {
                              pushNavigation(
                                context: context,
                                widget: RecentDonations(),
                                routeName: NamedRoutes.recentDonations,
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
                    SizedBox(height: 16.h),
                    Builder(
                      builder: (context) {
                        if (transactionsVm.state == ViewState.busy) {
                          return AppLoader();
                        }
                        if (transactionsVm.state == ViewState.error) {
                          return ErrorState(
                            message: transactionsVm.message,
                            onPressed: () {
                              transactionsVm.getTransactions();
                            },
                          );
                        }
                        if (transactionsVm.transactions.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: EmptyState(
                              asset: AppAsset.empty,
                              title: "You are yet to make a donation",
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = transactionsVm.transactions[index];
                            return DonationHistoryItem(data: data);
                            // Donor(
                            //   amount: double.tryParse(data.amount ?? "0"),
                            //   currencyCode: data.currency,
                            //   donorName: data.linkedCampaign?.name,
                            //   setNumber: userVm.setName,
                            //   showTagRow: false,
                            // );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: transactionsVm.transactions.length >= 5
                              ? 5
                              : transactionsVm.transactions.length,
                        );
                      },
                    ),
                  ],
                ),
              ),
              //
              RecentPledge(),
              SizedBox(height: 65.h),
            ],
          ),
        ),
      ),
    );
  }
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
