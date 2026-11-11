import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/contribution_type.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/select_payment_method.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

class PledgeSummary extends ConsumerStatefulWidget {
  final double amount;
  final String donationPurpose;
  const PledgeSummary({
    super.key,
    required this.amount,
    required this.donationPurpose,
  });

  @override
  ConsumerState<PledgeSummary> createState() => _PledgeSummaryState();
}

class _PledgeSummaryState extends ConsumerState<PledgeSummary> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(donationViewModel);

    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: "Make pledge",
        useChevLeft: true,
      ),
      body: Container(
        color: ColorPath.athensGrey4,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  IcobaContainer(
                    margin: EdgeInsets.only(top: 16.h),
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Total amount pledged",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: NairaDisplay(
                            amount: widget.amount,
                            currencyCode: vm.selectedCurrency,
                            color: ColorPath.brandColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pledge summary",
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Clickable(
                              onPressed: () {
                                popNavigation(context: context);
                              },
                              child: Text(
                                "Edit plan",
                                style: textTheme.bodyLarge?.copyWith(
                                  color: ColorPath.lochmaraBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        IcobaContainer(
                          padding: EdgeInsets.all(16.w),
                          bgColor: ColorPath.athensGrey4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Designated  to:"),
                                  SizedBox(width: 12.w),
                                  Flexible(
                                    child: Text(
                                      vm.designatedCampaign?.name ?? "N/A",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pledge type:"),
                                  SizedBox(width: 12.w),

                                  Flexible(
                                    child: Text(
                                      Utilities.capitalizeWord(
                                        vm.selectedPledgeType ?? "",
                                      ).replaceAll("_", " "),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              if (vm.selectedMothCount != null ||
                                  vm.selectedPlanType != null)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Details:"),
                                        SizedBox(width: 12.w),

                                        Flexible(
                                          child: Text(
                                            vm.selectedMothCount != null
                                                ? "${vm.selectedMothCount} months"
                                                : Utilities.capitalizeWord(
                                                    vm.selectedPlanType ?? "",
                                                  ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        if (vm.summaryData.isNotEmpty)
                          IcobaContainer(
                            padding: EdgeInsets.all(16.w),
                            bgColor: ColorPath.athensGrey4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(vm.summaryData.length, (
                                index,
                              ) {
                                final data = vm.summaryData[index];
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomAssetViewer(
                                              asset: AppAsset.dottedCircle,
                                              useColorFilter: false,
                                              height: 16.h,
                                              width: 16.w,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              DateUtilities.abbrevDMY(
                                                data.dueDate ?? DateTime.now(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 12.w),
                                        Flexible(
                                          child: NairaDisplay(
                                            amount:
                                                double.tryParse(
                                                  data.remainingAmount ?? "0",
                                                ) ??
                                                0,
                                            currencyCode: data.currency,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                  ],
                                );
                              }),
                            ),
                          )
                        else
                          Text(
                            "Payment installment summary currently unavailable!",
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          buttonText: "Pay later",
                          borderColor: ColorPath.brandColor,
                          useBorderColor: true,
                          buttonTextColor: ColorPath.brandColor,
                          onPressed: () {
                            pushAndClearAllNavigation(
                              context: context,
                              widget: BottomNav(),
                              routeName: NamedRoutes.bottomNav,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomButton(
                          buttonText: "Pay now",
                          onPressed: () {
                            pushNavigation(
                              context: context,
                              widget: SelectPaymentMethod(
                                amount: vm.amountPerInstallment,
                                donationPurpose: widget.donationPurpose,
                                contributionType: ContributionType.pledge,
                              ),
                              routeName: NamedRoutes.selectedPaymentMethod,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
