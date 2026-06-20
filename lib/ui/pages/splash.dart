import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';

import '../../core/constants/app_asset.dart';
import '../../core/utilities/navigator.dart';
import '../widgets/custom_svg.dart';
import 'landing.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleNav();
    });
    super.initState();
  }

  void _handleNav() {
    Timer(Duration(seconds: 2), () async {
      // final userData = await SecureStorageUtils.retrieveUser();

      // if (userData != null) {
      //   replaceNavigation(
      //     context: context,
      //     widget: Login(),
      //     routeName: NamedRoutes.login,
      //   );
      // } else {
      replaceNavigation(
        context: context,
        widget: Landing(),
        routeName: NamedRoutes.landing,
      );
      // }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomAssetViewer(
          asset: AppAsset.icobaEndownmentLogo,
          useColorFilter: false,
          width: 188.w,
          height: 65.h,
        ),
      ),
    );
  }
}
     