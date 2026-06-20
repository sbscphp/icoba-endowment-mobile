import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../count_down_timer.dart';
import 'bs_header.dart';

class AccountVerificationBs extends StatefulWidget {
  const AccountVerificationBs({super.key});

  @override
  State<AccountVerificationBs> createState() => _AccountVerificationBsState();
}

class _AccountVerificationBsState extends State<AccountVerificationBs> {
  final _otp = PinInputController();
  late final DateTime _otpEndTime;
  @override
  void initState() {
    super.initState();
    _otpEndTime = DateTime.now().add(
      Duration(
        seconds:
            (
            // widget.durationInSeconds ??
            30),
      ),
    );
  }

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
              Text(
                "Account Verification",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "A six digit OTP code to your email aji****@gmail.com, kindly enter the code below.",
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              MaterialPinField(
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
                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                  focusedBorderColor: ColorPath.brandColor, //FOCUS BORDER COLOR
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
                onChanged: (value) {
                  _otp.text;
                  //model.otp = value;
                },
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
                                      // await vm.resendOtp(
                                      //   challengeToken:
                                      //       widget.challengeToken ?? "",
                                      // );

                                      // showFlushBar(
                                      //   context: context,
                                      //   message: vm.message,
                                      //   success:
                                      //       vm.state == ViewState.retrieved,
                                      // );
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
                onPressed: () {
                  showFlushBar(context: context, message: "Account Logged in");
                },
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
