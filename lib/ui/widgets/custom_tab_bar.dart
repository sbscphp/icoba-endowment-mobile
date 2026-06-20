import 'package:flutter/material.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';
import 'custom_painter/custom_tab_indicator.dart';

class CustomTabBar extends TabBar {
  CustomTabBar({
    super.key,
    required TabController controller,
    required List<String> tabTitles,
    required BuildContext context,
  }) : super(
         controller: controller,
         isScrollable: false,
         labelPadding: EdgeInsets.zero,
         indicatorSize: TabBarIndicatorSize.tab,
         labelColor: Theme.of(context).colorScheme.textPrimary,
         indicatorColor: Theme.of(context).colorScheme.textPrimary,
         dividerColor: Colors.transparent,
         unselectedLabelColor: ColorPath.gullGrey,
         unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
           fontWeight: FontWeight.w500,
           color: ColorPath.crimsonRed,
         ),
         splashFactory: NoSplash.splashFactory,
         overlayColor: WidgetStateProperty.all(Colors.transparent),
         indicator: CustomTabIndicator(
           bgColor: Colors.white,
           borderColor: ColorPath.brandColor,
         ),
         labelStyle: Theme.of(
           context,
         ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
         tabs: tabTitles
             .map((title) => Tab(child: FittedBox(child: Text(title))))
             .toList(),
       );
}
