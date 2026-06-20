import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/successful_donation.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/screen_title.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
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
                        IcobaContainer(
                          width: double.infinity,
                          bgColor: ColorPath.athensGrey5,
                          padding: EdgeInsets.symmetric(
                            vertical: 24.h,
                            horizontal: 12.w,
                          ),
                          child: Column(
                            children: [
                              Text("You are about to donate"),
                              SizedBox(height: 8.h),
                              Text("₦100,000.00", style: textTheme.titleMedium),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextField(
                          label: "Card owner",
                          hintText: "Enter your name",
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          label: "Card number",
                          hintText: "000-0000-0000-00000",
                          //todo handle card Icon view here
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CustomAssetViewer(
                              asset: AppAsset.masterCard,
                              useColorFilter: false,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: "Expiry",
                                hintText: "00 / 0000",
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: CustomTextField(
                                label: "CVV",
                                hintText: "",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        ScreenTitle(
                          title: "Billing contact",
                          subtitle: "Add a second billing contact email.",
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          label: "Email address",
                          hintText: "Enter email address",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.email_outlined,
                              color: ColorPath.gullGrey,
                            ),
                          ),
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
                  CustomButton(
                    onPressed: () {
                      pushNavigation(
                        context: context,
                        widget: SuccessfulDonation(),
                        routeName: NamedRoutes.successfulDonation,
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text.rich(
                    TextSpan(
                      text: "Encountered any issues? ",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textPrimary,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: "Contact support",
                          style: textTheme.bodyMedium?.copyWith(
                            // decoration: TextDecoration.underline,
                            color: colorScheme.brandColor,
                            fontWeight: FontWeight.w700,
                            decorationColor: colorScheme.brandColor,
                            fontSize: 14.sp,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
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
    );
  }
}
