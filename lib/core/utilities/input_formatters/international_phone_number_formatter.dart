import 'package:flutter/services.dart';



class InternationalPhoneNumberFormatter extends TextInputFormatter {


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