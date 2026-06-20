import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/contribution_amount.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';

class Recognition extends StatefulWidget {
  const Recognition({super.key});

  @override
  State<Recognition> createState() => _RecognitionState();
}

class _RecognitionState extends State<Recognition> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: "Recognition",
        useChevLeft: true,
      ),
      body: Container(
        color: ColorPath.athensGrey4,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: 1 + 1 == 3
            ? IcobaContainer(
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
              )
            : IcobaContainer(
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
                        // if (1 + 1 == 3)
                        //   Clickable(
                        //     onPressed: () {},
                        //     child: Text(
                        //       "View all",
                        //       style: textTheme.bodyMedium?.copyWith(
                        //         fontWeight: FontWeight.bold,
                        //         color: colorScheme.brandColor,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 16.h),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Certificate of Endowment "),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      CustomAssetViewer(
                                        asset: AppAsset.calendar,
                                        useColorFilter: false,
                                        height: 12,
                                        width: 12,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        DateUtilities.monthDayYear(
                                          date: DateTime.now(),
                                        ),
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorScheme.textTertiary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IcobaTag(type: "gold"),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Column(
                        children: [
                          SizedBox(height: 6.h),
                          Divider(color: ColorPath.athensGrey8),
                          SizedBox(height: 6.h),
                        ],
                      ),
                      itemCount: 3,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
