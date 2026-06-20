
import 'package:flutter/services.dart';

class RsaPinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.toUpperCase();

    // Allow empty input
    if (text.isEmpty) return newValue.copyWith(text: '');

    // Max length: "PEN" + 12 digits = 15 characters
    if (text.length > 15) return oldValue;

    // Allow typing "PEN" prefix character by character
    const prefix = 'PEN';
    if (text.length <= prefix.length) {
      if (prefix.startsWith(text)) {
        return newValue.copyWith(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
      return oldValue;
    }

    // After "PEN", only allow digits
    final afterPrefix = text.substring(prefix.length);
    if (!RegExp(r'^\d+$').hasMatch(afterPrefix)) return oldValue;

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}