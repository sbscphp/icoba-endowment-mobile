import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/data/enum/otp_type.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/auth/auth_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/biometric_utils.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/forgot_password.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav.dart';
import 'package:icoba_endowment_mobile/ui/pages/onboarding/signup_options.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:icoba_endowment_mobile/ui/widgets/busy_overlay.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/utilities/navigator.dart';
import '../../../core/utilities/utilities.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/bottom_sheets/account_verification_bs.dart';
import '../../widgets/clickable.dart';
import '../../widgets/donation_header.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isObscured = true;
  bool isBio = false;

  Future<void> _fetchCachedUser() async {
    final vm = ref.read(authViewModel);
    await vm.getCachedUser();
    _email.text = vm.userMail ?? "";
    setState(() {});
  }

  Future<void> _isDeviceBiometricCapable() async {
    isBio = await BiometricUtils.canAuthenticate();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCachedUser();
      _isDeviceBiometricCapable();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(authViewModel);

    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: CustomScaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: "Password ",
                  controller: _pwd,
                  hintText: "Enter password",
                  keyboardType: TextInputType.visiblePassword,
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
                  onPressed: () async {
                    Utilities.hideKeyboard(context);

                    final validate = _formKey.currentState!.validate();
                    if (validate) {
                      await vm.login(email: _email.text, password: _pwd.text);

                      if (vm.state == ViewState.retrieved) {
                        if (vm.is2FA) {
                          baseBottomSheet(
                            context: context,
                            isDismissible: false,
                            isScrollControlled: false,
                            content: AccountVerificationBs(
                              otpType: OtpType.twoFA,
                              durationInSeconds: vm.twoFaDuration,
                            ),
                          );
                          return;
                        }
                        if (vm.isEmailVerification) {
                          baseBottomSheet(
                            context: context,
                            isDismissible: false,
                            isScrollControlled: false,
                            content: AccountVerificationBs(
                              durationInSeconds: vm.twoFaDuration,
                            ),
                          );
                          return;
                        }
                        pushAndClearAllNavigation(
                          context: context,
                          widget: BottomNav(),
                          routeName: NamedRoutes.bottomNav,
                        );
                      } else {
                        showFlushBar(
                          context: context,
                          message: vm.message,
                          success: false,
                        );
                      }
                    }

                    // baseBottomSheet(
                    //   context: context,
                    //   content: AccountVerificationBs(),
                    // );
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
                if (isBio && vm.userMail != null && vm.isUserBioUser)
                  Column(
                    children: [
                      SizedBox(height: 42.h),
                      Clickable(
                        onPressed: () async {
                          final canLogin = await BiometricUtils.authenticate();
                          if (canLogin ?? false) {
                            await vm.login(
                              isBiometricLogin: true,
                              email: _email.text,
                            );
                            if (vm.state == ViewState.retrieved) {
                              if (vm.is2FA) {
                                baseBottomSheet(
                                  context: context,
                                  isDismissible: false,
                                  isScrollControlled: false,
                                  content: AccountVerificationBs(
                                    otpType: OtpType.twoFA,
                                    durationInSeconds: vm.twoFaDuration,
                                  ),
                                );
                                return;
                              }
                              if (vm.isEmailVerification) {
                                baseBottomSheet(
                                  context: context,
                                  isDismissible: false,
                                  isScrollControlled: false,
                                  content: AccountVerificationBs(
                                    otpType: OtpType.verifyEmail,
                                    durationInSeconds: vm.twoFaDuration,
                                  ),
                                );
                                return;
                              }
                              pushAndClearAllNavigation(
                                context: context,
                                widget: BottomNav(),
                                routeName: NamedRoutes.bottomNav,
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
                              message: "Biometrics failed",
                              success: false,
                            );
                          }
                        },
                        child: IcobaContainer(
                          shape: BoxShape.circle,
                          padding: EdgeInsets.all(8.w),
                          borderRadius: BorderRadius.circular(20.r),
                          bgColor: ColorPath.athensGrey,
                          child: CustomAssetViewer(
                            asset: Platform.isIOS
                                ? AppAsset.biometricFace
                                : AppAsset.biometricFingerPrint,
                            height: 32,
                            width: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
