import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/info_data.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/auth/auth_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/guest_donation_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/input_formatters/money_input_formatter.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/pledge_summary.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/donation_summary.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/select_option_bottom_sheet.dart';
import 'package:icoba_endowment_mobile/ui/widgets/busy_overlay.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_text_field.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/data/enum/contribution_type.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_check.dart';

class ContributionAmount extends ConsumerStatefulWidget {
  final ContributionType contributionType;
  final bool isGuest;
  //GUEST DETAILS
  final String? guestEmail;
  final String? guestPhone;
  final String? guestFName;
  final String? guestLName;
  final String? guestOrganizationName;
  final String? guestTIN;
  final String? guestRCNumber;
  final String? guestCorporateUUID;
  final String? guestDonorType;
  final String? guestSetNumber;
  final String? guestAlumniId;
  final String? guestHouse;
  final String? guestWifeChapter;
  final bool? isIgbobianOwned;

  const ContributionAmount({
    super.key,
    this.contributionType = ContributionType.donation,
    this.isGuest = false,
    //guests
    this.guestEmail,
    this.guestPhone,
    this.guestFName,
    this.guestLName,
    this.guestOrganizationName,
    this.guestTIN,
    this.guestRCNumber,
    this.guestCorporateUUID,
    this.guestDonorType,
    this.guestSetNumber,
    this.guestAlumniId,
    this.guestHouse,
    this.guestWifeChapter,
    this.isIgbobianOwned,
  });

  @override
  ConsumerState<ContributionAmount> createState() => _ContributionAmountState();
}

class _ContributionAmountState extends ConsumerState<ContributionAmount> {
  final TextEditingController _campaignSelection = TextEditingController();
  final TextEditingController _donationPurpose = TextEditingController();
  final TextEditingController _otherPurpose = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  InfoData? selectedPurpose;

  //pledge
  final TextEditingController _pledgeType = TextEditingController();
  final TextEditingController _planType = TextEditingController();
  //custom
  final TextEditingController _installmentCount = TextEditingController();
  final TextEditingController _interval = TextEditingController();
  bool isAnonymous = false;

  @override
  void initState() {
    final vm = ref.read(donationViewModel);
    final guestDonorvm = ref.read(guestDonationViewModel);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //resets form
      vm.selectedCampaign = null;
      vm.selectedAmount = "";
      vm.selectedMothCount = null;
      vm.selectedPlanType = null;
      vm.selectedPledgeType = null;
      //guest
      guestDonorvm.selectedCampaign = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(donationViewModel);
    final userVm = ref.watch(userViewModel);
    final guestDonorVm = ref.watch(guestDonationViewModel);
    final authVm = ref.watch(authViewModel);

    return BusyOverlay(
      show: vm.pledgeState == ViewState.busy,
      child: CustomScaffold(
        useHorizontalPadding: false,
        useSafeArea: false,
        appBar: customAppBar(
          context: context,
          title: widget.contributionType == ContributionType.donation
              ? "Make a donation"
              : "Make Pledge",
          useChevLeft: true,
        ),
        body: Container(
          color: ColorPath.athensGrey4,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    IcobaContainer(
                      margin: EdgeInsets.only(top: 16.h),
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          Clickable(
                            onPressed: () {
                              baseBottomSheet(
                                context: context,
                                content: SelectOptionBottomSheet(
                                  bottomSheetTitle: "Select Campaign",
                                  selectedOption: _campaignSelection.text,
                                  onOptionSelected: (value) async {
                                    if (widget.isGuest) {
                                      guestDonorVm.selectedCampaign = vm
                                          .campaigns
                                          .firstWhere(
                                            (e) => e.name == value,
                                            orElse: () => vm.campaigns.first,
                                          );
                                    }
                                    vm.selectedCampaign = vm.campaigns
                                        .firstWhere(
                                          (e) => e.name == value,
                                          orElse: () => vm.campaigns.first,
                                        );

                                    _campaignSelection.text = value;
                                    setState(() {});

                                    //fetch campaign details
                                    vm.getSingleCampaign();
                                  },
                                  options: vm.campaigns
                                      .map((e) => e.name ?? "")
                                      .toList(),
                                ),
                              );
                            },
                            child: CustomTextField(
                              label:
                                  "Designate ${widget.contributionType == ContributionType.donation ? "donation" : "pledge"} to",
                              labelFontWeight: FontWeight.bold,
                              controller: _campaignSelection,
                              enabled: false,
                              readOnly: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: ColorPath.gullGrey,
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
                                  bottomSheetTitle: "Select Purpose",
                                  options: [
                                    ...authVm.donationPurposes
                                        .map((e) => e.label ?? "N/A")
                                        .toList(),
                                    "Other",
                                  ],
                                  onOptionSelected: (value) {
                                    setState(() {
                                      _donationPurpose.text = value;
                                      if (value == "Other") {
                                        selectedPurpose = null;
                                      } else {
                                        selectedPurpose = authVm
                                            .donationPurposes
                                            .firstWhere(
                                              (element) =>
                                                  element.label == value,
                                              orElse: () =>
                                                  authVm.donationPurposes.first,
                                            );
                                      }
                                    });
                                  },
                                  selectedOption: _donationPurpose.text,
                                ),
                              );
                            },
                            child: CustomTextField(
                              label:
                                  "${widget.contributionType == ContributionType.donation ? "Donation" : "Pledge"}  Purpose",
                              labelFontWeight: FontWeight.bold,
                              controller: _donationPurpose,
                              enabled: false,
                              readOnly: true,
                              hintText: "Select Purpose",
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
                          if (_donationPurpose.text == "Other")
                            Column(
                              children: [
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  label: "Other Purpose",
                                  labelFontWeight: FontWeight.bold,
                                  controller: _otherPurpose,
                                  hintText: "Enter donation purpose",
                                ),
                              ],
                            ),

                          if (vm.selectedCampaign != null)
                            Builder(
                              builder: (context) {
                                if (vm.donationState == ViewState.busy) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: LinearProgressIndicator(
                                      color: ColorPath.brandColor,
                                      backgroundColor: ColorPath.brandColor2,
                                    ),
                                  );
                                }
                                if (vm.donationState == ViewState.error) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: ErrorState(
                                      message: vm.message,
                                      onPressed: () {
                                        vm.getSingleCampaign();
                                      },
                                    ),
                                  );
                                }

                                return Column(
                                  children: [
                                    SizedBox(height: 24.h),
                                    Divider(color: ColorPath.galleryGrey),
                                    SizedBox(height: 24.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Enter amount",
                                          style: textTheme.bodyLarge?.copyWith(
                                            color: colorScheme.textPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //Currency Selector
                                        Clickable(
                                          onPressed: () {
                                            baseBottomSheet(
                                              context: context,
                                              content: SelectOptionBottomSheet(
                                                options: vm.supportedCurrencies,
                                                onOptionSelected: (value) {
                                                  vm.selectedCurrency = value;
                                                  if (widget.isGuest) {
                                                    guestDonorVm
                                                            .selectedCurrency =
                                                        value;
                                                  }
                                                  _amount.clear();
                                                  vm.selectedAmount = "";
                                                  setState(() {});
                                                },
                                                bottomSheetTitle:
                                                    "Select Currency",
                                                selectedOption:
                                                    vm.selectedCurrency,
                                              ),
                                            );
                                          },
                                          child: IcobaContainer(
                                            borderRadius: BorderRadius.circular(
                                              24.r,
                                            ),
                                            bgColor: ColorPath.athensGrey4,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                CustomAssetViewer(
                                                  asset: _handleCurrencySVG(
                                                    vm.selectedCurrency,
                                                  ),
                                                  useColorFilter: false,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(vm.selectedCurrency ?? ""),
                                                Icon(Icons.keyboard_arrow_down),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                    //Amount Prefiller
                                    SizedBox(
                                      height: 40.h,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final amount =
                                              vm.prefillAmount[index];
                                          return Clickable(
                                            onPressed: () {
                                              vm.selectedAmount = amount;
                                              _amount.text =
                                                  "${vm.selectedCurrency} ${Utilities.formatAmount(amount: double.parse(amount.replaceAll(",", "")), addDecimal: false)}";
                                              setState(() {});
                                            },
                                            child: IcobaContainer(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              bgColor:
                                                  vm.selectedAmount == amount
                                                  ? ColorPath.iceBlue
                                                  : null,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 28.w,
                                                vertical: 10.h,
                                              ),
                                              border: Border.all(
                                                color:
                                                    vm.selectedAmount == amount
                                                    ? ColorPath.brandColor
                                                    : ColorPath.gullGrey,
                                              ),
                                              child: Text(
                                                "${Utilities.getCurrencySymbol(currencyCode: vm.selectedCurrency)}$amount",
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                      color:
                                                          vm.selectedAmount ==
                                                              amount
                                                          ? ColorPath.brandColor
                                                          : ColorPath.paleGrey,
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(width: 8.w),
                                        itemCount: vm.prefillAmount.length,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    IcobaContainer(
                                      bgColor: ColorPath.athensGrey5,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 24.h,
                                        horizontal: 12.w,
                                      ),
                                      child: Column(
                                        children: [
                                          Text("Enter amount to donate here"),
                                          SizedBox(height: 8.h),
                                          TextField(
                                            textAlign: TextAlign.center,
                                            controller: _amount,
                                            style: textTheme.titleLarge
                                                ?.copyWith(),
                                            onChanged: (val) {
                                              vm.selectedAmount = "";
                                              setState(() {});
                                            },
                                            inputFormatters: [
                                              MoneyInputFormatter(
                                                currencyString:
                                                    vm.selectedCurrency,
                                              ),
                                            ],
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "${Utilities.getCurrencySymbol(currencyCode: vm.selectedCurrency)} 00.00",
                                              hintStyle: textTheme.titleLarge
                                                  ?.copyWith(
                                                    color: ColorPath.gullGrey,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          if (widget.contributionType ==
                                  ContributionType.pledge &&
                              vm.selectedCampaign != null)
                            Column(
                              children: [
                                SizedBox(height: 24.h),
                                Clickable(
                                  onPressed: () {
                                    baseBottomSheet(
                                      context: context,
                                      content: SelectOptionBottomSheet(
                                        options: vm.pledgeTypes,
                                        selectedOption: _pledgeType.text,
                                        onOptionSelected: (value) {
                                          _pledgeType.text = value;
                                          if (value ==
                                              "One - time future payment") {
                                            vm.selectedPledgeType =
                                                "one_time_future";
                                          }
                                          if (value == "Monthly Installments") {
                                            vm.selectedPledgeType = "monthly";
                                          }
                                          if (value == "Custom schedule") {
                                            vm.selectedPledgeType = "custom";
                                          }
                                          setState(() {});
                                        },
                                        bottomSheetTitle: "Select pledge type",
                                      ),
                                    );
                                  },
                                  child: CustomTextField(
                                    label: "Pledge type",
                                    labelFontWeight: FontWeight.bold,
                                    readOnly: true,
                                    enabled: false,
                                    controller: _pledgeType,
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 12.w),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: ColorPath.gullGrey,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Clickable(
                                      onPressed: () {
                                        setState(() {
                                          isAnonymous = !isAnonymous;
                                        });
                                      },
                                      child: CustomCheck(
                                        isChecked: isAnonymous,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Pledge anonymously",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                          Text(
                                            "Your name will${isAnonymous ? " not" : ""} be visible to other contributors of this project",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                  color:
                                                      colorScheme.textSecondary,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          SizedBox(height: 16.h),
                          //!MONTHLY
                          if (vm.selectedPledgeType == "monthly")
                            IcobaContainer(
                              bgColor: ColorPath.athensGrey5,
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                                horizontal: 12.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Installment count"),
                                  SizedBox(height: 6.h),
                                  SizedBox(
                                    height: 40.h,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Clickable(
                                          onPressed: () {
                                            vm.selectedMothCount = (index + 2);
                                            setState(() {});
                                          },
                                          child: IcobaContainer(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            bgColor:
                                                vm.selectedMothCount ==
                                                    (index + 2)
                                                ? ColorPath.iceBlue
                                                : null,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 28.w,
                                              vertical: 10.h,
                                            ),
                                            border: Border.all(
                                              color:
                                                  vm.selectedMothCount ==
                                                      (index + 2)
                                                  ? ColorPath.brandColor
                                                  : ColorPath.gullGrey,
                                            ),
                                            child: Text(
                                              "${index + 2} months",
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                    color:
                                                        vm.selectedMothCount ==
                                                            (index + 2)
                                                        ? ColorPath.brandColor
                                                        : ColorPath.paleGrey,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 8.w),
                                      itemCount: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          //!CUSTOM
                          if (vm.selectedPledgeType == "custom")
                            IcobaContainer(
                              bgColor: ColorPath.athensGrey5,
                              padding: EdgeInsets.symmetric(
                                vertical: 24.h,
                                horizontal: 12.w,
                              ),
                              child: Column(
                                children: [
                                  Clickable(
                                    onPressed: () {
                                      baseBottomSheet(
                                        context: context,
                                        content: SelectOptionBottomSheet(
                                          bottomSheetTitle: "Select plan type",
                                          options: [
                                            "Daily",
                                            "Weekly",
                                            "Monthly",
                                          ],
                                          selectedOption: _planType.text,
                                          onOptionSelected: (value) {
                                            _planType.text = value;
                                            vm.selectedPlanType = value
                                                .toLowerCase();
                                            setState(() {});
                                          },
                                        ),
                                      );
                                    },
                                    child: CustomTextField(
                                      label: "Plan type",
                                      labelFontWeight: FontWeight.bold,
                                      readOnly: true,
                                      enabled: false,
                                      controller: _planType,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 12.w),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: ColorPath.gullGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          label: "Installment number",
                                          labelFontWeight: FontWeight.bold,
                                          controller: _installmentCount,
                                          hintText: "E.g 2",
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: CustomTextField(
                                          label: "Duration (intervals)",
                                          labelFontWeight: FontWeight.bold,
                                          controller: _interval,
                                          hintText: "E.g 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    CustomButton(
                      onPressed: () async {
                        //validations
                        if (vm.selectedCampaign == null) {
                          showFlushBar(
                            context: context,
                            message: "Kindly select Campaign to proceed",
                            success: false,
                          );
                          return;
                        }
                        if (_amount.text.isEmpty) {
                          showFlushBar(
                            context: context,
                            message: "Enter Amount to proceed",
                            success: false,
                          );
                          return;
                        }
                        if (_amount.text.isNotEmpty) {
                          if (Utilities.formatToDouble(value: _amount.text) <
                              1) {
                            showFlushBar(
                              context: context,
                              message:
                                  "Minimum amount must be greater than or equal to 1",
                              success: false,
                            );
                            return;
                          }
                        }
                        if (widget.contributionType ==
                            ContributionType.pledge) {
                          //validations
                          // if (vm.selectedPledgeType == 'one_time_future') {}

                          if (vm.selectedPledgeType == 'monthly') {
                            vm.selectedPlanType = null;
                            if (vm.selectedMothCount == null) {
                              showFlushBar(
                                context: context,
                                message:
                                    "Select monthly installment count to proceed",
                                success: false,
                              );
                              return;
                            }
                          }

                          if (vm.selectedPledgeType == 'custom') {
                            vm.selectedMothCount = null;
                            if (vm.selectedPlanType == null) {
                              showFlushBar(
                                context: context,
                                message: "Select plan type count to proceed",
                                success: false,
                              );
                              return;
                            }
                            if (_installmentCount.text.isEmpty) {
                              showFlushBar(
                                context: context,
                                message: "Enter installmment count to proceed",
                                success: false,
                              );
                              return;
                            }
                            if (_interval.text.isEmpty) {
                              showFlushBar(
                                context: context,
                                message: "Enter Duration to proceed",
                                success: false,
                              );
                              return;
                            }
                          }

                          await vm.createPledge(
                            amount: Utilities.formatToDouble(
                              value: _amount.text,
                            ),
                            installmentCount: _installmentCount.text,
                            interval: _interval.text,
                            isAnonymous: isAnonymous,
                          );

                          if (vm.pledgeState == ViewState.retrieved) {
                            pushNavigation(
                              context: context,
                              widget: PledgeSummary(
                                amount: Utilities.formatToDouble(
                                  value: _amount.text,
                                ),
                                donationPurpose:
                                    selectedPurpose?.label ??
                                    _otherPurpose.text,
                              ),
                              routeName: NamedRoutes.pledgeSummary,
                            );
                          } else {
                            showFlushBar(
                              context: context,
                              message: vm.message,
                              success: false,
                            );
                          }
                          pushNavigation(
                            context: context,
                            widget: PledgeSummary(
                              amount: Utilities.formatToDouble(
                                value: _amount.text,
                              ),
                              donationPurpose:
                                  selectedPurpose?.label ?? _otherPurpose.text,
                            ),
                            routeName: NamedRoutes.pledgeSummary,
                          );

                          return;
                        }

                        //set values if it's guest
                        if (widget.isGuest) {
                          guestDonorVm.email = widget.guestEmail;
                          guestDonorVm.phone = widget.guestPhone;
                          guestDonorVm.fName = widget.guestFName;
                          guestDonorVm.lName = widget.guestLName;
                          guestDonorVm.orgName = widget.guestOrganizationName;
                          guestDonorVm.tin = widget.guestTIN;
                          guestDonorVm.rcNumber = widget.guestRCNumber;
                          guestDonorVm.corporateUUID =
                              widget.guestCorporateUUID;
                          guestDonorVm.donorType = widget.guestDonorType;
                          guestDonorVm.setNumber = widget.guestSetNumber;
                          guestDonorVm.alumniID = widget.guestAlumniId;
                          guestDonorVm.icobawives = widget.guestWifeChapter;
                          guestDonorVm.house = widget.guestHouse;
                          guestDonorVm.purpose =
                              selectedPurpose?.label ?? _otherPurpose.text;
                        }

                        baseBottomSheet(
                          context: context,
                          content: DonationSummary(
                            campaign: vm.selectedCampaign?.name ?? "N/A",
                            amount: Utilities.formatToDouble(
                              value: _amount.text,
                            ).toString(),
                            currency: vm.selectedCurrency ?? "NGN",
                            isGuest: widget.isGuest,
                            donationPurpose:
                                selectedPurpose?.label ?? _otherPurpose.text,
                            email: widget.guestEmail ?? userVm.email,
                            contributionType: widget.contributionType,
                          ),
                        );

                        // pushNavigation(
                        //   context: context,
                        //   widget: SelectPaymentMethod(
                        //     amount: Utilities.formatToDouble(
                        //       value: _amount.text,
                        //     ),
                        //     contributionType: widget.contributionType,
                        //     isGuest: widget.isGuest,
                        //   ),
                        //   routeName: NamedRoutes.selectedPaymentMethod,
                        // );
                      },
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _handleCurrencySVG(String? val) {
    switch (val) {
      case "NGN":
        return AppAsset.ngn;
      case "USD":
        return AppAsset.usa;
      case "GBP":
        return AppAsset.gbp;
      default:
        return AppAsset.defaultcur;
    }
  }
}
