import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_theme/custom_color_scheme.dart';
import '../../core/constants/color_path.dart';
import 'leading_icon.dart';

AppBar customAppBar({
  required BuildContext context,
  String? title,
  FontWeight? titleFontWeight,
  double titleSize = 14,
  List<Widget>? actions,
  bool centerTitle = true,
  VoidCallback? leadingIconOnPressed,
  double? appBarElevation,
  final Color? textColor,
  bool useCustomTitleWidget = false,
  Widget? titleWidget,
  bool showLeadingIcon = true,
  double? leadingWidth,
  Widget? leading,
  double? appbarBottomPadding,
  Color? bgColor,
  bool showBottom = false,
  bool useChevLeft = false,
}) {
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;
  return AppBar(
    backgroundColor: bgColor ?? Colors.transparent,
    leadingWidth: leadingWidth ?? MediaQuery.of(context).size.width / 4.5,
    scrolledUnderElevation: 0,
    centerTitle: centerTitle,
    title: useCustomTitleWidget
        ? titleWidget
        : title != null
        ? Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: titleSize.sp,
              fontWeight: titleFontWeight ?? FontWeight.w700,
              color: textColor ?? colorScheme.textPrimary,
            ),
          )
        : null,
    leading:
        leading ??
        LeadingIcon(
          onPressed: leadingIconOnPressed,
          show: showLeadingIcon,
          useChevLeft: useChevLeft,
        ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(appbarBottomPadding?.h ?? 10.h),
      child: Container(
        color: showBottom ? ColorPath.athensGrey : Colors.transparent,
        height: 1.h,
      ),
    ),
    actions: actions,
    systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark,
  );
}
