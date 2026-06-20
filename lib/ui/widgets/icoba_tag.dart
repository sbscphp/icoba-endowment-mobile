import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

class IcobaTag extends StatelessWidget {
  final String type;
  const IcobaTag({super.key, this.type = "founder"});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;
    return IcobaContainer(
      bgColor: _getBaseColor(),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Icon(Icons.star, size: 12, color: _getColor()),
          SizedBox(width: 2.w),
          Text(_getText(), style: textTheme.bodySmall),
        ],
      ),
    );
  }

  String _getText() {
    switch (type) {
      case "founder":
        return "Founder's circle";
      case "friends":
        return "Friends of Igbobi college";
      case "bronze":
        return "Bronze tier";
      case "silver":
        return "Silver tier";
      case "gold":
        return "Gold tier";
      case "platinum":
        return "Platinum tier";
      default:
        return "Founder's circle";
    }
  }

  Color _getColor() {
    switch (type) {
      case "founder":
        return ColorPath.popGreen;
      case "friends":
        return ColorPath.purple;
      case "bronze":
        return ColorPath.bronze;
      case "silver":
        return ColorPath.silver;
      case "gold":
        return ColorPath.gold;
      case "platinum":
        return ColorPath.platinum;
      default:
        return ColorPath.popGreen;
    }
  }

  Color _getBaseColor() {
    switch (type) {
      case "founder":
        return ColorPath.scandalGreen;
      case "friends":
        return ColorPath.lightPurple;
      case "bronze":
        return ColorPath.lightBronze;
      case "silver":
        return ColorPath.lightSilver;
      case "gold":
        return ColorPath.lightGold;
      case "platinum":
        return ColorPath.lightPlatinum;
      default:
        return ColorPath.scandalGreen;
    }
  }
}
