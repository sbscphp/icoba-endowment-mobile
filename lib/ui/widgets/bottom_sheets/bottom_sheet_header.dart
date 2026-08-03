
import 'package:flutter/material.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../../../core/utilities/navigator.dart';
import '../clickable.dart';
import '../custom_svg.dart';

class BottomSheetHeader extends StatelessWidget {
  final String headerTitle;
  const BottomSheetHeader({super.key, required this.headerTitle});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerTitle,
          style: textTheme.titleMedium?.copyWith(color: colorScheme.textPrimary),
        ),
        Clickable(
          onPressed: () {
            popNavigation(context: context);
          },
          child: CustomAssetViewer(
            asset: AppAsset.close,
            useColorFilter: false,
          ),
        ),
      ],
    );
  }
}
