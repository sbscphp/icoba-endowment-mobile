import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/signup_type.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/login.dart';
import 'package:icoba_endowment_mobile/ui/pages/onboarding/signup.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donation_header.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/leading_icon.dart';
import 'package:icoba_endowment_mobile/ui/widgets/screen_title.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../widgets/custom_radio_button.dart';

class OptionModel {
  String title;
  String subTitle;
  SignupType? signupType;
  OptionModel({required this.title, required this.subTitle, this.signupType});
}

class SignupOptions extends StatefulWidget {
  const SignupOptions({super.key});

  @override
  State<SignupOptions> createState() => _SignupOptionsState();
}

class _SignupOptionsState extends State<SignupOptions> {
  OptionModel? signUpOption;
  SignupType? signupType;

  final signUpOptions = [
    OptionModel(
      title: "ICOBA alumni ",
      subTitle: "Donate as an old boy of Igbobi College, Lagos",
      signupType: SignupType.alumni,
    ),
    OptionModel(
      title: "Corporate donor",
      subTitle:
          "Donate to Igbobi college as an organization, company or foundation.",
      signupType: SignupType.corporateDonor,
    ),
    OptionModel(
      title: "Friends of ICOBA",
      subTitle:
          "Donate to Igbobi college as a friend to an Igbobi college alumnus.",
      signupType: SignupType.friendOfIcoba,
    ),
    OptionModel(
      title: "Families of ICOBA",
      subTitle:
          "Donate to Igbobi college as a family to an Igbobi college alumnus.",
      signupType: SignupType.familiesOfIcoba,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(height: 24.h),
          DonationHeader(
            title: "Join the movement",
            subtitle: "Choose how you want to register as a donor",
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final data = signUpOptions[index];
                return Clickable(
                  onPressed: () {
                    setState(() {
                      signUpOption = data;
                      signupType = data.signupType;
                    });
                  },
                  child: IcobaContainer(
                    padding: EdgeInsets.all(16),
                    border: Border.all(
                      color: signUpOption == data
                          ? ColorPath.brandColor
                          : ColorPath.athensGrey4,
                      width: 1.5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.brandColor,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                data.subTitle,
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomRadioButton(value: signUpOption == data),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: signUpOptions.length,
            ),
          ),
          CustomButton(
            onPressed:
                // signUpOption == null
                //     ? null
                //     :
                () {
                  if (signupType == null) {
                    showFlushBar(
                      context: context,
                      message: "Select Option to Continue",
                      success: false,
                    );
                    return;
                  }
                  pushNavigation(
                    context: context,
                    widget: Signup(signupType: signupType!),
                    routeName: NamedRoutes.signUp,
                  );
                },
          ),
          SizedBox(height: 16.h),
          Text.rich(
            TextSpan(
              text: "Already have a donor account?  ",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.textPrimary,
                fontSize: 14.sp,
              ),
              children: [
                TextSpan(
                  text: "Sign in",
                  style: textTheme.bodyMedium?.copyWith(
                    // decoration: TextDecoration.underline,
                    color: colorScheme.brandColor,
                    fontWeight: FontWeight.w700,
                    decorationColor: colorScheme.brandColor,
                    fontSize: 14.sp,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      replaceNavigation(
                        context: context,
                        widget: Login(),
                        routeName: NamedRoutes.login,
                      );
                    },
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
