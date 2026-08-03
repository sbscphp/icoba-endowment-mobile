import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/signup_type.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/auth/auth_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/login.dart';
import 'package:icoba_endowment_mobile/ui/pages/onboarding/signup.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donation_header.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../widgets/custom_radio_button.dart';

class SignupOptions extends ConsumerStatefulWidget {
  final bool isDonation;
  const SignupOptions({super.key, this.isDonation = false});

  @override
  ConsumerState<SignupOptions> createState() => _SignupOptionsState();
}

class _SignupOptionsState extends ConsumerState<SignupOptions> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearForm();
    });
  }

  SignupType? signupType;

  void clearForm() {
    ref.read(authViewModel).selectedDonorType = null;
    setState(() {});
  }

  void _fetchOnbardingData() {
    final authVm = ref.read(authViewModel);
    authVm.getOnboardingDropdownData();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(authViewModel);

    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(height: 24.h),
          DonationHeader(
            title: widget.isDonation
                ? "Donate to a Campaign"
                : "Join the movement",
            subtitle: widget.isDonation
                ? "Choose how you want to donate"
                : "Choose how you want to register as a donor",
          ),
          SizedBox(height: 24.h),
          Builder(
            builder: (context) {
              if (vm.state == ViewState.busy) {
                return Expanded(child: AppLoader());
              }
              if (vm.state == ViewState.error) {
                return Expanded(
                  child: ErrorState(
                    buttonColor: ColorPath.brandColor,
                    message: vm.message,
                    onPressed: () {
                      _fetchOnbardingData();
                    },
                  ),
                );
              }
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 32.h),
                  itemBuilder: (context, index) {
                    final data = vm.donorTypes[index];
                    return Clickable(
                      onPressed: () {
                        setState(() {
                          vm.selectedDonorType = data;
                          signupType = data.signupType;
                        });
                      },
                      child: IcobaContainer(
                        padding: EdgeInsets.all(16),
                        border: Border.all(
                          color: vm.selectedDonorType == data
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
                                    data.label ?? "N/A",
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.brandColor,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    data.description ?? "N/A",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomRadioButton(
                              value: vm.selectedDonorType == data,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemCount: vm.donorTypes.length,
                ),
              );
            },
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
                    widget: Signup(
                      signupType: signupType!,
                      titlePrefix: vm.selectedDonorType?.label,
                      isDonation: widget.isDonation,
                    ),
                    routeName: NamedRoutes.signUp,
                  );
                },
          ),
          SizedBox(height: 16.h),
          if (!widget.isDonation)
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
