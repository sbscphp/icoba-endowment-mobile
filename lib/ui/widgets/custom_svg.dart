import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_theme/custom_color_scheme.dart';

class CustomSvg extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  final ColorFilter? colorFilter;
  final BoxFit? fit;
  const CustomSvg({
    super.key,
    this.fit,
    this.colorFilter,
    required this.asset,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      height: height?.h ?? 24.h,
      width: width?.w ?? 24.w,
      fit: fit ?? BoxFit.cover,
      colorFilter: colorFilter,
    );
  }
}

class CustomAssetViewer extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  final ColorFilter? colorFilter;
  final bool useColorFilter;
  final Color? color;
  final BoxFit? fit;
  const CustomAssetViewer({
    super.key,
    required this.asset,
    this.height,
    this.width,
    this.colorFilter,
    this.useColorFilter = true,
    this.color,
    this.fit
  });

  @override
  Widget build(BuildContext context) {
    return isSvg()
        ? CustomSvg(
      asset: asset,
      height: height,
      fit: fit,
      width: width,
      colorFilter: useColorFilter ? ColorFilter.mode(Theme.of(context).colorScheme.iconColor, BlendMode.srcIn) : colorFilter,
    )
        : Image.asset(
      asset,
      height: height?.h ?? 24.h,
      width: width?.w ?? 24.w,
      fit: fit,
      color: useColorFilter ? Theme.of(context).colorScheme.iconColor : color,
    );
  }

  bool isSvg() => asset.endsWith('.svg');
}

