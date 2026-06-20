import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/input_formatters/money_input_formatter.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/pledge_summary.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/select_payment_method.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

class ContributionAmount extends StatefulWidget {
  const ContributionAmount({super.key});

  @override
  State<ContributionAmount> createState() => _ContributionAmountState();
}

class _ContributionAmountState extends State<ContributionAmount> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: "Make a donation",
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Enter amount",
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //Currency Selector
                            IcobaContainer(
                              borderRadius: BorderRadius.circular(24.r),
                              bgColor: ColorPath.athensGrey4,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  CustomAssetViewer(
                                    asset: AppAsset.ngn,
                                    useColorFilter: false,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text("NGN"),
                                  Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 40.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return IcobaContainer(
                                borderRadius: BorderRadius.circular(8.r),
                                bgColor: 1 + 1 == 2 ? ColorPath.iceBlue : null,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 28.w,
                                  vertical: 10.h,
                                ),
                                border: Border.all(
                                  color: 1 + 1 == 2
                                      ? ColorPath.brandColor
                                      : ColorPath.gullGrey,
                                ),
                                child: Text(
                                  "₦100,000",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: 1 + 1 == 2
                                        ? ColorPath.brandColor
                                        : ColorPath.paleGrey,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 8.w),
                            itemCount: 3,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        IcobaContainer(
                          bgColor: ColorPath.athensGrey5,
                          padding: EdgeInsets.symmetric(
                            vertical: 24.h,
                            horizontal: 12.w,
                          ),
                          child: Column(
                            children: [
                              Text("Enter amount to donate here"),
                              SizedBox(height: 8.h),
                              TextField(
                                textAlign: TextAlign.center,
                                style: textTheme.titleLarge?.copyWith(),
                                inputFormatters: [MoneyInputFormatter()],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "₦ 00.00",
                                  hintStyle: textTheme.titleLarge?.copyWith(
                                    color: ColorPath.gullGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Divider(color: ColorPath.galleryGrey),
                        SizedBox(height: 24.h),
                        Clickable(
                          onPressed: () {},
                          child: CustomTextField(
                            label: "Designate donation to",
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: ColorPath.gullGrey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Clickable(
                          onPressed: () {},
                          child: CustomTextField(
                            label: "Pledge type",
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: ColorPath.gullGrey,
                              ),
                            ),
                          ),
                        ),

                        //TODO::: HANDLE PLEDGE TYPE HERE
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: CustomButton(
                onPressed: () {
                  //   pushNavigation(
                  //     context: context,
                  //     widget: SelectPaymentMethod(),
                  //     routeName: NamedRoutes.selectedPaymentMethod,
                  //   );

                  pushNavigation(
                    context: context,
                    widget: PledgeSummary(),
                    routeName: NamedRoutes.pledgeSummary,
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
