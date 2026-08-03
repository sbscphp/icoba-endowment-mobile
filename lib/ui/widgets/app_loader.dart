import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class AppLoader extends StatelessWidget {
  final double? size;
  const AppLoader({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSpinningCircle(
        size: size ?? 50, //200
        itemBuilder: (BuildContext context, int index) {

          return Image.asset(
            'assets/images/icoba.png',
            height: size?.h,
            width: size?.w,
          );

          // return const RenderLottie(
          //   lottieAsset: 'assets/json/Gift_congratulation.json',
          //   repeat: false,
          // );
        },
      ),
    );
  }
}
