import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/select_payment_method.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class PledgeSummary extends StatefulWidget {
  const PledgeSummary({super.key});

  @override
  State<PledgeSummary> createState() => _PledgeSummaryState();
}

class _PledgeSummaryState extends State<PledgeSummary> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
                            amount: 300,
                            currencyCode: "USD",
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
                            Text(
                              "Edit plan",
                              style: textTheme.bodyLarge?.copyWith(
                                color: ColorPath.lochmaraBlue,
                                fontWeight: FontWeight.bold,
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
                                      "General Endowment Fund",
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
                                      "Monthly",
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
                                  Text("Details:"),
                                  SizedBox(width: 12.w),

                                  Flexible(
                                    child: Text(
                                      "3 months",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                            ],
                          ),
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
                                  Row(
                                    children: [
                                      CustomAssetViewer(
                                        asset: AppAsset.dottedCircle,
                                        useColorFilter: false,
                                        height: 16.h,
                                        width: 16.w,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text("01 May, 2026"),
                                    ],
                                  ),
                                  SizedBox(width: 12.w),
                                  Flexible(
                                    child: NairaDisplay(
                                      amount: 100,
                                      currencyCode: "USD",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
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
                                      Text("01 May, 2026"),
                                    ],
                                  ),
                                  SizedBox(width: 12.w),
                                  Flexible(
                                    child: NairaDisplay(
                                      amount: 100,
                                      currencyCode: "USD",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SafeArea(
              child: CustomButton(
                onPressed: () {
                  pushNavigation(
                    context: context,
                    widget: SelectPaymentMethod(),
                    routeName: NamedRoutes.selectedPaymentMethod,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
