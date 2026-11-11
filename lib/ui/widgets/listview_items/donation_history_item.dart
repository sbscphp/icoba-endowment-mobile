import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/transaction_data.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class DonationHistoryItem extends StatelessWidget {
  final TransactionData data;
  const DonationHistoryItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return IcobaContainer(
      border: Border.all(color: ColorPath.athensGrey9),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NairaDisplay(
                      amount: double.tryParse(data.amount ?? "0") ?? 0,
                      currencyCode: data.currency,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: ColorPath.brandColor,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      DateUtilities.dMY(
                        DateTime.tryParse(data.paidAt ?? "") ?? DateTime.now(),
                      ),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              IcobaTag(type: data.status ?? "", showIcon: false),
            ],
          ),
          // SizedBox(height: 8.h),
          // if (data.paidAt != null)
          //   CustomButton(
          //     onPressed: () {},
          //     bgColor: ColorPath.yonderBlue
          //         .withCustomOpacity(.5),
          //     childWidget: Row(
          //       mainAxisAlignment:
          //           MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           "Download",
          //           style: textTheme.bodyMedium
          //               ?.copyWith(
          //                 color: ColorPath.brandColor,
          //               ),
          //         ),
          //         SizedBox(width: 6.w),
          //         Icon(
          //           Icons.file_download_outlined,
          //           color: ColorPath.brandColor,
          //         ),
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
