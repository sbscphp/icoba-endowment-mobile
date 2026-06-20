import 'package:flutter/material.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

class CustomRadioButton extends StatelessWidget {
  final bool value;
  const CustomRadioButton({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return IcobaContainer(
      height: 20,
      width: 20,
      shape: BoxShape.circle,
      bgColor: Colors.white,
      border: Border.all(
        color: value ? ColorPath.brandColor : ColorPath.mischkaGrey,
      ),
      child: value
          ? Icon(Icons.circle, size: 8, color: ColorPath.brandColor)
          : SizedBox.shrink(),
    );
  }
}
