import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/guest_donation_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/bottom_nav.dart';
import 'package:icoba_endowment_mobile/ui/pages/landing.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';
import 'package:icoba_endowment_mobile/ui/widgets/screen_title.dart';

import '../../../core/data/enum/contribution_type.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/donation_vm.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/show_flush_bar.dart';

class SuccessfulDonation extends ConsumerStatefulWidget {
  final ContributionType? contributionType;
  final bool verifyPayment;
  final bool isGuest;

  const SuccessfulDonation({
    super.key,
    this.contributionType = ContributionType.donation,
    this.verifyPayment = true,
    this.isGuest = false,
  });

  @override
  ConsumerState<SuccessfulDonation> createState() => _SuccessfulDonationState();
}

class _SuccessfulDonationState extends ConsumerState<SuccessfulDonation> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.verifyPayment) {
        verify();
      }
    });
    super.initState();
  }

  verify() async {
    final vm = ref.read(donationViewModel);
    final guestDonationVm = ref.read(guestDonationViewModel);

    if (widget.isGuest) {
      await guestDonationVm.manualVerifyDonation();

      if (guestDonationVm.donationState == ViewState.retrieved) {
      } else {
        popNavigation(context: context);
        showFlushBar(
          context: context,
          message: guestDonationVm.message,
          success: false,
        );
      }
    } else {
      await vm.manualVerifyDonation();

      if (vm.donationState == ViewState.retrieved) {
      } else {
        popNavigation(context: context);
        showFlushBar(context: context, message: vm.message, success: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(donationViewModel);
    final guestDonationVm = ref.watch(guestDonationViewModel);

    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: widget.contributionType == ContributionType.donation
            ? "Make a donation"
            : "Make Pledge",
        leadingIconOnPressed: () {
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
        },
      ),
      body:
          vm.donationState == ViewState.busy ||
              guestDonationVm.donationState == ViewState.busy
          ? const Center(child: AppLoader(size: 80))
          : Container(
              color: ColorPath.athensGrey4,
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: ListView(
                children: [
                  SizedBox(height: 24.h),
                  CustomAssetViewer(
                    asset:
                        guestDonationVm.receiptNumber != "" ||
                            vm.receiptNumber != ""
                        ? AppAsset.success
                        : AppAsset.error,
                    useColorFilter: false,
                    height: 105.h,
                    width: 105.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    guestDonationVm.receiptNumber != "" ||
                            vm.receiptNumber != ""
                        ? "Transaction successful!"
                        : "Transaction failed!",
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    guestDonationVm.receiptNumber != "" ||
                            vm.receiptNumber != ""
                        ? "You have made an impact to this project. We appreciate your contribution to this cause."
                        : "We could not complete this transaction at this time, kindly try again.",
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  if (guestDonationVm.receiptNumber != "" ||
                      vm.receiptNumber != "")
                    CustomButton(
                      onPressed: () async {
                        await vm.downloadReceipt(
                          receiptNumber: widget.isGuest
                              ? guestDonationVm.receiptNumber
                              : vm.receiptNumber,
                        );
                        if (vm.state == ViewState.error) {
                          showFlushBar(
                            context: context,
                            message: vm.message,
                            success: false,
                          );
                        }
                      },
                      showLoader: vm.state == ViewState.busy,
                      buttonText: "Download receipt",
                    ),
                  if (guestDonationVm.receiptNumber != "" ||
                      vm.receiptNumber != "")
                    SizedBox(height: 12.h),
                  CustomButton(
                    onPressed: () {
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
                    },
                    buttonText: "Done",
                    borderColor: ColorPath.brandColor,
                    useBorderColor: true,
                  ),
                  SizedBox(height: 8.h),
                  //Donation Tuer info
                  IcobaContainer(
                    margin: EdgeInsets.only(top: 16.h),
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenTitle(
                          title: "Donation tiers",
                          subtitle:
                              "Donation badges are given according to the amount donated. See tier below.",
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Below 1 million naira",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            IcobaTag(type: "friends"),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "1 million - 9 million naira",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            IcobaTag(type: "bronze"),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "10 million - 99 million naira",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            IcobaTag(type: "silver"),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "10 million - 99 million naira",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            IcobaTag(type: "gold"),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "10 million - 99 million naira",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            IcobaTag(type: "platinum"),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "10 million - 99 million naira",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            IcobaTag(),
                          ],
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
