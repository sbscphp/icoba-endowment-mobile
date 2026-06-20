import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/validator.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';
import 'package:icoba_endowment_mobile/ui/widgets/screen_title.dart';

import '../../../core/data/enum/signup_type.dart';
import '../../widgets/auth/password_requirement.dart';

class Signup extends StatefulWidget {
  final SignupType signupType;
  const Signup({super.key, required this.signupType});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;
  List<bool> _results = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return CustomScaffold(
      appBar: customAppBar(context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(
              title: userTypeTitle(),
              subtitle: "Sign up on the ICOBA endowment application.",
            ),
            SizedBox(height: 24.h),
            if (widget.signupType == SignupType.corporateDonor)
              Column(
                children: [
                  Clickable(
                    onPressed: () {},
                    child: CustomTextField(
                      label: "Category",
                      enabled: false,
                      readOnly: true,
                      hintText: "Select category",
                      validator: FieldValidator.validate,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: colorScheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    label: "Organization name",
                    validator: FieldValidator.validate,
                    hintText: "Enter organization name",
                  ),
                  SizedBox(height: 16.h),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: "First name",
                          validator: FieldValidator.validate,
                          hintText: "Enter First name",
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: CustomTextField(
                          label: "Last name",
                          validator: FieldValidator.validate,
                          hintText: "Enter Last name",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  if (widget.signupType == SignupType.alumni)
                    Column(
                      children: [
                        Clickable(
                          onPressed: () {},
                          child: CustomTextField(
                            label: "Set",
                            enabled: false,
                            readOnly: true,
                            hintText: "Select set",
                            validator: FieldValidator.validate,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: colorScheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          label: "Alumni ID",
                          validator: FieldValidator.validate,
                          hintText: "Enter Last name",
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                ],
              ),

            CustomTextField(
              label: "Email",
              validator: EmailValidator.validateEmail,
              hintText: "Enter email address",
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              label: "Phone number",
              validator: PhoneNumberValidator.validatePhoneNumber,
              hintText: "+1 (555) 000-0000",
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Clickable(
                  onPressed: () {
                    //todo:::show country dialog here
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "US",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.textSecondary,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: colorScheme.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              label: "Create Password ",
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
            PasswordRequirement(results: _results),
            SizedBox(height: 24.h),
            CustomButton(onPressed: () {}, buttonText: "Sign up"),
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

  String userTypeTitle() {
    switch (widget.signupType) {
      case SignupType.corporateDonor:
        return "Corporate Donor Sign Up";
      case SignupType.alumni:
        return "Alumni Donor Sign Up";
      case SignupType.friendOfIcoba:
        return "Friends of ICOBA Donor Sign Up";
      case SignupType.familiesOfIcoba:
        return "Families of ICOBA Donor Sign Up";
    }
  }
}
