import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/screen_title.dart';

class SuccessfulDonation extends StatefulWidget {
  const SuccessfulDonation({super.key});

  @override
  State<SuccessfulDonation> createState() => _SuccessfulDonationState();
}

class _SuccessfulDonationState extends State<SuccessfulDonation> {
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
        leadingIconOnPressed: () {
          pushAndClearAllNavigation(
            context: context,
            widget: BottomNav(),
            routeName: NamedRoutes.bottomNav,
          );
        },
      ),
      body: Container(
        color: ColorPath.athensGrey4,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: ListView(
          children: [
            CustomAssetViewer(
              asset: AppAsset.success,
              useColorFilter: false,
              height: 105.h,
              width: 105.h,
            ),
            SizedBox(height: 12.h),
            Text(
              "Transaction successful!",
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "You have made an impact to this project. We appreciate your contribution to this cause.",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            CustomButton(onPressed: () {}, buttonText: "Download receipt"),
            SizedBox(height: 8.h),
            IcobaContainer(
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenTitle(
                    title: "Donation tiers",
                    subtitle:
                        "Donation badges are given according to the amount donated. See tier below.",
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Below 1 million naira",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      IcobaTag(type: "friends"),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "1 million - 9 million naira",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      IcobaTag(type: "bronze"),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "10 million - 99 million naira",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      IcobaTag(type: "silver"),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "10 million - 99 million naira",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      IcobaTag(type: "gold"),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "10 million - 99 million naira",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      IcobaTag(type: "platinum"),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "10 million - 99 million naira",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      IcobaTag(),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
