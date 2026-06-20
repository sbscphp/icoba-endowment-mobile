import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/forgot_password.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav.dart';
import 'package:icoba_endowment_mobile/ui/pages/onboarding/signup_options.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';

import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/utilities/navigator.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/account_verification_bs.dart';
import '../../widgets/clickable.dart';
import '../../widgets/donation_header.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24.h),
            DonationHeader(
              title: "Sign in to ICOBA Endowment App",
              subtitle: "Enter your information to log in.",
            ),
            SizedBox(height: 24.h),
            CustomTextField(
              label: "Email",
              hintText: "Enter email address",
              validator: EmailValidator.validateEmail,
              controller: _email,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              label: "Password ",
              controller: _pwd,
              hintText: "Enter password",
              obscure: isObscured,
              validator: FieldValidator.validate,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: Clickable(
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  child: Icon(
                    isObscured
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                    color: ColorPath.paleGrey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Clickable(
                  onPressed: () {
                    pushNavigation(
                      context: context,
                      widget: ForgotPassword(),
                      routeName: NamedRoutes.forgotPassword,
                    );
                  },
                  child: Text(
                    "Forgot password?",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.redText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            CustomButton(
              onPressed: () {
                // baseBottomSheet(
                //   context: context,
                //   content: AccountVerificationBs(),
                // );
                pushAndClearAllNavigation(
                  context: context,
                  widget: BottomNav(),
                  routeName: NamedRoutes.bottomNav,
                );
              },
              buttonText: "Sign in",
            ),
            SizedBox(height: 16.h),
            Text.rich(
              TextSpan(
                text: "Don’t have a donor account? ",
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.textPrimary,
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: "Create account",
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
                          widget: SignupOptions(),
                          routeName: NamedRoutes.signUpOptions,
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
