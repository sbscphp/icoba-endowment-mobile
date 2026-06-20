

// import 'package:flutter/services.dart';
//
// class PhoneNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final oldText = oldValue.text;
//     final newRawText = newValue.text.replaceAll(' ', '');
//
//     // If text is empty, reset everything
//     if (newValue.text.isEmpty) {
//       return const TextEditingValue(
//         text: '',
//         selection: TextSelection.collapsed(offset: 0),
//       );
//     }
//
//     final buffer = StringBuffer();
//     int cursorPosition = newValue.selection.baseOffset;
//
//     // Insert spaces at specific positions: after 3, 6, and every 4 digits thereafter
//     for (int i = 0; i < newRawText.length; i++) {
//       buffer.write(newRawText[i]);
//       if (i == 2 || i == 5 || (i > 5 && (i - 6) % 4 == 3)) {
//         buffer.write(' ');
//       }
//     }
//
//     final formattedText = buffer.toString();
//
//     // Adjust cursor position intelligently to avoid sticking
//     int adjustedCursorPosition = cursorPosition;
//
//     // If user is deleting and reaches a space, move cursor back
//     if (oldText.length > formattedText.length &&
//         cursorPosition > 0 &&
//         formattedText[cursorPosition - 1] == ' ') {
//       adjustedCursorPosition--;
//     }
//
//     return TextEditingValue(
//       text: formattedText,
//       selection: TextSelection.collapsed(
//         offset: adjustedCursorPosition.clamp(0, formattedText.length),
//       ),
//     );
//   }
// }

import 'package:flutter/services.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  // @override
  // TextEditingValue formatEditUpdate(
  //     TextEditingValue oldValue, TextEditingValue newValue) {
  //   final oldText = oldValue.text;
  //   final newRawText = newValue.text.replaceAll(' ', ''); // Remove all spaces
  //
  //   final buffer = StringBuffer();
  //   int selectionIndex = newValue.selection.end;
  //
  //   // Reformat text and insert spaces at appropriate positions
  //   int spaceCount = 0;
  //   for (int i = 0; i < newRawText.length; i++) {
  //     buffer.write(newRawText[i]);
  //     if (i == 2 || i == 5 || (i > 5 && (i - 6) % 4 == 3)) {
  //       buffer.write(' ');
  //       if (i < selectionIndex - spaceCount) {
  //         selectionIndex++; // Adjust cursor for each added space
  //       }
  //       spaceCount++;
  //     }
  //   }
  //
  //   final formattedText = buffer.toString();
  //
  //   return TextEditingValue(
  //     text: formattedText,
  //     selection: TextSelection.collapsed(
  //       offset: selectionIndex.clamp(0, formattedText.length),
  //     ),
  //   );
  // }
  // Regex pattern to allow only digits 0-9, space(' ') and plus sign(+)
  static final RegExp _regex = RegExp(r'^\+?[0-9 ]+$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    // Determine if the user is deleting input
    final isDeleting = oldValue.text.length > newValue.text.length;

    // clears the prefix when user clears the first digit after input
    if (isDeleting && newValue.text.isEmpty) {
      return newValue.copyWith(
          text: "",
          selection: const TextSelection.collapsed(offset: "".length));
    }

    //check if new input matches the regex
    if (_regex.hasMatch(newValue.text)) {
      String newText = newValue.text;

      if(newText.length == 3 && !isDeleting){
        //add space to input
        newText = "$newText ";
      }

      if(newText.length == 7 && !isDeleting){
        //add space to input
        newText = "$newText ";
      }

      if(newText.length == 12 && !isDeleting){
        //add space to input
        newText = "$newText ";
      }

      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    } else {
      // Return old value if new value didn't pass the regex check
      return TextEditingValue(
        text: oldValue.text,
        selection: TextSelection.collapsed(offset: oldValue.text.length),
      );
    }

  }
}


