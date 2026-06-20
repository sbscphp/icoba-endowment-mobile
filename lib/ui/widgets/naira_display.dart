import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/utilities/currency_utils.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';

class NairaDisplay extends StatelessWidget {
  final double amount;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool addDecimal;
  final bool showPrefixSign;
  final bool add;
  final TextAlign? textAlign;
  final bool useDollar;
  final bool isRoundUpAmount;
  final String? currencyCode;
  const NairaDisplay({
    super.key,
    required this.amount,
    this.color,
    this.fontSize,
    this.addDecimal = true,
    this.showPrefixSign = false,
    this.add = false,
    this.fontWeight,
    this.textAlign,
    this.useDollar = false,
    this.isRoundUpAmount = false,
    this.currencyCode
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPrefixSign)
          Text(
            add ? '+' : '-',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color ?? Theme.of(context).colorScheme.textPrimary,
              fontSize: fontSize?.sp ?? 24.sp,
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
          ),
        Flexible(
          child: RichText(
            textAlign: textAlign ?? TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color ?? Theme.of(context).colorScheme.textPrimary,
                fontSize: fontSize?.sp ?? 24.sp,
                fontWeight: fontWeight ?? FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: CurrencyUtils.getCurrencySymbol(currencyCode: currencyCode),
                  style: TextStyle(
                    //fontFamily: Platform.isIOS ? "DMSans" : null,
                    fontFamily: null,
                  ),
                ),
                TextSpan(
                  text: isRoundUpAmount
                      ? Utilities.abbreviateAmount(value: amount)
                      : Utilities.formatAmount(
                          amount: amount,
                          addDecimal: addDecimal,
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

TextSpan textspanNairaDisplay({
  double amount = 0.0,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return TextSpan(
    text: '${Utilities.nairaSign}${Utilities.formatAmount(amount: amount)}',

    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontFamily: Platform.isAndroid ? '' : 'BR Cobane',
    ),
  );
}
