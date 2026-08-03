import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/services/navigation_service.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/locator.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/bottom_sheet_header.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';

class LogoutBs extends StatelessWidget {
  const LogoutBs({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(12),
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
            "Logout",
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Are you sure you want to log out of your account?",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          CustomButton(
            onPressed: () async {
              NavigationService navigationService =
                  locator<NavigationService>();

              navigationService.pushAndClearRoutes(
                routeName: NamedRoutes.login,
                clearRoute: NamedRoutes.landing,
              );
            },
            buttonText: "Yes, logout",
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
    );
  }
}
