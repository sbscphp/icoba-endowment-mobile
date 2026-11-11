import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recognition_data.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/recognition/view_recognition.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_tag.dart';

class RecognitionItem extends StatelessWidget {
  final RecognitionData recognitionData;
  const RecognitionItem({super.key, required this.recognitionData});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Clickable(
      onPressed: () {
        pushNavigation(
          context: context,
          widget: ViewRecognition(data: recognitionData),
          routeName: NamedRoutes.recognition,
        );
      },
      child: IcobaContainer(
        padding: EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorPath.athensGrey9),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recognitionData.certificateTemplate?.name ?? "",
                    // style: textTheme.bodySmall?.copyWith(
                    //   color: colorScheme.textTertiary,
                    // ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      CustomAssetViewer(
                        asset: AppAsset.calendar,
                        useColorFilter: false,
                        height: 12,
                        width: 12,
                      ),
                      SizedBox(width: 8.w),
                      FittedBox(
                        child: Text(
                          DateUtilities.monthDayYear(
                            date: recognitionData.issuedAt ?? DateTime.now(),
                          ),
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.textTertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Icon(
              Icons.star,
              color: _getColor(recognitionData.tier?.name ?? ""),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String type) {
    switch (type) {
      case "founder":
        return ColorPath.popGreen;
      case "friends":
      case "Friends of Igbobi College":
        return ColorPath.purple;
      case "bronze":
        return ColorPath.bronze;
      case "silver":
        return ColorPath.silver;
      case "gold":
      case "pending":
        return ColorPath.gold;
      case "platinum":
        return ColorPath.platinum;
      default:
        return ColorPath.popGreen;
    }
  }
}
