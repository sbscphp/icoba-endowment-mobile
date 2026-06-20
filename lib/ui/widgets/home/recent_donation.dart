import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donor.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class RecentDonation extends StatefulWidget {
  const RecentDonation({super.key});

  @override
  State<RecentDonation> createState() => _RecentDonationState();
}

class _RecentDonationState extends State<RecentDonation> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return IcobaContainer(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 16.h),
      bgColor: colorScheme.whiteText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent donations",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (1 + 1 == 3)
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
          SizedBox(height: 12.h),
          1 + 1 == 2
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: EmptyState(
                    asset: AppAsset.empty,
                    title: "You are yet to make a donation",
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Donor();
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemCount: 3,
                ),
        ],
      ),
    );
  }
}
