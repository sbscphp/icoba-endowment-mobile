import 'package:flutter/services.dart';

class NigerianRCNumberFormatter extends TextInputFormatter {
  // Prefix to be added to the user input
  static const String prefix = 'RC ';

  // Regex pattern: allows only digits and spaces after RC
  static final RegExp _regex = RegExp(r'^[0-9 ]*$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Determine if the user is deleting input
    final isDeleting = oldValue.text.length > newValue.text.length;

    // If user deletes everything up to the prefix, clear the field
    if (isDeleting && newValue.text.length <= prefix.length) {
      return newValue.copyWith(
        text: "",
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    // If text already starts with RC, only validate the rest
    if (newValue.text.startsWith(prefix)) {
      final rest = newValue.text.substring(prefix.length);
      if (_regex.hasMatch(rest)) {
        return newValue;
      } else {
        // Reject invalid input
        return oldValue;
      }
    }

    // If text doesn’t start with RC, prepend it
    if (_regex.hasMatch(newValue.text)) {
      final newText = prefix + newValue.text;
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    // Reject invalid input
    return oldValue;
  }
}
