import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

class IcobaTag extends StatelessWidget {
  final String type;
  final bool showIcon;
  const IcobaTag({super.key, this.type = "founder", this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;
    return IcobaContainer(
      bgColor: _getBaseColor(),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          if (showIcon) Icon(Icons.star, size: 12, color: _getColor()),
          if (showIcon) SizedBox(width: 2.w),
          Text(_getText(), style: textTheme.bodySmall?.copyWith()),
        ],
      ),
    );
  }

  String _getText() {
    switch (type) {
      case "founder":
        return "Founder's circle";
      case "friends":
      case "Friends of Igbobi College":
        return "Friends of Igbobi college";
      case "bronze":
        return "Bronze tier";
      case "silver":
        return "Silver tier";
      case "gold":
        return "Gold tier";
      case "platinum":
        return "Platinum tier";
      case "pending":
        return "Pending";
      case "failed":
        return "Failed";
      case "successful":
        return "Successful";
      default:
        return "Founder's circle";
    }
  }

  Color _getColor() {
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
      case "failed":
        return ColorPath.crimsonRed;
      default:
        return ColorPath.popGreen;
    }
  }

  Color _getBaseColor() {
    switch (type) {
      case "founder":
        return ColorPath.scandalGreen;
      case "friends":
      case "Friends of Igbobi College":
        return ColorPath.lightPurple;
      case "bronze":
        return ColorPath.lightBronze;
      case "silver":
        return ColorPath.lightSilver;
      case "gold":
      case "pending":
        return ColorPath.lightGold;
      case "platinum":
        return ColorPath.lightPlatinum;
      case "failed":
        return ColorPath.cinderellaPink;
      default:
        return ColorPath.scandalGreen;
    }
  }
}

class IcobaTag2 extends StatelessWidget {
  final String donorType;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const IcobaTag2({
    super.key,
    this.donorType = "founder",
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;
    return IcobaContainer(
      // bgColor: _getBaseColor(),
      bgColor: color!.withCustomOpacity(.2),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          // Icon(Icons.star, size: 12, color: _getColor()),
          Icon(Icons.star, size: 12, color: color ?? ColorPath.popGreen),

          SizedBox(width: 2.w),
          // Text(_getText(), style: textTheme.bodySmall),
          Text(
            donorType,
            style: textTheme.bodySmall?.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
