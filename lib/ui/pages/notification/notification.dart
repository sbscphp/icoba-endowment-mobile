import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../../core/data/models/response_data/notification_data.dart';

//todo::: pagination
class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
    super.initState();
  }

  void _fetchData() async {
    ref.read(userViewModel).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(userViewModel);
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
        child: Builder(
          builder: (context) {
            if (vm.state == ViewState.busy) {
              return AppLoader();
            }
            if (vm.state == ViewState.error) {
              return ErrorState(onPressed: () {}, message: vm.message);
            }
            return vm.notifications.isEmpty
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
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                    ),
                    margin: EdgeInsets.only(top: 16.h),
                    bgColor: colorScheme.whiteText,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 16.h),
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = vm.notifications[index];
                        return NotificationItem(data: data);
                      },
                      separatorBuilder: (context, index) =>
                          Column(children: [SizedBox(height: 16.h)]),
                      itemCount: vm.notifications.length,
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationData data;
  const NotificationItem({super.key, required this.data});

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
                  data.title ?? "N/A",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  data.message ?? "N/A",
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.textTertiary,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "${DateUtilities.dM(data.createdAt ?? DateTime.now())} • ${DateUtilities.time(date: data.createdAt ?? DateTime.now())}",
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
