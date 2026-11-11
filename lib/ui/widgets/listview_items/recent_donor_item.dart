import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recent_donor.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class RecentDonorItem extends StatelessWidget {
  final RecentDonor? donor;

  const RecentDonorItem({super.key, this.donor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return IcobaContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: ColorPath.athensGrey),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donor?.displayName ?? "N/A",
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: NairaDisplay(
                  amount: double.tryParse(donor?.amount ?? "0") ?? 0,
                  currencyCode: donor?.currency,
                  fontSize: 14.sp,
                  color: colorScheme.brandColor,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          Divider(thickness: .5, color: ColorPath.athensGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recognition",
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.textTertiary,
                ),
              ),
              SizedBox(width: 8.w),
              IcobaTag2(
                donorType: donor?.tier?.name ?? "N/A",
                fontSize: 12.sp,
                fontWeight: FontWeight(600),
                color: ColorPath.dynamicColor(
                  donor?.tier?.baseColor,
                  ColorPath.brandColor,
                ),
              ),
            ],
          ),
          Divider(thickness: .5, color: ColorPath.athensGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date",
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.textTertiary,
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: FittedBox(
                  child: Text(
                    "${DateUtilities.dMY(donor?.paidAt ?? DateTime.now())} - ${DateUtilities.time(date: donor?.paidAt ?? DateTime.now())}",
                    style: textTheme.bodySmall?.copyWith(
                      // color: colorScheme.textTertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
