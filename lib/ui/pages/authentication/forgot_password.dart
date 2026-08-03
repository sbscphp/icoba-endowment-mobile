import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/otp_type.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/auth/auth_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
// ignore: unused_import
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/login.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/new_password_created_bs.dart';
import 'package:icoba_endowment_mobile/ui/widgets/busy_overlay.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/utilities/utilities.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/auth/password_requirement.dart';
import '../../widgets/bottom_sheets/account_verification_bs.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/donation_header.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  final int step;
  final bool isPasswordReset;
  const ForgotPassword({
    super.key,
    this.step = 1,
    this.isPasswordReset = false,
  });

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _pwdConfirm = TextEditingController();

  bool isObscured = true;
  bool isConfirmObscured = true;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<bool> _results = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(authViewModel);
    final userVm = ref.watch(userViewModel);

    return BusyOverlay(
      show: vm.state == ViewState.busy || userVm.state == ViewState.busy,
      child: CustomScaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey1,
            child: Column(
              children: [
                SizedBox(height: 24.h),
                DonationHeader(
                  title: widget.isPasswordReset
                      ? "Reset Password"
                      : "Forgot Password",
                  subtitle: widget.isPasswordReset
                      ? "Change your password to continue"
                      : "Enter your information to continue.",
                ),
                SizedBox(height: 24.h),
                widget.step == 1
                    ? Column(
                        children: [
                          CustomTextField(
                            label: "Email",
                            hintText: "Enter email address",
                            validator: EmailValidator.validateEmail,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 24.h),
                          CustomButton(
                            onPressed: () async {
                              Utilities.hideKeyboard(context);

                              final validate = _formKey1.currentState!
                                  .validate();
                              if (validate) {
                                await vm.forgotPassword(email: _email.text);

                                if (vm.state == ViewState.retrieved) {
                                  baseBottomSheet(
                                    context: context,
                                    isDismissible: false,
                                    content: AccountVerificationBs(
                                      otpType: OtpType.forgotPassword,
                                      durationInSeconds: vm.timerDuration,
                                    ),
                                  );
                                } else {
                                  showFlushBar(
                                    context: context,
                                    message: vm.message,
                                    success: false,
                                  );
                                }

                                // pushNavigation(
                                //   context: context,
                                //   widget: ForgotPassword(step: 2),
                                //   routeName: NamedRoutes.forgotPassword,
                                // );
                              }
                            },
                            buttonText: "Send email",
                          ),
                          SizedBox(height: 16.h),
                          // Text.rich(
                          //   TextSpan(
                          //     text: "Don’t receive an email? ",
                          //     style: textTheme.bodyMedium?.copyWith(
                          //       color: colorScheme.textPrimary,
                          //       fontSize: 14.sp,
                          //     ),
                          //     children: [
                          //       TextSpan(
                          //         text: "Resend email",
                          //         style: textTheme.bodyMedium?.copyWith(
                          //           // decoration: TextDecoration.underline,
                          //           color: colorScheme.brandColor,
                          //           fontWeight: FontWeight.w700,
                          //           decorationColor: colorScheme.brandColor,
                          //           fontSize: 14.sp,
                          //         ),
                          //         recognizer: TapGestureRecognizer()
                          //           ..onTap = () async {
                          //             Utilities.hideKeyboard(context);

                          //             final validate = _formKey1.currentState!
                          //                 .validate();
                          //             if (validate) {
                          //               await vm.forgotPassword(
                          //                 email: _email.text,
                          //               );

                          //               if (vm.state == ViewState.retrieved) {
                          //                 baseBottomSheet(
                          //                   context: context,
                          //                   isDismissible: false,
                          //                   content: AccountVerificationBs(
                          //                     otpType: OtpType.forgotPassword,
                          //                     durationInSeconds:
                          //                         vm.timerDuration,
                          //                   ),
                          //                 );
                          //               } else {
                          //                 showFlushBar(
                          //                   context: context,
                          //                   message: vm.message,
                          //                   success: false,
                          //                 );
                          //               }

                          //               // pushNavigation(
                          //               //   context: context,
                          //               //   widget: ForgotPassword(step: 2),
                          //               //   routeName: NamedRoutes.forgotPassword,
                          //               // );
                          //             }
                          //           },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      )
                    : Form(
                        key: _formKey2,
                        child: Column(
                          children: [
                            CustomTextField(
                              label: "New Password ",
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
                              onChanged: (value) {
                                checkPassWordRequirement(password: value);
                              },
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              label: "Re-enter Password",
                              controller: _pwdConfirm,
                              hintText: "Enter password",
                              obscure: isConfirmObscured,
                              validator: (String? value) {
                                if (value != null) {
                                  if (value.isEmpty || value.trim().isEmpty) {
                                    return "Field cannot be empty";
                                  }
                                  if (value != _pwd.text) {
                                    return "Password mismatch";
                                  }
                                } else {
                                  return null;
                                }
                                return null;
                              },
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
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 16.h),
                            PasswordRequirement(results: _results),
                            SizedBox(height: 36.h),
                            CustomButton(
                              onPressed: () async {
                                Utilities.hideKeyboard(context);

                                final validate = _formKey2.currentState!
                                    .validate();
                                if (validate) {
                                  if (allResultsTrue()) {
                                    if (widget.isPasswordReset) {
                                      await userVm.updatePassword(
                                        password: _pwd.text,
                                      );
                                      if (userVm.state == ViewState.retrieved) {
                                        //route to login
                                        pushAndClearAllNavigation(
                                          context: context,
                                          widget: Login(),
                                          routeName: NamedRoutes.login,
                                        );
                                        showFlushBar(
                                          context: context,
                                          message: userVm.message,
                                        );
                                      } else {
                                        showFlushBar(
                                          context: context,
                                          message: userVm.message,
                                          success: false,
                                        );
                                      }
                                      return;
                                    }
                                    //default
                                    await vm.resetPassword(password: _pwd.text);
                                    if (vm.state == ViewState.retrieved) {
                                      baseBottomSheet(
                                        context: context,
                                        content: NewPasswordCreatedBs(),
                                      );
                                    } else {
                                      showFlushBar(
                                        context: context,
                                        message: vm.message,
                                        success: false,
                                      );
                                    }
                                  } else {
                                    showFlushBar(
                                      context: context,
                                      message:
                                          "Password must meet required security strength",
                                      success: false,
                                    );
                                  }
                                }
                              },
                              buttonText: "Create new password",
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
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

  bool allResultsTrue() => _results.every((result) => result);
}
