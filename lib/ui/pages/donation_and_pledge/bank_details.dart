import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/guest_donation_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/successful_donation.dart';
import 'package:icoba_endowment_mobile/ui/pages/landing.dart';
import 'package:icoba_endowment_mobile/ui/widgets/busy_overlay.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/data/enum/contribution_type.dart';

class BankDetails extends ConsumerStatefulWidget {
  final double amount;
  final ContributionType contributionType;
  final bool isGuest;

  const BankDetails({
    super.key,
    required this.amount,
    this.contributionType = ContributionType.donation,
    this.isGuest = false,
  });

  @override
  ConsumerState<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends ConsumerState<BankDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(donationViewModel).selectedAccount = null;
      ref.read(guestDonationViewModel).selectedAccount = null;

      ref.read(donationViewModel).initiateTransferResponse = null;
      ref.read(guestDonationViewModel).initiateTransferResponse = null;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(donationViewModel);
    final guestVm = ref.watch(guestDonationViewModel);

    return BusyOverlay(
      show:
          vm.donationState == ViewState.busy ||
          guestVm.donationState == ViewState.busy,
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
                child: IcobaContainer(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
                  height: double.infinity,
                  child:
                      vm.initiateTransferResponse == null &&
                          guestVm.initiateTransferResponse == null
                      ? ListView(
                          children: [
                            Text(
                              "Transfer this exact amount ",
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "${vm.selectedCurrency} ${widget.amount.toStringAsFixed(2)}",
                              style: textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "to any of the account below.",
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 16.h),
                            Text(
                              "Select any of the account below to transfer to",
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final bankAccount = vm.bankAccounts[index];
                                return Clickable(
                                  onPressed: () {
                                    //set if isGuest
                                    if (widget.isGuest) {
                                      guestVm.selectedAccount = bankAccount;
                                    }

                                    vm.selectedAccount = bankAccount;
                                    setState(() {});
                                  },
                                  child: IcobaContainer(
                                    padding: EdgeInsets.all(16.w),
                                    bgColor: ColorPath.athensGrey4,
                                    border: vm.selectedAccount == bankAccount
                                        ? Border.all(
                                            color: ColorPath.brandColor,
                                          )
                                        : null,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            color: ColorPath.brandColor,
                                          ),
                                          child: Text(
                                            "${bankAccount.currency} ACCOUNT",
                                            style: textTheme.bodySmall
                                                ?.copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorPath.white,
                                                ),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Bank:"),
                                            SizedBox(width: 12.w),
                                            Flexible(
                                              child: Text(
                                                vm.bankName,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Acct Name:"),
                                            SizedBox(width: 12.w),

                                            Flexible(
                                              child: Text(
                                                vm.accountName,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Acct No:"),
                                            SizedBox(width: 12.w),

                                            Expanded(
                                              child: Text(
                                                bankAccount.accountNumber ??
                                                    "N/A",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            Clickable(
                                              onPressed: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text:
                                                        bankAccount
                                                            .accountNumber ??
                                                        "N/A",
                                                  ),
                                                );
                                                showFlushBar(
                                                  context: context,
                                                  message:
                                                      "Account Number Copied Successfully",
                                                );
                                              },
                                              child: Icon(Icons.copy, size: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 16.h),
                              itemCount: vm.bankAccounts.length,
                            ),
                          ],
                        )
                      : ListView(
                          children: [
                            Text(
                              vm.initiateTransferResponse?.instructions ??
                                  guestVm
                                      .initiateTransferResponse
                                      ?.instructions ??
                                  "",
                            ),
                            SizedBox(height: 12.h),
                            IcobaContainer(
                              padding: EdgeInsets.all(16.w),
                              bgColor: ColorPath.athensGrey4,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: ColorPath.brandColor,
                                    ),
                                    child: Text(
                                      "${vm.initiateTransferResponse?.currency ?? guestVm.initiateTransferResponse?.currency ?? "N/A"} ACCOUNT",
                                      style: textTheme.bodySmall?.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPath.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Bank:"),
                                      SizedBox(width: 12.w),
                                      Flexible(
                                        child: Text(
                                          vm.bankName,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Acct Name:"),
                                      SizedBox(width: 12.w),

                                      Flexible(
                                        child: Text(
                                          vm.accountName,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Acct No:"),
                                      SizedBox(width: 12.w),

                                      Expanded(
                                        child: Text(
                                          vm.selectedAccount?.accountNumber ??
                                              "N/A",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Clickable(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text:
                                                  vm
                                                      .selectedAccount
                                                      ?.accountNumber ??
                                                  "N/A",
                                            ),
                                          );
                                          showFlushBar(
                                            context: context,
                                            message:
                                                "Account Number Copied Successfully",
                                          );
                                        },
                                        child: Icon(Icons.copy, size: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Transfer Reference:"),
                                      SizedBox(width: 12.w),

                                      Expanded(
                                        child: Text(
                                          vm
                                                  .initiateTransferResponse
                                                  ?.bankTransferReference ??
                                              guestVm
                                                  .initiateTransferResponse
                                                  ?.bankTransferReference ??
                                              "N/A",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Clickable(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text:
                                                  vm
                                                      .initiateTransferResponse
                                                      ?.bankTransferReference ??
                                                  "",
                                            ),
                                          );
                                          showFlushBar(
                                            context: context,
                                            message:
                                                "Reference Copied Successfully",
                                          );
                                        },
                                        child: Icon(Icons.copy, size: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    CustomButton(
                      buttonText:
                          vm.initiateTransferResponse == null &&
                              guestVm.initiateTransferResponse == null
                          ? "Initiate transfer"
                          : "I have sent the money",
                      onPressed: vm.selectedAccount == null
                          ? null
                          : () async {
                              if (widget.isGuest) {
                                if (guestVm.initiateTransferResponse == null) {
                                  await guestVm.initiateBankTransfer(
                                    amount: widget.amount,
                                  );

                                  if (guestVm.donationState ==
                                      ViewState.error) {
                                    showFlushBar(
                                      context: context,
                                      message: guestVm.message,
                                      success: false,
                                    );
                                  }

                                  return;
                                }
                                await guestVm.acknowledgeBankTransfer();
                                if (guestVm.donationState ==
                                    ViewState.retrieved) {
                                  if (widget.isGuest) {
                                    pushAndClearAllNavigation(
                                      context: context,
                                      widget: Landing(),
                                      routeName: NamedRoutes.landing,
                                    );
                                  } else {
                                    pushAndClearAllNavigation(
                                      context: context,
                                      widget: BottomNav(),
                                      routeName: NamedRoutes.bottomNav,
                                    );
                                  }
                                  showFlushBar(
                                    context: context,
                                    message: guestVm.message,
                                  );
                                } else {
                                  showFlushBar(
                                    context: context,
                                    message: guestVm.message,
                                    success: false,
                                  );
                                }
                              } else {
                                if (vm.initiateTransferResponse == null) {
                                  await vm.initiateBankTransfer(
                                    amount: widget.amount,
                                  );

                                  if (vm.donationState == ViewState.error) {
                                    showFlushBar(
                                      context: context,
                                      message: vm.message,
                                      success: false,
                                    );
                                  }

                                  return;
                                }
                                await vm.acknowledgeBankTransfer();
                                if (vm.donationState == ViewState.retrieved) {
                                  if (widget.isGuest) {
                                    pushAndClearAllNavigation(
                                      context: context,
                                      widget: Landing(),
                                      routeName: NamedRoutes.landing,
                                    );
                                  } else {
                                    pushAndClearAllNavigation(
                                      context: context,
                                      widget: BottomNav(),
                                      routeName: NamedRoutes.bottomNav,
                                    );
                                  }
                                  showFlushBar(
                                    context: context,
                                    message: vm.message,
                                  );
                                } else {
                                  showFlushBar(
                                    context: context,
                                    message: vm.message,
                                    success: false,
                                  );
                                }
                              }
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
}
