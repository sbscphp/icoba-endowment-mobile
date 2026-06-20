import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_theme/custom_color_scheme.dart';
import '../custom_svg.dart';

class PasswordRequirement extends StatefulWidget {
  final List<bool> results;
  const PasswordRequirement({super.key, required this.results});

  @override
  State<PasswordRequirement> createState() => _PasswordRequirementState();
}

class _PasswordRequirementState extends State<PasswordRequirement> {
  final List<String> pwdRequirements = [
    "Minimum 8 of character long",
    "One uppercase letter",
    "One lowercase letter",
    "One number 0-9",
    "One special charater (!@#\$%^&*+-?)",
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.separated(
      itemCount: pwdRequirements.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        final requirement = pwdRequirements[index];
        final isPassed = widget.results[index];
        return Row(
          children: [
            CustomAssetViewer(
              asset: isPassed ? AppAsset.check : AppAsset.checkGrey,
              height: 18.h,
              width: 18.w,
              useColorFilter: false,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                requirement,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: colorScheme.textTertiary,
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 12.h);
      },
    );
  }
}
