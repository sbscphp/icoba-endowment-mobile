import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard_vm.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_painter/custom_progress_bar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

import '../app_loader.dart';
import '../error_state.dart';

class FundUpdate extends ConsumerStatefulWidget {
  const FundUpdate({super.key});

  @override
  ConsumerState<FundUpdate> createState() => _FundUpdateState();
}

class _FundUpdateState extends ConsumerState<FundUpdate> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _fetchData();
  //   });
  //   super.initState();
  // }

  // void _fetchData() {
  //   ref.read(dashboardViewModel).getFundsData();
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final dashboardVm = ref.watch(dashboardViewModel);

    return dashboardVm.fundsData.isEmpty
        ? SizedBox.shrink()
        : IcobaContainer(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(top: 16.h),
            bgColor: colorScheme.whiteText,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fund Update",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Builder(
                  builder: (context) {
                    if (dashboardVm.dashboardState == ViewState.busy) {
                      return AppLoader();
                    }
                    if (dashboardVm.dashboardState == ViewState.error) {
                      return ErrorState(
                        message: dashboardVm.message,
                        onPressed: () {},
                      );
                    }

                    return SizedBox(
                      height: 110.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contex, index) {
                          final fundData = dashboardVm.fundsData[index];
                          // return Container(
                          //   height: 110.h,
                          //   width: 200.w,
                          //   color: ColorPath.athensGrey8,
                          // );
                          return IcobaContainer(
                            padding: EdgeInsets.all(12.w),
                            width: MediaQuery.of(context).size.width * 0.79,
                            height: 120.h,
                            bgColor: ColorPath.athensGrey8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    fundData.campaignName ?? "N/A",
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.brandColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TweenAnimationBuilder<double>(
                                          // key: ValueKey(vm.percentage),
                                          tween: Tween<double>(
                                            begin: 0.0,
                                            end: fundData.percent is int
                                                ? fundData.percent.toDouble()
                                                : double.tryParse(
                                                        fundData.percent
                                                            .toString(),
                                                      ) ??
                                                      0.0,
                                          ),
                                          duration: Duration(seconds: 2),
                                          curve: Curves.easeInOut,
                                          builder: (context, value, child) {
                                            return SizedBox(
                                              width: double.infinity,
                                              // height: 8.h,
                                              child: CustomPaint(
                                                painter: CustomProgressBar(
                                                  percentage: value,
                                                  backgroundColor: ColorPath
                                                      .gullGrey
                                                      .withValues(alpha: .2),
                                                  strokeWidth: 8.w,
                                                  activeColor:
                                                      ColorPath.primaryYellow,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        "${fundData.percent?.toStringAsFixed(1) ?? '0.0'}%",
                                        style: textTheme.bodySmall?.copyWith(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Flexible(
                                  child: Text.rich(
                                    TextSpan(
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.brandColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        textspanNairaDisplay(
                                          currencyCode: fundData.currency,
                                          amount:
                                              double.tryParse(
                                                fundData.raised?.toString() ??
                                                    "0",
                                              ) ??
                                              0,
                                        ),
                                        TextSpan(text: " of "),
                                        textspanNairaDisplay(
                                          currencyCode: fundData.currency,
                                          amount:
                                              double.tryParse(
                                                fundData.target?.toString() ??
                                                    "0",
                                              ) ??
                                              0,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Text(
                                  //   "₦12,000 of ₦16,000,000.",
                                  //   style: textTheme.bodyMedium?.copyWith(
                                  //     color: colorScheme.brandColor,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12.w),
                        itemCount: dashboardVm.fundsData.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
