import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recognition_data.dart';
import 'package:icoba_endowment_mobile/core/utilities/receipt_utils.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_button.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';

GlobalKey recognitionKey = GlobalKey();

class ViewRecognition extends StatelessWidget {
  final RecognitionData data;
  const ViewRecognition({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: "Recognition",
        useChevLeft: true,
      ),
      body: Container(
        color: ColorPath.athensGrey4,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
        child: Column(
          children: [
            RepaintBoundary(
              key: recognitionKey,
              child: Container(
                height: 245.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorPath.gullGrey,
                      offset: Offset(0, 8.59),
                      blurRadius: 17.18,
                      spreadRadius: -4.3,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(data.certificateImageUrl ?? ""),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      ReceiptUtils.saveImageToGallery(
                        key: recognitionKey,
                        context: context,
                      );
                    },
                    childWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Download", style: TextStyle(color: Colors.white)),
                        Icon(Icons.download_outlined, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      ReceiptUtils.shareImage(
                        key: recognitionKey,
                        context: context,
                      );
                    },
                    borderColor: ColorPath.brandColor,
                    useBorderColor: true,

                    childWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Share",
                          style: TextStyle(color: ColorPath.brandColor),
                        ),
                        Icon(Icons.share_outlined, color: ColorPath.brandColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
