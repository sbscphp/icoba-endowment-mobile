import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class Donor extends StatelessWidget {
  const Donor({super.key});

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
                  Text("Philip Inniebong", style: textTheme.bodyMedium),
                  Text(
                    "Set: 1999/20",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.textTertiary,
                    ),
                  ),
                ],
              ),
              NairaDisplay(
                amount: 200000,
                fontSize: 14.sp,
                color: colorScheme.brandColor,
              ),
            ],
          ),
          Divider(thickness: .5, color: ColorPath.athensGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  child: Text(
                    "${DateUtilities.dMY(DateTime.now())},${DateUtilities.time(date: DateTime.now())}",
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.textTertiary,
                    ),
                  ),
                ),
              ),
              IcobaTag(),
            ],
          ),
        ],
      ),
    );
  }
}
