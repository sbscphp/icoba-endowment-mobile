import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/otp_type.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/forgot_password.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/data/view_models/auth/auth_vm.dart';
import '../count_down_timer.dart';
import 'bs_header.dart';

class AccountVerificationBs extends ConsumerStatefulWidget {
  final int? durationInSeconds;
  final OtpType otpType;
  const AccountVerificationBs({
    super.key,
    this.durationInSeconds,
    this.otpType = OtpType.createAccount,
  });

  @override
  ConsumerState<AccountVerificationBs> createState() =>
      _AccountVerificationBsState();
}

class _AccountVerificationBsState extends ConsumerState<AccountVerificationBs> {
  final _otp = PinInputController();
  late DateTime _otpEndTime;
  @override
  void initState() {
    super.initState();
    _otpEndTime = DateTime.now().add(
      Duration(seconds: (widget.durationInSeconds ?? 300)),
    );
  }

  void _resetTimer() {
    setState(() {
      _otpEndTime = DateTime.now().add(
        Duration(seconds: (widget.durationInSeconds ?? 300)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(authViewModel);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // header
        BsHeader(),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Text(
                "Account Verification",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "A six digit OTP code to your email, kindly enter the code below.",
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: MaterialPinField(
                    length: 6,
                    pinController: _otp,
                    mainAxisAlignment: MainAxisAlignment.center,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10.w);
                    },
                    obscureText: false,
                    // backgroundColor: Colors.transparent,
                    // obscuringCharacter: "*",
                    keyboardType: TextInputType.number,
                    // cursorColor: Theme.of(context).colorScheme.textPrimary,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintCharacter: "",
                    hintStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                    theme: MaterialPinTheme(
                      fillColor: Colors.transparent,
                      filledFillColor: Colors.transparent,
                      errorColor: ColorPath.crimsonRed,
                      errorBorderColor: ColorPath.crimsonRed,
                      cursorColor: ColorPath.brandColor,
                      focusedFillColor: Colors.transparent, //ACTIVE COLOR
                      borderColor: ColorPath.gullGrey, //UNFOCUSED COLOR
                      focusedBorderColor:
                          ColorPath.brandColor, //FOCUS BORDER COLOR
                      filledBorderColor: ColorPath.scampiBlue, //FILLED COLOR
                      shape: MaterialPinShape.outlined,
                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                      borderWidth: 1.w,
                    ),
                    enabled: true,

                    // appContext: context,
                    // animationDuration: const Duration(milliseconds: 300),
                    // enableActiveFill: true,
                    onCompleted: (v) {
                      debugPrint("Completed: $v");
                    },
                    // onChanged: (value) {
                    //   _otp.text;
                    //   //model.otp = value;
                    // },
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CountdownTimer(
                endTime: _otpEndTime,
                builder: (context, time) {
                  return Column(
                    children: [
                      if (time.minutes > 0 || time.seconds > 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Code will expire in ",
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.brandColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            IcobaContainer(
                              borderRadius: BorderRadius.zero,
                              padding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 8.w,
                              ),
                              child: Text(
                                "${time.minutes}:${time.seconds}s",
                                style: textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: colorScheme.redText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (time.minutes == 0 && time.seconds == 0)
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: "Didn’t get a code? ",
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.brandColor,
                                fontSize: 12.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: "Resend Code",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (widget.otpType ==
                                          OtpType.forgotPassword) {
                                        await vm.resendResetOTP();
                                        showFlushBar(
                                          context: context,
                                          message: vm.message,
                                          success:
                                              vm.thirdState ==
                                              ViewState.retrieved,
                                        );
                                        if (vm.thirdState ==
                                            ViewState.retrieved)
                                          _resetTimer();
                                        return;
                                      }
                                      if (widget.otpType == OtpType.twoFA) {
                                        await vm.resendLoginOTP();
                                        showFlushBar(
                                          context: context,
                                          message: vm.message,
                                          success:
                                              vm.thirdState ==
                                              ViewState.retrieved,
                                        );
                                        if (vm.thirdState ==
                                            ViewState.retrieved) {
                                          _resetTimer();
                                        }
                                        return;
                                      }
                                      //default: OtpType.createAccount,
                                      await vm.resendOTP();

                                      showFlushBar(
                                        context: context,
                                        message: vm.message,
                                        success:
                                            vm.thirdState ==
                                            ViewState.retrieved,
                                      );
                                      if (vm.thirdState == ViewState.retrieved)
                                        _resetTimer();
                                    },
                                  style: textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    // decoration: TextDecoration.underline,
                                    // decorationColor: colorScheme.redText,
                                    color: colorScheme.redText,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16.h),
              CustomButton(
                onPressed: () async {
                  if (_otp.text.isEmpty || _otp.text.length != 6) {
                    showFlushBar(
                      context: context,
                      message: "Provide Valid OTP to Proceed!",
                      success: false,
                    );
                    return;
                  }

                  if (widget.otpType == OtpType.forgotPassword) {
                    await vm.verifyResetOTP(otp: _otp.text);
                    if (vm.secondState == ViewState.retrieved) {
                      popNavigation(context: context);
                      replaceNavigation(
                        context: context,
                        widget: ForgotPassword(step: 2),
                        routeName: NamedRoutes.forgotPassword,
                      );
                    } else {
                      showFlushBar(
                        context: context,
                        message: vm.message,
                        success: false,
                      );
                    }
                    return;
                  }

                  if (widget.otpType == OtpType.twoFA) {
                    await vm.verifyLoginOTP(otp: _otp.text);
                    if (vm.secondState == ViewState.retrieved) {
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
                    return;
                  }

                  //default: OtpType.createAccount,
                  await vm.verifyOTP(otp: _otp.text);

                  if (vm.secondState == ViewState.retrieved) {
                    //push to bottom nav
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

                  // popNavigation(context: context);
                },
                showLoader:
                    vm.secondState == ViewState.busy ||
                    vm.thirdState == ViewState.busy,
                buttonText: "Verify",
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ],
    );
  }
}
