import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/services/navigation_service.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/delete_account_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/locator.dart';
import 'package:icoba_endowment_mobile/ui/pages/landing.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/bottom_sheet_header.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

class DeleteAccountBs extends ConsumerStatefulWidget {
  const DeleteAccountBs({super.key});

  @override
  ConsumerState<DeleteAccountBs> createState() => _DeleteAccountBsState();
}

class _DeleteAccountBsState extends ConsumerState<DeleteAccountBs> {
  final TextEditingController _reason = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(deleteAccountViewModel);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeader(headerTitle: ""),
            CustomAssetViewer(
              asset: AppAsset.error,
              useColorFilter: false,
              height: 120.h,
              width: 120.w,
            ),
            SizedBox(height: 16.h),
            Text(
              "Delete Account?",
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.textPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Deleting your account will delete all your records permanently.",
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              label: "Reason",
              controller: _reason,
              maxLines: 4,
              useDefaultHeight: false,
              bottomHintText:
                  "Kindly provide your reason for wanting your data deleted.",
              bottomHintColor: ColorPath.gullGrey,
            ),

            SizedBox(height: 16.h),
            CustomButton(
              onPressed: () async {
                if (_reason.text.isEmpty) {
                  return showFlushBar(
                    context: context,
                    message: "Enter Reason for Deleting Account.",
                    success: false,
                  );
                }
                popNavigation(context: context);
                NavigationService navigationService =
                    locator<NavigationService>();

                await vm.deleteAccount(reason: _reason.text);

                if (vm.state == ViewState.retrieved) {
                  pushAndClearAllNavigation(
                    context: navigationService.navigationKey.currentContext!,
                    widget: Landing(),
                    routeName: NamedRoutes.landing,
                  );
                } else {
                  showFlushBar(
                    context: navigationService.navigationKey.currentContext!,
                    message: vm.message,
                    success: false,
                  );
                }
              },
              buttonText: "Yes, Delete",
            ),
            SizedBox(height: 17),
            CustomButton(
              onPressed: () {
                popNavigation(context: context);
              },
              bgColor: ColorPath.athensGrey8,
              buttonText: "Back",
              buttonTextColor: ColorPath.brandColor,
            ),
          ],
        ),
      ),
    );
  }
}
