import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/new_password_created_bs.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';

import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/auth/password_requirement.dart';
import '../../widgets/bottom_sheets/account_verification_bs.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/donation_header.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  bool isObscured = true;
  bool isConfirmObscured = true;

  List<bool> _results = [false, false, false, false, false];

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
              title: "Forgot Password",
              subtitle: "Enter your information to continue.",
            ),
            SizedBox(height: 24.h),
            1 + 1 == 3
                ? Column(
                    children: [
                      CustomTextField(
                        label: "Email",
                        hintText: "Enter email address",
                        validator: EmailValidator.validateEmail,
                        controller: _email,
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: AccountVerificationBs(),
                          );
                        },
                        buttonText: "Send email",
                      ),
                      SizedBox(height: 16.h),
                      Text.rich(
                        TextSpan(
                          text: "Don’t receive an email? ",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.textPrimary,
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: "Resend email",
                              style: textTheme.bodyMedium?.copyWith(
                                // decoration: TextDecoration.underline,
                                color: colorScheme.brandColor,
                                fontWeight: FontWeight.w700,
                                decorationColor: colorScheme.brandColor,
                                fontSize: 14.sp,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // replaceNavigation(
                                  //   context: context,
                                  //   widget: SignupOptions(),
                                  //   routeName: NamedRoutes.signUpOptions,
                                  // );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      CustomTextField(
                        label: "New Password ",
                        // controller: _pwd,
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
                        onChanged: (value) {
                          checkPassWordRequirement(password: value);
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: "Re-enter Password",
                        // controller: _pwd,
                        hintText: "Enter password",
                        obscure: isConfirmObscured,
                        validator: FieldValidator.validate,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 14.w),
                          child: Clickable(
                            onPressed: () {
                              setState(() {
                                isConfirmObscured = !isConfirmObscured;
                              });
                            },
                            child: Icon(
                              isConfirmObscured
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              color: ColorPath.paleGrey,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          //todo: validate password is the same here
                        },
                      ),
                      SizedBox(height: 16.h),
                      PasswordRequirement(results: _results),
                      SizedBox(height: 36.h),
                      CustomButton(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: NewPasswordCreatedBs(),
                          );
                        },
                        buttonText: "Create new password",
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  checkPassWordRequirement({required String password}) {
    final hasMinLength = password.trim().length > 7;
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    _results = [hasMinLength, hasUpperCase, hasLowerCase, hasNumber, hasSymbol];
    setState(() {});
  }
}
