import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recognition_data.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/pages/recognition/view_recognition.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_svg.dart';
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recognitionData.certificateTemplate?.name ?? ""),
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
                    Text(
                      DateUtilities.monthDayYear(
                        date: recognitionData.issuedAt ?? DateTime.now(),
                      ),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          IcobaTag(type: recognitionData.tier?.name ?? ""),
        ],
      ),
    );
  }
}
