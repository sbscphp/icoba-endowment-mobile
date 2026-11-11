import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/auth/auth_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/core/utilities/validator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/contribution_amount.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/account_verification_bs.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/country_code_bottom_sheet.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/select_option_bottom_sheet.dart';
import 'package:icoba_endowment_mobile/ui/widgets/busy_overlay.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_radio_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_tooltip.dart';
import 'package:icoba_endowment_mobile/ui/widgets/screen_title.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/data/enum/signup_type.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/auth/password_requirement.dart';

class Signup extends ConsumerStatefulWidget {
  final SignupType signupType;
  final String? titlePrefix;
  final bool isDonation;

  const Signup({
    super.key,
    required this.signupType,
    this.titlePrefix,
    this.isDonation = false,
  });

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resetForm();
    });
  }

  resetForm() {
    final vm = ref.read(authViewModel);
    vm.selectedCountry = vm.countries.firstWhere(
      (e) => e.name?.toLowerCase() == 'nigeria',
    );
    vm.selectedSet = null;
    vm.selectedCorporateCategory = null;
    setState(() {});
  }

  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _set = TextEditingController();
  final TextEditingController _house = TextEditingController();
  final TextEditingController _wivesChapter = TextEditingController();
  final TextEditingController _alumniId = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // CORP BODY
  final TextEditingController _category = TextEditingController();
  final TextEditingController _organizationName = TextEditingController();
  final TextEditingController _rcNumber = TextEditingController();
  final TextEditingController _tin = TextEditingController();

  String iso2 = "NG";

  final _formKey = GlobalKey<FormState>();
  bool isObscured = true;
  List<bool> _results = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(authViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: CustomScaffold(
        appBar: customAppBar(context: context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(
                  title:
                      "${widget.titlePrefix} ${widget.isDonation ? "" : "Sign Up"}",
                  subtitle: widget.isDonation
                      ? "Provide your information to donate to a campaign"
                      : "Sign up on the ICOBA endowment application.",
                ),
                SizedBox(height: 24.h),
                //?? CORPORATE
                if (widget.signupType == SignupType.corporateDonor)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Clickable(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: SelectOptionBottomSheet(
                              bottomSheetTitle: "Select Category",
                              options: vm.corporateCategories
                                  .map((e) => e.name ?? "N/A")
                                  .toList(),
                              onOptionSelected: (value) {
                                setState(() {
                                  _category.text = value;
                                  vm.selectedCorporateCategory = vm
                                      .corporateCategories
                                      .firstWhere(
                                        (element) => element.name == value,
                                        orElse: () =>
                                            vm.corporateCategories.first,
                                      );
                                });
                              },
                              selectedOption: _set.text,
                            ),
                          );
                        },
                        child: CustomTextField(
                          label: "Category",
                          controller: _category,
                          enabled: false,
                          readOnly: true,
                          hintText: "Select category",
                          validator:
                              widget.signupType == SignupType.corporateDonor
                              ? FieldValidator.validate
                              : null,
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
                        controller: _organizationName,
                        validator:
                            widget.signupType == SignupType.corporateDonor
                            ? FieldValidator.validate
                            : null,
                        hintText: "Enter organization name",
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: "RC Number",
                        controller: _rcNumber,
                        validator:
                            widget.signupType == SignupType.corporateDonor
                            ? FieldValidator.validate
                            : null,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8),
                        ],
                        // keyboardType: TextInputType.,
                        hintText: "Enter RC Number",
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: "TIN",
                        controller: _tin,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(15),
                        ],
                        keyboardType: TextInputType.number,
                        validator:
                            widget.signupType == SignupType.corporateDonor
                            ? FieldValidator.validate
                            : null,
                        hintText: "Enter TIN",
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Text("Is Organization owned by an ICOBA Member"),
                          SizedBox(width: 8),
                          CustomTooltip(
                            tipMessage:
                                "Select Yes if your organisation is owned or led by an Igbobian (an old boy of Igbobi College).",
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Clickable(
                            onPressed: () {
                              vm.isIgbobianOwned = true;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                CustomRadioButton(
                                  value: vm.isIgbobianOwned == true,
                                ),
                                SizedBox(width: 6.h),
                                Text("Yes"),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.h),

                          Clickable(
                            onPressed: () {
                              vm.isIgbobianOwned = false;
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                CustomRadioButton(
                                  value: vm.isIgbobianOwned == false,
                                ),
                                SizedBox(width: 6.h),
                                Text("No"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (vm.isIgbobianOwned == true)
                        Column(
                          children: [
                            Clickable(
                              onPressed: () {
                                baseBottomSheet(
                                  context: context,
                                  content: SelectOptionBottomSheet(
                                    bottomSheetTitle: "Select Affiliated Set",
                                    options: vm.sets
                                        .map((e) => e.name ?? "N/A")
                                        .toList(),
                                    onOptionSelected: (value) {
                                      setState(() {
                                        _set.text = value;
                                        vm.selectedSet = vm.sets.firstWhere(
                                          (element) => element.name == value,
                                          orElse: () => vm.sets.first,
                                        );
                                      });
                                    },
                                    selectedOption: _set.text,
                                  ),
                                );
                              },
                              child: CustomTextField(
                                label: "Affiliated Set",
                                controller: _set,
                                toolTip: CustomTooltip(
                                  tipMessage:
                                      "The graduation set of the Igbobian who owns or leads your organisation. This lets your organisation's giving count towards that set.",
                                ),
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
                            Clickable(
                              onPressed: () {
                                baseBottomSheet(
                                  context: context,
                                  content: SelectOptionBottomSheet(
                                    bottomSheetTitle: "Select House",
                                    options: vm.houses
                                        .map((e) => e.label ?? "N/A")
                                        .toList(),
                                    onOptionSelected: (value) {
                                      setState(() {
                                        _house.text = value;
                                        vm.selectedHouse = vm.houses.firstWhere(
                                          (element) => element.label == value,
                                          orElse: () => vm.houses.first,
                                        );
                                      });
                                    },
                                    selectedOption: _house.text,
                                  ),
                                );
                              },
                              child: CustomTextField(
                                label: "House",
                                controller: _house,
                                toolTip: CustomTooltip(
                                  tipMessage:
                                      "The school house of the Igbobian who owns or leads your organisation.",
                                ),
                                enabled: false,
                                readOnly: true,
                                hintText: "Select House",
                                // validator: FieldValidator.validate,
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
                          ],
                        ),
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
                              controller: _fname,
                              validator:
                                  widget.signupType != SignupType.corporateDonor
                                  ? FieldValidator.validate
                                  : null,
                              hintText: "Enter First name",
                            ),
                          ),
                          SizedBox(width: 18.w),
                          Expanded(
                            child: CustomTextField(
                              label: "Last name",
                              controller: _lname,
                              validator:
                                  widget.signupType != SignupType.corporateDonor
                                  ? FieldValidator.validate
                                  : null,
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
                              onPressed: () {
                                baseBottomSheet(
                                  context: context,
                                  content: SelectOptionBottomSheet(
                                    bottomSheetTitle: "Select Set",
                                    options: vm.sets
                                        .map((e) => e.name ?? "N/A")
                                        .toList(),
                                    onOptionSelected: (value) {
                                      setState(() {
                                        _set.text = value;
                                        vm.selectedSet = vm.sets.firstWhere(
                                          (element) => element.name == value,
                                          orElse: () => vm.sets.first,
                                        );
                                      });
                                    },
                                    selectedOption: _set.text,
                                  ),
                                );
                              },
                              child: CustomTextField(
                                label: "Graduation Set",
                                toolTip: CustomTooltip(
                                  tipMessage:
                                      "The year your set graduated from Igbobi College",
                                ),
                                controller: _set,
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
                            Clickable(
                              onPressed: () {
                                baseBottomSheet(
                                  context: context,
                                  content: SelectOptionBottomSheet(
                                    bottomSheetTitle: "Select House",
                                    options: vm.houses
                                        .map((e) => e.label ?? "N/A")
                                        .toList(),
                                    onOptionSelected: (value) {
                                      setState(() {
                                        _house.text = value;
                                        vm.selectedHouse = vm.houses.firstWhere(
                                          (element) => element.label == value,
                                          orElse: () => vm.houses.first,
                                        );
                                      });
                                    },
                                    selectedOption: _house.text,
                                  ),
                                );
                              },
                              child: CustomTextField(
                                label: "House",
                                controller: _house,
                                toolTip: CustomTooltip(
                                  tipMessage:
                                      "The school house you belonged to at Igbobi College: Parker, Townsend, Oluwole, Aggrey or Freeman.",
                                ),
                                enabled: false,
                                readOnly: true,
                                hintText: "Select House",
                                // validator: FieldValidator.validate,
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
                              controller: _alumniId,
                              hintText: "Enter ID",
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
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: "Phone number",
                  validator: PhoneNumberValidator.validatePhoneNumber,
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  hintText: "080-0000-0000",
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Clickable(
                      onPressed: () {
                        baseBottomSheet(
                          context: context,
                          content: CountryCodeBottomSheet(
                            onOptionSelected: (value) {
                              setState(() {
                                iso2 = value;
                              });
                            },
                            selectedOption: vm.selectedCountry,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            iso2,
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

                //?? WIVES
                if (widget.signupType == SignupType.wives)
                  Column(
                    children: [
                      Clickable(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: SelectOptionBottomSheet(
                              bottomSheetTitle: "Select Wives of ICOBA chapter",
                              options: vm.wivesChapter
                                  .map((e) => e.label ?? "N/A")
                                  .toList(),
                              onOptionSelected: (value) {
                                setState(() {
                                  _wivesChapter.text = value;
                                  vm.selectedWivesChapter = vm.wivesChapter
                                      .firstWhere(
                                        (element) => element.label == value,
                                        orElse: () => vm.wivesChapter.first,
                                      );
                                });
                              },
                              selectedOption: _wivesChapter.text,
                            ),
                          );
                        },
                        child: CustomTextField(
                          label: "Wives of ICOBA chapter",
                          controller: _wivesChapter,
                          toolTip: CustomTooltip(
                            tipMessage:
                                "The Wives of ICOBA chapter you belong to: ICOBANA Wives, Wives of ICOBA Europe, or Wives of ICOBA International.",
                          ),
                          enabled: false,
                          readOnly: true,
                          hintText: "Select your Wives of ICOBA chapter",
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
                      Clickable(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: SelectOptionBottomSheet(
                              bottomSheetTitle: "Select Affiliated Set",
                              options: vm.sets
                                  .map((e) => e.name ?? "N/A")
                                  .toList(),
                              onOptionSelected: (value) {
                                setState(() {
                                  _set.text = value;
                                  vm.selectedSet = vm.sets.firstWhere(
                                    (element) => element.name == value,
                                    orElse: () => vm.sets.first,
                                  );
                                });
                              },
                              selectedOption: _set.text,
                            ),
                          );
                        },
                        child: CustomTextField(
                          label: "Affiliated Set",
                          controller: _set,
                          toolTip: CustomTooltip(
                            tipMessage:
                                "The graduation set of your husband or the Igbobian you are connected to. This lets your giving count towards that set.",
                          ),
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
                      Clickable(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: SelectOptionBottomSheet(
                              bottomSheetTitle: "Select House",
                              options: vm.houses
                                  .map((e) => e.label ?? "N/A")
                                  .toList(),
                              onOptionSelected: (value) {
                                setState(() {
                                  _house.text = value;
                                  vm.selectedHouse = vm.houses.firstWhere(
                                    (element) => element.label == value,
                                    orElse: () => vm.houses.first,
                                  );
                                });
                              },
                              selectedOption: _house.text,
                            ),
                          );
                        },
                        child: CustomTextField(
                          label: "House",
                          controller: _house,
                          toolTip: CustomTooltip(
                            tipMessage:
                                "The school house your husband or the Igbobian you are connected to belonged to at Igbobi College.",
                          ),
                          enabled: false,
                          readOnly: true,
                          hintText: "Select House",
                          // validator: FieldValidator.validate,
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
                    ],
                  ),

                //?? FRIENDS AND RELATIVES
                if (widget.signupType == SignupType.familiesOfIcoba ||
                    widget.signupType == SignupType.friendOfIcoba)
                  Column(
                    children: [
                      Clickable(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: SelectOptionBottomSheet(
                              bottomSheetTitle: "Select Affiliated Set",
                              options: vm.sets
                                  .map((e) => e.name ?? "N/A")
                                  .toList(),
                              onOptionSelected: (value) {
                                setState(() {
                                  _set.text = value;
                                  vm.selectedSet = vm.sets.firstWhere(
                                    (element) => element.name == value,
                                    orElse: () => vm.sets.first,
                                  );
                                });
                              },
                              selectedOption: _set.text,
                            ),
                          );
                        },
                        child: CustomTextField(
                          label: "Affiliated Set",
                          controller: _set,
                          toolTip: CustomTooltip(
                            tipMessage:
                                widget.signupType == SignupType.friendOfIcoba
                                ? "The graduation set of the Igbobian who invited you to support the Endowment Fund. This lets your giving count towards that set."
                                : "The graduation set of the Igbobian you are related to. This lets your giving count towards that set.",
                          ),
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
                      Clickable(
                        onPressed: () {
                          baseBottomSheet(
                            context: context,
                            content: SelectOptionBottomSheet(
                              bottomSheetTitle: "Select House",
                              options: vm.houses
                                  .map((e) => e.label ?? "N/A")
                                  .toList(),
                              onOptionSelected: (value) {
                                setState(() {
                                  _house.text = value;
                                  vm.selectedHouse = vm.houses.firstWhere(
                                    (element) => element.label == value,
                                    orElse: () => vm.houses.first,
                                  );
                                });
                              },
                              selectedOption: _house.text,
                            ),
                          );
                        },
                        child: CustomTextField(
                          label: "House",
                          controller: _house,
                          toolTip: CustomTooltip(
                            tipMessage:
                                widget.signupType == SignupType.friendOfIcoba
                                ? "The school house of the Igbobian who invited you: Parker, Townsend, Oluwole, Aggrey or Freeman."
                                : "The school house of the Igbobian you are related to at Igbobi College.",
                          ),
                          enabled: false,
                          readOnly: true,
                          hintText: "Select House",
                          // validator: FieldValidator.validate,
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
                    ],
                  ),

                if (!widget.isDonation)
                  Column(
                    children: [
                      CustomTextField(
                        label: "Create Password ",
                        controller: _password,
                        hintText: "Enter password",
                        obscure: isObscured,
                        validator: widget.isDonation
                            ? null
                            : FieldValidator.validate,
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
                    ],
                  ),
                SizedBox(height: 24.h),
                CustomButton(
                  onPressed: () async {
                    Utilities.hideKeyboard(context);

                    final validate = _formKey.currentState!.validate();
                    if (validate) {
                      if (widget.isDonation) {
                        //donation as guest
                        final phoneNumber =
                            "${vm.selectedCountry?.dialCode}${Utilities.cleanPhoneNumber(phoneNumber: _phone.text).substring(1)}";
                        pushNavigation(
                          context: context,
                          widget: ContributionAmount(
                            isGuest: true,
                            guestEmail: handleParam(_email.text),
                            guestPhone: handleParam(phoneNumber),
                            guestFName: handleParam(_fname.text),
                            guestLName: handleParam(_lname.text),
                            guestOrganizationName: handleParam(
                              _organizationName.text,
                            ),
                            guestTIN: handleParam(_tin.text),
                            guestRCNumber: handleParam(_rcNumber.text),
                            guestCorporateUUID: handleParam(
                              vm.selectedCorporateCategory?.uuid ?? "",
                            ),
                            guestSetNumber: handleParam(
                              vm.selectedSet?.setNumber ?? "",
                            ),
                            guestAlumniId: handleParam(_alumniId.text),
                            guestDonorType: handleParam(
                              vm.selectedDonorType?.slug ?? "",
                            ),
                            guestHouse: handleParam(
                              vm.selectedHouse?.value ?? "",
                            ),
                            guestWifeChapter: handleParam(
                              vm.selectedWivesChapter?.value ?? "",
                            ),
                            isIgbobianOwned: vm.isIgbobianOwned,
                          ),
                          routeName: NamedRoutes.contributionAmount,
                        );
                        return;
                      }
                      if (allResultsTrue()) {
                        if (widget.signupType == SignupType.alumni) {
                          await vm.registerAlumni(
                            email: _email.text,
                            password: _password.text,
                            phone: _phone.text,
                            fname: _fname.text,
                            lname: _lname.text,
                            alumniId: _alumniId.text,
                          );
                        }
                        if (widget.signupType == SignupType.corporateDonor) {
                          await vm.registerCorporate(
                            email: _email.text,
                            password: _password.text,
                            phone: _phone.text,
                            orgName: _organizationName.text,
                            rcNumber: _rcNumber.text,
                            tin: _tin.text,
                          );
                        }
                        if (widget.signupType == SignupType.friendOfIcoba ||
                            widget.signupType == SignupType.familiesOfIcoba ||
                            widget.signupType == SignupType.wives ||
                            widget.signupType == SignupType.none) {
                          await vm.registerFriends(
                            email: _email.text,
                            password: _password.text,
                            phone: _phone.text,
                            fname: _fname.text,
                            lname: _lname.text,
                          );
                        }
                        if (vm.state == ViewState.retrieved) {
                          baseBottomSheet(
                            context: context,
                            content: AccountVerificationBs(
                              durationInSeconds: vm.timerDuration,
                            ),
                            isDismissible: false,
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
                  buttonText: widget.isDonation ? "Continue" : "Sign up",
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkPassWordRequirement({required String password}) {
    final hasMinLength = password.trim().length > 7;
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    _results = [hasMinLength, hasUpperCase, hasLowerCase, hasNumber, hasSymbol];
    setState(() {});
  }

  bool allResultsTrue() => _results.every((result) => result);

  String? handleParam(String args) => args.isEmpty ? null : args;
}
