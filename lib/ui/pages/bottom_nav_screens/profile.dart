import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:icoba_endowment_mobile/ui/pages/authentication/forgot_password.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:icoba_endowment_mobile/ui/widgets/bottom_sheets/logout_bs.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/display_image.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/show_flush_bar.dart';

import '../../../core/data/view_models/user/user_vm.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userVm = ref.watch(userViewModel);

    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Text(
              "Profile & Settings",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        color: ColorPath.athensGrey4,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: RefreshIndicator(
          onRefresh: () async {
            userVm.getUserProfile();
          },
          child: ListView(
            padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
            children: [
              //INFO CARD
              IcobaContainer(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        DisplayImage(
                          image: null,
                          firstName: userVm.firstName,
                          lastName: userVm.lastName,
                          size: 56,
                          fontSize: 10.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userVm.fullName,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${userVm.email}\n${userVm.isOrganization
                                    ? "Corporate Donor"
                                    : userVm.setName == "N/A"
                                    ? ""
                                    : "${userVm.setName} set"}",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (userVm.tierBadgeUrl.isNotEmpty)
                          Image.network(
                            userVm.tierBadgeUrl,
                            height: 56.h,
                            width: 56.w,
                          ),
                        // CustomAssetViewer(
                        //   asset: AppAsset.bronzeBadge,
                        //   height: 56.h,
                        //   width: 56.w,
                        //   useColorFilter: false,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              //PROFILE INFO CARD
              IcobaContainer(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: ColorPath.athensGrey8),
                    SizedBox(height: 12.h),
                    //Org
                    // InfoText(title: "Organization", data: "WEMA BANK"),
                    // SizedBox(height: 12.h),
                    // InfoText(title: "Industry", data: "Banking Industry"),
                    // SizedBox(height: 12.h),
                    // InfoText(title: "Official email", data: Don"crs@wema.com"),
                    // SizedBox(height: 12.h),
                    // InfoText(title: "Phone number", data: "+2348098765432"),
                    // SizedBox(height: 12.h),
                    // InfoText(
                    //   title: "OContact person",
                    //   data: "Sheriff Olusanya Jacobs",
                    // ),
                    // SizedBox(height: 12.h),
                    //personal
                    InfoText(title: "Name", data: userVm.fullName),
                    SizedBox(height: 12.h),
                    if (!userVm.isOrganization)
                      InfoText(
                        title: "Set",
                        data:
                            "${userVm.setName == "N/A" ? "0000" : userVm.setName} set",
                      ),
                    if (!userVm.isOrganization) SizedBox(height: 12.h),
                    InfoText(title: "Email", data: userVm.email),
                    SizedBox(height: 12.h),
                    InfoText(title: "Phone number", data: userVm.phone),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              //SECURITY CARD
              IcobaContainer(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Security",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: ColorPath.athensGrey8),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: InfoText(
                            title: "Password",
                            data: "******************",
                          ),
                        ),
                        CustomButton(
                          onPressed: () {
                            pushNavigation(
                              context: context,
                              widget: ForgotPassword(
                                step: 2,
                                isPasswordReset: true,
                              ),
                              routeName: NamedRoutes.forgotPassword,
                            );
                          },
                          buttonWidth: 70,
                          buttonHeight: 35,
                          buttonText: "Edit",
                          buttonTextColor: colorScheme.textPrimary,
                          buttonTextSize: 16.sp,
                          borderColor: ColorPath.athensGrey9,
                          useBorderColor: true,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enable two factor authentication",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.textPrimary,
                                ),
                              ),
                              Text(
                                "This allows you add an extra security to your account",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.scale(
                          scale: .55,
                          child: CupertinoSwitch(
                            value: userVm.twoFA,
                            onChanged: (val) async {
                              await userVm.toggle2FA(value: val);
                              showFlushBar(
                                context: context,
                                message: userVm.message,
                                success: userVm.state == ViewState.retrieved,
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Enable biometrics",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.textPrimary,
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: .55,
                          child: CupertinoSwitch(
                            value: userVm.isBioUser,
                            onChanged: (val) async {
                              await SecureStorageUtils.saveBiometricsPref(
                                value: val,
                              );
                              userVm.isBioUser = val;
                              showFlushBar(
                                context: context,
                                message: "Biometrics updated",
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
              //NOtIFICATION CARD
              IcobaContainer(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notifications",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: ColorPath.athensGrey8),
                    SizedBox(height: 12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Push notifications",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.textPrimary,
                                ),
                              ),
                              Text(
                                "This allows you receive notifications on your device",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.scale(
                          scale: .55,
                          child: CupertinoSwitch(
                            value: userVm.pushNotificationPreference,
                            onChanged: (val) async {
                              await userVm.updateNotificationPreference(
                                pushNotifications: val,
                              );
                              showFlushBar(
                                context: context,
                                message: userVm.message,
                                success: userVm.state == ViewState.retrieved,
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email notifications",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.textPrimary,
                                ),
                              ),
                              Text(
                                "This allows you receive notification in your email",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform.scale(
                          scale: .55,
                          child: CupertinoSwitch(
                            value: userVm.emailNotificationPreference,
                            onChanged: (val) async {
                              await userVm.updateNotificationPreference(
                                emailNotifications: val,
                              );
                              showFlushBar(
                                context: context,
                                message: userVm.message,
                                success: userVm.state == ViewState.retrieved,
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
              IcobaContainer(
                padding: EdgeInsets.all(16.h),
                margin: EdgeInsets.only(top: 16.h),
                bgColor: colorScheme.whiteText,
                child: CustomButton(
                  onPressed: () {
                    baseBottomSheet(context: context, content: LogoutBs());
                  },
                  childWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Logout",
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(Icons.logout, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 75.h),
            ],
          ),
        ),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.textSecondary,
          ),
        ),
        Text(
          data,
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.textPrimary),
        ),
      ],
    );
  }
}
