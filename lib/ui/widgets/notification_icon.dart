import 'package:flutter/material.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/notification/notification.dart';

import '../../core/constants/app_asset.dart';
import 'clickable.dart';
import 'custom_svg.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: () {
        pushNavigation(
          context: context,
          widget: NotificationScreen(),
          routeName: NamedRoutes.notificationScreen,
        );
      },
      child: CustomAssetViewer(asset: AppAsset.notification),
    );
  }
}
