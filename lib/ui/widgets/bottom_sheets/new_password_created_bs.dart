import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import 'bs_header.dart';

class NewPasswordCreatedBs extends StatelessWidget {
  const NewPasswordCreatedBs({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // header
        BsHeader(),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              CustomAssetViewer(
                asset: AppAsset.success,
                height: 95.h,
                width: 95.w,
                useColorFilter: false,
              ),
              SizedBox(height: 16.h),
              Text(
                "New Password Created",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Your account password has been reset, you can now login to your account.",
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),

              CustomButton(
                onPressed: () {
                  popUntilNavigation(
                    context: context,
                    route: NamedRoutes.login,
                  );
                },
                buttonText: "Log In",
                borderColor: ColorPath.fiordGrey,
                useBorderColor: true,
                buttonTextColor: colorScheme.textPrimary,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ],
    );
  }
}
