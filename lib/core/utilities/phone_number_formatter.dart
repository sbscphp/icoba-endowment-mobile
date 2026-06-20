
import 'regex.dart';

class PhoneNumberFormatter {
  ///removes '+' and replace with ''
  static String formatCountryCode(String code) {
    return code.replaceAll("+", '');
  }

  ///removes zero(0) from phone number
  static String formatNumber(String number) {
    String formattedNumber = "";

    if (number.length > 1) {
      if (number.startsWith("0")) {
        formattedNumber = number.substring(1, number.length);
      } else {
        formattedNumber = number;
      }
    }
    return formattedNumber;
  }

  ///removes special characters from phone number and replace with dash
  static String removeSpecialCharactersAndReplaceDash(String input) {
    /// Replace all matches with an empty string
    String withoutSpecialChars = input.replaceAll(
      Regex.nonSpecialCharactersExceptHyphenAndPlus,
      '',
    );

    /// Replace '-' with ' '
    String result = withoutSpecialChars.replaceAll('-', ' ');

    return result;
  }

  ///checks for a valid nigerian phone number
  static bool isValidNigerianPhoneNumber({required String phoneNumber}) {
    ///trim incoming phone number
    final formattedNumber = phoneNumber.trim();

    /// Check for a match using any of the patterns
    bool isPlusSignMatch =
        Regex.nigerianNumberWithPlusSignPattern.hasMatch(formattedNumber) &&
        formattedNumber.length == 14;

    bool isWithoutPlusSignMatch =
        Regex.nigerianNumberWithoutPlusSignPattern.hasMatch(formattedNumber) &&
        formattedNumber.length == 13;

    bool isLeadingZeroMatch =
        Regex.nigerianNumberWithLeadingZeroPattern.hasMatch(formattedNumber) &&
        formattedNumber.length == 11;

    return isPlusSignMatch || isWithoutPlusSignMatch || isLeadingZeroMatch;
  }

  ///removes country code(+234/234) and replace with zero(0)
  static String removeCountryCode({required String phoneNumber}) {
    if (phoneNumber.startsWith('+234')) {
      /// Replace '+234' with '0'
      return '0${phoneNumber.substring(4)}';
    } else if (phoneNumber.startsWith('234')) {
      /// Replace '234' with '0'
      return '0${phoneNumber.substring(3)}';
    } else {
      return phoneNumber;
    }
  }
}
