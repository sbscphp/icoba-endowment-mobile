import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/contribution_amount.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/listview_items/recognition.dart';

class Recognition extends ConsumerStatefulWidget {
  const Recognition({super.key});

  @override
  ConsumerState<Recognition> createState() => _RecognitionState();
}

class _RecognitionState extends ConsumerState<Recognition> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
    super.initState();
  }

  _fetchData() {
    ref.read(userViewModel).getRecognitions();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(userViewModel);
    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: "Recognition",
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
              return ErrorState(
                message: vm.message,
                onPressed: () {
                  _fetchData();
                },
              );
            }
            if (vm.recognitions.isEmpty) {
              return IcobaContainer(
                margin: EdgeInsets.only(top: 24.h, bottom: 24.h),
                child: Center(
                  child: EmptyState(
                    asset: AppAsset.empty,
                    title: "You are yet to make a donation",
                    ctaText: "Donate now",
                    onPressed: () {
                      pushNavigation(
                        context: context,
                        widget: ContributionAmount(),
                        routeName: NamedRoutes.contributionAmount,
                      );
                    },
                  ),
                ),
              );
            }
            return IcobaContainer(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              margin: EdgeInsets.only(top: 16.h),
              bgColor: colorScheme.whiteText,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recognition",
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // if (1 + 1 == 3)
                      //   Clickable(
                      //     onPressed: () {},
                      //     child: Text(
                      //       "View all",
                      //       style: textTheme.bodyMedium?.copyWith(
                      //         fontWeight: FontWeight.bold,
                      //         color: colorScheme.brandColor,
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 16.h),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final recognitionData = vm.recognitions[index];
                      return RecognitionItem(recognitionData: recognitionData);
                    },
                    separatorBuilder: (context, index) => Column(
                      children: [
                        SizedBox(height: 6.h),
                        Divider(color: ColorPath.athensGrey8),
                        SizedBox(height: 6.h),
                      ],
                    ),
                    itemCount: vm.recognitions.length,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
