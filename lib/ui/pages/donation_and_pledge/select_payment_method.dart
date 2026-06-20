import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/bank_details.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/card_details.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

import '../../widgets/custom_check.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment method",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return IcobaContainer(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: 1 + 1 == 2
                                    ? ColorPath.brandColor
                                    : ColorPath.athensGrey4,
                              ),
                              padding: EdgeInsets.all(18.w),
                              child: Row(
                                children: [
                                  CustomCheck(isChecked: true),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      index == 1
                                          ? "Pay with Card"
                                          : "Bank transfer",
                                    ),
                                  ),
                                  CustomAssetViewer(
                                    asset: index == 1
                                        ? AppAsset.cardsImage
                                        : AppAsset.bank,
                                    width: index == 1 ? 110 : null,
                                    useColorFilter: false,
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemCount: 2,
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          "Recognition and Privacy",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCheck(isChecked: false),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Show my name and amount gifted on the leaderboard",
                                    style: textTheme.bodyMedium?.copyWith(),
                                  ),
                                  Text(
                                    "Your name will be visible to admins and other contributors of this project",
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCheck(isChecked: true),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Donate anonymously",
                                    style: textTheme.bodyMedium?.copyWith(),
                                  ),
                                  Text(
                                    "Your name will be not be visible to other contributors of this project",
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.textSecondary,
                                    ),
                                  ),
                                ],
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
            SafeArea(
              child: CustomButton(
                onPressed: () {
                  // pushNavigation(
                  //   context: context,
                  //   widget: CardDetails(),
                  //   routeName: NamedRoutes.cardDetails,
                  // );

                  pushNavigation(
                    context: context,
                    widget: BankDetails(),
                    routeName: NamedRoutes.bankDetails,
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
