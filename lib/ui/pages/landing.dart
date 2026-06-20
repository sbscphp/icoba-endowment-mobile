import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/login.dart';
import 'package:icoba_endowment_mobile/ui/pages/onboarding/signup_options.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar icons and text to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          CustomAssetViewer(
            width: double.infinity,
            height: double.infinity,
            asset: AppAsset.donationBG,
            useColorFilter: false,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onPressed: () {
                      pushNavigation(
                        context: context,
                        widget: SignupOptions(),
                        routeName: NamedRoutes.signUpOptions,
                      );
                    },
                    buttonText: "Sign up",
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    onPressed: () {
                      pushNavigation(
                        context: context,
                        widget: Login(),
                        routeName: NamedRoutes.login,
                      );
                    },
                    buttonText: "Login",
                    bgColor: ColorPath.brandColor2,
                    buttonTextColor: ColorPath.ebonyBlack,
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    onPressed: () {},
                    buttonText: "Donate as guest",
                    bgColor: ColorPath.brandColor2,
                    buttonTextColor: ColorPath.ebonyBlack,
                  ),
                  SizedBox(height: 35.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
