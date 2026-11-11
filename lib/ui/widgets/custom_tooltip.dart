import 'package:flutter/material.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:widget_tooltip/widget_tooltip.dart';

class CustomTooltip extends StatelessWidget {
  final String tipMessage;
  final WidgetTooltipDirection? direction;
  const CustomTooltip({
    super.key,
    this.tipMessage = "Tooltip message here!",
    this.direction = WidgetTooltipDirection.top,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetTooltip(
      message: Text(tipMessage, style: TextStyle(color: Colors.white)),
      autoDismissDuration: Duration(seconds: 5),
      direction: direction,
      messageDecoration: BoxDecoration(
        color: const Color.fromARGB(255, 33, 32, 32),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 33, 32, 32).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      triangleColor: const Color.fromARGB(255, 33, 32, 32),
      messagePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      triggerMode: WidgetTooltipTriggerMode.tap,
      child: Icon(
        Icons.info_outline,
        size: 18,
        color: ColorPath.cornFLowerBlue,
      ),
    );
  }
}
