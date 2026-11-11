import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/contribution_type.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_quote_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/select_payment_method.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/bottom_sheet_header.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/naira_display.dart';

class DonationSummary extends ConsumerStatefulWidget {
  final String amount;
  final String currency;
  final String campaign;
  final String? email;
  final bool isGuest;
  final ContributionType contributionType;
  final String donationPurpose;

  const DonationSummary({
    super.key,
    required this.amount,
    required this.currency,
    required this.donationPurpose,
    this.campaign = '',
    this.isGuest = false,
    this.email,
    this.contributionType = ContributionType.donation,
  });

  @override
  ConsumerState<DonationSummary> createState() => _DonationSummaryState();
}

class _DonationSummaryState extends ConsumerState<DonationSummary> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchQuoteData();
    });
  }

  void _fetchQuoteData() async {
    ref
        .read(donationQuoteVm)
        .getDonationQuote(amount: widget.amount, currency: widget.currency);
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(donationQuoteVm);
    final userVm = ref.watch(userViewModel);

    return Builder(
      builder: (context) {
        if (vm.state == ViewState.busy) {
          return AppLoader();
        }
        if (vm.state == ViewState.error) {
          return ErrorState(
            message: vm.message,
            onPressed: () => _fetchQuoteData(),
          );
        }

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeader(headerTitle: "Confirm Your Donation"),
              SizedBox(height: 24.h),
              IcobaContainer(
                bgColor: ColorPath.athensGrey5,
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Total Amount")],
                    ),
                    NairaDisplay(
                      amount: double.tryParse(vm.total) ?? 0,
                      currencyCode: widget.currency,
                      color: ColorPath.brandColor,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Includes ${vm.currency} ${Utilities.formatAmount(amount: double.tryParse(vm.serviceFee))} Service fee",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              InfoText(title: "Campaign", data: widget.campaign),
              Divider(color: ColorPath.geyserGrey),
              if (!widget.isGuest)
                Column(
                  children: [
                    InfoText(title: "Donor", data: userVm.fullName),
                    Divider(color: ColorPath.geyserGrey),
                    InfoText(
                      title: "Donor Type",
                      data: userVm.user?.donor?.type?.label ?? "N/A",
                    ),
                    Divider(color: ColorPath.geyserGrey),
                  ],
                ),
              InfoText(title: "Email", data: widget.email ?? ""),
              Divider(color: ColorPath.geyserGrey),
              InfoText(
                title: "Donation Amount",
                data:
                    "${vm.currency} ${Utilities.formatAmount(amount: double.tryParse(vm.amount))}",
              ),
              Divider(color: ColorPath.geyserGrey),
              InfoText(
                title: "Service fee",
                data:
                    "${vm.currency} ${Utilities.formatAmount(amount: double.tryParse(vm.serviceFee))}",
              ),
              Divider(color: ColorPath.geyserGrey),
              InfoText(
                title: "Total amount",
                data:
                    "${vm.currency} ${Utilities.formatAmount(amount: double.tryParse(vm.total))}",
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  "You will be redirected to complete payment securely.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                onPressed: () {
                  replaceNavigation(
                    context: context,
                    widget: SelectPaymentMethod(
                      amount: Utilities.formatToDouble(value: widget.amount),
                      contributionType: widget.contributionType,
                      donationPurpose: widget.donationPurpose,
                      isGuest: widget.isGuest,
                    ),
                    routeName: NamedRoutes.selectedPaymentMethod,
                  );
                },
                buttonText: "Proceed to Payment",
              ),
              SizedBox(height: 8.h),
              CustomButton(
                onPressed: () {
                  popNavigation(context: context);
                },
                borderColor: ColorPath.brandColor,
                useBorderColor: true,
                buttonText: "Go back and edit",
              ),
            ],
          ),
        );
      },
    );
  }
}

class InfoText extends StatelessWidget {
  final String title;
  final String data;
  const InfoText({super.key, this.title = "", this.data = ""});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.textSecondary,
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.end,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
