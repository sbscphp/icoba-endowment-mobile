import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_svg.dart';

///bottom nav items
List<BottomNavigationBarItem> bottomNavItems() {
  return [
    BottomNavigationBarItem(
      activeIcon: CustomAssetViewer(
        asset: AppAsset.home,
        colorFilter: ColorFilter.mode(ColorPath.brandColor, BlendMode.srcIn),
        width: .5,
        height: 16.h,
      ),
      icon: CustomAssetViewer(
        asset: AppAsset.home,
        useColorFilter: false,
        width: .5,
        height: 16.h,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      activeIcon: CustomAssetViewer(
        asset: AppAsset.leaderboard,
        width: .5,
        height: 16.h,

        colorFilter: ColorFilter.mode(ColorPath.brandColor, BlendMode.srcIn),
      ),
      icon: CustomAssetViewer(
        asset: AppAsset.leaderboard,
        useColorFilter: false,
        width: .5,
        height: 16.h,
      ),
      label: 'Leaderboard',
    ),
    BottomNavigationBarItem(
      activeIcon: CustomAssetViewer(
        asset: AppAsset.portfolio,
        width: .5,
        height: 16.h,
      ),
      icon: CustomAssetViewer(
        asset: AppAsset.portfolio,
        useColorFilter: false,
        width: .5,
        height: 16.h,
      ),
      label: 'Portfolio',
    ),
    BottomNavigationBarItem(
      activeIcon: CustomAssetViewer(
        asset: AppAsset.profile,
        width: .5,
        height: 16.h,

        colorFilter: ColorFilter.mode(ColorPath.brandColor, BlendMode.srcIn),
      ),
      icon: CustomAssetViewer(
        asset: AppAsset.profile,
        useColorFilter: false,
        width: .5,
        height: 16.h,
      ),
      label: 'Profile',
    ),
  ];
}
