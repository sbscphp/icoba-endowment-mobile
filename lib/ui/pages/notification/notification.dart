import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../widgets/donor.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: "Notification",
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
                    title: "You have no notification yet",
                  ),
                ),
              )
            : IcobaContainer(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 16.h),
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NotificationItem();
                  },
                  separatorBuilder: (context, index) =>
                      Column(children: [SizedBox(height: 16.h)]),
                  itemCount: 13,
                ),
              ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return IcobaContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: ColorPath.athensGrey),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAssetViewer(
            asset: AppAsset.notification2,
            useColorFilter: false,
            height: 36.h,
            width: 36.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Pledge to 50,000 is due",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Jude Oyinlola has initiated a request for a Rhodium equity bond purchase, your approaval...",
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.textTertiary,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "${DateUtilities.dM(DateTime.now())} • ${DateUtilities.time(date: DateTime.now())}",
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
