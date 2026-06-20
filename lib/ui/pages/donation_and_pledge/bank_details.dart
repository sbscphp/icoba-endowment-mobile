import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/successful_donation.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
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
              child: IcobaContainer(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
                height: double.infinity,
                child: ListView(
                  children: [
                    Text(
                      "Transfer this exact amount ",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "₦500,000.00",
                      style: textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "to any of the account below.",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),

                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return IcobaContainer(
                          padding: EdgeInsets.all(16.w),
                          bgColor: ColorPath.athensGrey4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: ColorPath.brandColor,
                                ),
                                child: Text(
                                  "NAIRA ACCOUNT",
                                  style: textTheme.bodySmall?.copyWith(
                                    fontSize: 7.5.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorPath.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Bank:"),
                                  SizedBox(width: 12.w),
                                  Flexible(
                                    child: Text(
                                      "First City Monument Bank",
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
                                  Text("Acct Name:"),
                                  SizedBox(width: 12.w),

                                  Flexible(
                                    child: Text(
                                      "IGBOBI COLLEGE ENDOWMENT FUND",
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
                                  Text("Acct No:"),
                                  SizedBox(width: 12.w),

                                  Expanded(
                                    child: Text(
                                      "2007877660",
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Clickable(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: "2007877660"),
                                      );
                                      showFlushBar(
                                        context: context,
                                        message:
                                            "Account Number Copied Successfully",
                                      );
                                    },
                                    child: Icon(Icons.copy, size: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: 5,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: CustomButton(
                buttonText: "I have sent the money",
                onPressed: () {
                  pushNavigation(
                    context: context,
                    widget: SuccessfulDonation(),
                    routeName: NamedRoutes.successfulDonation,
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
