import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../utilities.dart';

class MoneyInputFormatter extends TextInputFormatter {
  final bool useCurrency;
  final String? currencyString;

  MoneyInputFormatter({
    this.useCurrency = true,
    this.currencyString = Utilities.nairaSign,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any characters except digits and decimal point
    String value = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Check if the new value contains a decimal
    bool containsDecimal = value.contains('.');
    String integerPart = value;
    String decimalPart = '';

    if (containsDecimal) {
      List<String> parts = value.split('.');
      integerPart = parts[0]; // Integer part
      decimalPart = parts.length > 1 ? parts[1] : '';

      // Limit decimal part to 2 digits
      if (decimalPart.length > 2) {
        decimalPart = decimalPart.substring(0, 2);
      }
    }

    // Parse the integer part
    int integerValue = int.tryParse(integerPart) ?? 0;

    // Format the integer part with commas
    final formatCurrency = NumberFormat("#,##0", "en_US");
    String newText = formatCurrency.format(integerValue);

    // Append decimal part if present
    if (containsDecimal) {
      newText += '.' + decimalPart;
    }

    // Add currency symbol if required
    if (useCurrency) {
      newText = "$currencyString $newText";
    }

    // Maintain the cursor position relative to user input
    int newOffset =
        newText.length - (newValue.text.length - newValue.selection.end);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
