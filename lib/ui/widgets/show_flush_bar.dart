import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart'
    show Clickable;

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import '../../core/utilities/navigator.dart';
import 'custom_svg.dart';

showFlushBar({
  required BuildContext context,
  String? fontFamily,
  Color bgColor = Colors.red,
  required String message,
  Color messageColor = Colors.white,
  FlushbarPosition position = FlushbarPosition.TOP,
  int duration = 3,
  bool isPersistent = false,
  bool success = true,
}) {
  Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    backgroundColor: success
        ? ColorPath.scandalGreen
        : ColorPath.cinderellaPink,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    flushbarPosition: position,
    borderRadius: BorderRadius.all(Radius.circular(8.r)),
    borderColor: success ? Colors.green : Colors.red,
    blockBackgroundInteraction: false,
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAssetViewer(
                asset: success ? AppAsset.successCheck : AppAsset.error,
                height: 24.h,
                width: 24.w,
                useColorFilter: false,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    //Theme.of(context).colorScheme.textPrimary
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Clickable(
                onPressed: () {
                  popNavigation(context: context);
                },
                child: Icon(
                  Icons.close,
                  color: ColorPath.fiordGrey,
                  size: 16.w,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    duration: isPersistent ? null : Duration(seconds: duration),
  ).show(context);
}
