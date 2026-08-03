import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/donation_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/guest_donation_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/bank_details.dart';
// import 'package:icoba_endowment_mobile/ui/pages/donation_and_pledge/card_details.dart';
import 'package:icoba_endowment_mobile/ui/widgets/busy_overlay.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/data/enum/contribution_type.dart';
import '../../widgets/custom_check.dart';
import '../../widgets/in_app_web_view.dart';

class SelectPaymentMethod extends ConsumerStatefulWidget {
  final double amount;
  final ContributionType contributionType;
  final bool isGuest;

  const SelectPaymentMethod({
    super.key,
    required this.amount,
    this.contributionType = ContributionType.donation,
    this.isGuest = false,
  });

  @override
  ConsumerState<SelectPaymentMethod> createState() =>
      _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends ConsumerState<SelectPaymentMethod> {
  bool isAnonymous = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(donationViewModel).selectedPaymentMethod = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(donationViewModel);
    final guestDonationVm = ref.watch(guestDonationViewModel);

    return BusyOverlay(
      show:
          vm.donationState == ViewState.busy ||
          guestDonationVm.donationState == ViewState.busy,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment method",
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final data = vm.paymentMethods[index];
                              return Clickable(
                                onPressed: () {
                                  vm.selectedPaymentMethod = data;
                                  setState(() {});
                                },
                                child: IcobaContainer(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: vm.selectedPaymentMethod == data
                                        ? ColorPath.brandColor
                                        : ColorPath.athensGrey4,
                                  ),
                                  padding: EdgeInsets.all(18.w),
                                  child: Row(
                                    children: [
                                      CustomCheck(
                                        isChecked:
                                            vm.selectedPaymentMethod == data,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(child: Text(data)),
                                      CustomAssetViewer(
                                        asset: index == 1
                                            ? AppAsset.cardsImage
                                            : AppAsset.bank,
                                        width: index == 1 ? 110 : null,
                                        useColorFilter: false,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 12.h),
                            itemCount: vm.paymentMethods.length,
                          ),
                          SizedBox(height: 32.h),
                          Text(
                            "Recognition and Privacy",
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Clickable(
                                onPressed: () {
                                  setState(() {
                                    isAnonymous = false;
                                  });
                                },
                                child: CustomCheck(
                                  isChecked: isAnonymous == false,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Show my name and amount gifted on the leaderboard",
                                      style: textTheme.bodyMedium?.copyWith(),
                                    ),
                                    Text(
                                      "Your name will be visible to admins and other contributors of this project",
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Clickable(
                                onPressed: () {
                                  setState(() {
                                    isAnonymous = true;
                                  });
                                },
                                child: CustomCheck(isChecked: isAnonymous),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Donate anonymously",
                                      style: textTheme.bodyMedium?.copyWith(),
                                    ),
                                    Text(
                                      "Your name will be not be visible to other contributors of this project",
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                        //!!! CARD DETAILS HANDLED BY STRIPE
                        // pushNavigation(
                        //   context: context,
                        //   widget: CardDetails(),
                        //   routeName: NamedRoutes.cardDetails,
                        // );

                        if (vm.selectedPaymentMethod == "Pay with Card") {
                          if (widget.isGuest) {
                            await guestDonationVm.stripeCheckout(
                              amount: widget.amount,
                              isAnonymous: isAnonymous,
                              donationType:
                                  widget.contributionType ==
                                      ContributionType.donation
                                  ? 'donation'
                                  : 'pledge',
                            );
                            if (guestDonationVm.donationState ==
                                ViewState.retrieved) {
                              //goto stripe
                              pushNavigation(
                                context: context,
                                widget: InAppWebView(
                                  url: guestDonationVm.checkoutUrl,
                                  title:
                                      widget.contributionType ==
                                          ContributionType.donation
                                      ? "Make a donation"
                                      : "Make Pledge",
                                  isGuest: widget.isGuest,
                                ),
                                routeName: NamedRoutes.inAppWebView,
                              );
                            } else {
                              showFlushBar(
                                context: context,
                                message: guestDonationVm.message,
                                success: false,
                              );
                            }
                          } else {
                            await vm.stripeCheckout(
                              amount: widget.amount,
                              isAnonymous: isAnonymous,
                              donationType:
                                  widget.contributionType ==
                                      ContributionType.donation
                                  ? 'donation'
                                  : 'pledge',
                            );
                            if (vm.donationState == ViewState.retrieved) {
                              //goto stripe
                              pushNavigation(
                                context: context,
                                widget: InAppWebView(
                                  url: vm.checkoutUrl,
                                  title:
                                      widget.contributionType ==
                                          ContributionType.donation
                                      ? "Make a donation"
                                      : "Make Pledge",
                                ),
                                routeName: NamedRoutes.inAppWebView,
                              );
                            } else {
                              showFlushBar(
                                context: context,
                                message: vm.message,
                                success: false,
                              );
                            }
                          }

                          return;
                        }
                        if (vm.selectedPaymentMethod == "Bank transfer") {
                          pushNavigation(
                            context: context,
                            widget: BankDetails(
                              amount: widget.amount,
                              contributionType: widget.contributionType,
                            ),
                            routeName: NamedRoutes.bankDetails,
                          );
                          return;
                        }

                        showFlushBar(
                          context: context,
                          message: "Select at least one Payment Method!",
                          success: false,
                        );
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
