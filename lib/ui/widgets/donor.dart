import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class Donor extends StatelessWidget {
  final String? donorName;
  final String? setNumber;
  final double? amount;
  final DateTime? date;
  final String? currencyCode;
  final String? tagText;
  final Color? tagColor;
  final bool showTagRow;
  const Donor({
    super.key,
    this.donorName,
    this.setNumber,
    this.amount,
    this.date,
    this.currencyCode,
    this.tagText,
    this.tagColor,
    this.showTagRow = true,
  });

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
                  Text(donorName ?? "N/A", style: textTheme.bodyMedium),
                  if (setNumber != null)
                    Text(
                      "Set: $setNumber",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.textTertiary,
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: NairaDisplay(
                  amount: amount ?? 0,
                  currencyCode: currencyCode,
                  fontSize: 14.sp,
                  color: colorScheme.brandColor,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          if (showTagRow) Divider(thickness: .5, color: ColorPath.athensGrey),
          if (showTagRow)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    child: Text(
                      "${DateUtilities.dMY(date ?? DateTime.now())},${DateUtilities.time(date: date ?? DateTime.now())}",
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.textTertiary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                IcobaTag2(
                  donorType: tagText ?? "N/A",
                  color: tagColor ?? colorScheme.textTertiary,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
