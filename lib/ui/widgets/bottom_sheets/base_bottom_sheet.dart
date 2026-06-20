import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utilities/extensions/color_extensions.dart';

baseBottomSheet({
  required BuildContext context,
  required Widget content,
  bool isScrollControlled = true,
  bool enableDrag = true,
  bool isDismissible = true,
  double maxHeight = 761,
  VoidCallback? onCompleted,
}) {
  showModalBottomSheet(
    isScrollControlled: isScrollControlled,
    enableDrag: enableDrag,
    isDismissible: isDismissible,
    context: context,
    barrierColor: Colors.black.withCustomOpacity(0.32),
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder: (BuildContext context) {
      // 👇 Captures keyboard height and reacts to changes
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

      return Stack(
        children: [
          // Tappable area to dismiss
          if (isDismissible)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            )
          else
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          // Bottom sheet content
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              // 👇 Pushes sheet up by exact keyboard height
              padding: EdgeInsets.only(bottom: keyboardHeight),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: SafeArea(
                  // 👇 Disable bottom safe area since we handle it manually
                  // bottom: false,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxHeight.h),
                    child: content,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  ).then((_) {
    if (onCompleted != null) {
      onCompleted();
    }
  });
}

// baseBottomSheet({
//   required BuildContext context,
//   required Widget content,
//   bool isScrollControlled = true,
//   bool enableDrag = true,
//   bool isDismissible = true,
// }) {
//   showModalBottomSheet(
//       isScrollControlled: isScrollControlled,
//       enableDrag: enableDrag,
//       isDismissible: isDismissible,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
//       ),
//       context: context,
//       builder: (BuildContext context) {
//         return Theme(
//           data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
//           child: SizedBox(
//             width: double.infinity,
//             child: SafeArea(
//               child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: 700.h,
//                   ),
//                   child: content),
//             ),
//           ),
//         );
//       }).whenComplete(() {});
// }

// Future<void> baseBottomSheet({
//   required BuildContext context,
//   required Widget content,
//   bool isDismissible = true,
// }) async {
//   await showGeneralDialog(
//     context: context,
//     barrierDismissible: isDismissible,
//     barrierLabel: "BottomSheet",
//     barrierColor: Colors.black.withOpacity(0.2),
//     transitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return const SizedBox.shrink();
//     },
//     transitionBuilder: (context, animation, secondaryAnimation, child) {
//       final curvedAnimation = CurvedAnimation(
//         parent: animation,
//         curve: Curves.easeOut,
//       );
//
//       return GestureDetector(
//         onTap: isDismissible ? () => popNavigation(context: context) : null,
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Stack(
//             children: [
//               // Blurred background
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.32),
//                 ),
//               ),
//
//               // Animated bottom sheet
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(0, 1),
//                     end: Offset.zero,
//                   ).animate(curvedAnimation),
//                   child: GestureDetector(
//                     onTap: () {}, // prevent tap-through
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).canvasColor,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30.r),
//                           topRight: Radius.circular(30.r),
//                         ),
//                       ),
//                       child: SafeArea(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                             bottom: MediaQuery.of(context).viewInsets.bottom,
//                           ),
//                           child: ConstrainedBox(
//                             constraints: BoxConstraints(maxHeight: 700.h),
//                             child: content,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }