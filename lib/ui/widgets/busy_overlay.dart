
import 'package:flutter/material.dart';

import '../../core/utilities/extensions/color_extensions.dart';
import 'app_loader.dart';

class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;
  final double opacity;

  const BusyOverlay({
    super.key,
    required this.child,
    this.title = '',
    this.show = false,
    this.opacity = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    // return Material(
    //     child: Stack(children: <Widget>[
    //       child,
    //       IgnorePointer(
    //         ignoring: !show,
    //         child: Opacity(
    //             opacity: show ? 1.0 : 0.0,
    //             child: Container(
    //               width: double.infinity,
    //               height: double.infinity,
    //               alignment: Alignment.center,
    //               color: ColorPath.chaliceGrey.withOpacity(opacity),
    //               child: Center(
    //                 child: Container(
    //                   height: 327.h,
    //                   width: double.infinity,
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.all(Radius.circular(10.r))
    //                   ),
    //                   child: Lottie.asset(
    //                     'assets/jsons/app_loader.json',
    //                     repeat: true,
    //                     alignment: Alignment.center,
    //                     fit: BoxFit.contain,
    //                   ),
    //                 ),
    //               ),
    //             )),
    //       ),
    //     ]));

    return Material(
      child: Stack(
        children: <Widget>[
          child,
          IgnorePointer(
            ignoring: !show,
            child: Opacity(
              opacity: show ? 1.0 : 0.0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                color: Colors.black.withCustomOpacity(0.6),
                //color: ColorPath.athensGrey3.withOpacity(opacity),
                child: const Center(child: AppLoader(size: 80)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
