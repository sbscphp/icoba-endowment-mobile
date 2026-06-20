import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';

import '../../core/constants/app_asset.dart';
import 'clickable.dart';
import 'custom_svg.dart';

class LeadingIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool addPadding;
  final bool show;
  final bool useChevLeft;
  const LeadingIcon({
    super.key,
    this.onPressed,
    this.addPadding = true,
    this.show = false,
    this.useChevLeft = false
  });

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    if (canPop || show) {
      return Clickable(
        onPressed:
            onPressed ??
            () {
              Navigator.pop(context);
            },
        child: Padding(
          padding: EdgeInsets.only(left: addPadding ? 22.h : 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(6.h),
              height: 38.w,
              width: 38.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPath.athensGrey5,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withCustomOpacity(0.051),
                //     blurRadius: 2.4,
                //     offset: const Offset(0, 0.8),
                //   ),
                //   BoxShadow(
                //     color: Colors.black.withCustomOpacity(0.102),
                //     blurRadius: 1.6,
                //     offset: const Offset(0, 0.8),
                //   ),
                // ],
              ),
              child: CustomSvg(asset: useChevLeft ? AppAsset.leadingIconChevLeft : AppAsset.leadingIcon),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
