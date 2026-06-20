import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/contribution_amount.dart';
import 'package:icoba_endowment_mobile/ui/pages/recognition/recognition.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/cta_card.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

import '../../../core/constants/app_asset.dart';

class QuickLinks extends ConsumerWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return IcobaContainer(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 16.h),
      bgColor: colorScheme.whiteText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick actions",
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CTACard(
                  onPressed: () {
                    pushNavigation(
                      context: context,
                      widget: ContributionAmount(),
                      routeName: NamedRoutes.contributionAmount,
                    );
                  },
                  asset: AppAsset.donate,
                  ctaText: "Donate now",
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CTACard(
                  onPressed: () {
                    pushNavigation(
                      context: context,
                      widget: ContributionAmount(),
                      routeName: NamedRoutes.contributionAmount,
                    );
                  },
                  asset: AppAsset.pledge,
                  ctaText: "Pledge support",
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CTACard(
                  onPressed: () {
                    pushNavigation(
                      context: context,
                      widget: Recognition(),
                      routeName: NamedRoutes.recognition,
                    );
                  },
                  asset: AppAsset.recognitions,
                  ctaText: "Recognitions",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
