import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

import '../../../core/data/models/response_data/leader_board_set_data.dart';

class LeaderboardSetItem extends StatelessWidget {
  final LeaderBoardSetData? donorSet;
  const LeaderboardSetItem({super.key, this.donorSet});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return IcobaContainer(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: ColorPath.athensGrey9),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPath.primaryYellow.withCustomOpacity(.4),
            ),
            child: Center(
              child: Text(
                donorSet?.rank.toString() ?? "1",
                style: textTheme.bodySmall?.copyWith(
                  color: ColorPath.brandColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "Set ${donorSet?.set?.setNumber ?? "N/A"}",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.textPrimary,
              ),
            ),
          ),
          NairaDisplay(
            amount: double.tryParse(donorSet?.totalAmount ?? '0') ?? 0,
            currencyCode: donorSet?.currency,
            fontSize: 12.sp,
            color: ColorPath.brandColor,
          ),
        ],
      ),
    );
  }
}
