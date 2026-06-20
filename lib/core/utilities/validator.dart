import '../constants/app_constants.dart';
import 'utilities.dart';

class EmailValidator {
  static String? validateEmail(String? value, {bool isCompulsory = true}) {
    if (value != null) {
      if (value.isEmpty && !isCompulsory) {
        return null;
      }
      if (value.isEmpty) {
        return emptyEmailField;
      }
      // Regex for email validation
      final regExp = RegExp(emailRegex);
      if (regExp.hasMatch(value)) {
        return null;
      }

      return invalidEmailField;
    } else {
      return null;
    }
  }
}

class PhoneNumberValidator {
  static String? validatePhoneNumber(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }
      // Regex for phone number validation
      final regExp = RegExp(phoneNumberRegex);
      //print(regExp.hasMatch(value));
      if (regExp.hasMatch(value)) {
        return null;
      }
      return invalidPhoneNumberField;
    } else {
      return null;
    }
  }
}

class PasswordValidator {
  static String? confirmPassword(String? value, {required String source}) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyPasswordField;
      }

      if (value.trim() != source.trim()) {
        return passwordMatchError;
      }
    } else {
      return null;
    }
    return null;
  }
}

class UsernameValidator {
  static String? validateUsername(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyUsernameField;
      }

      if (value.length < 6) {
        return usernameLengthError;
      }
    } else {
      return null;
    }

    return null;
  }
}

class FieldValidator {
  static String? validate(String? value) {
    if (value != null) {
      if (value.isEmpty || value.trim().isEmpty) {
        return emptyTextField;
      }
    } else {
      return null;
    }

    return null;
  }

  static String? validatePercentage(String? value) {
  if (value == null || value.isEmpty || value.trim().isEmpty) {
    return emptyTextField;
  }

  final number = num.tryParse(value.trim());

  if (number == null) {
    return "Please enter a valid number";
  }

  if (number < 0 || number > 100) {
    return "Value must be between 0 and 100";
  }

  return null;
}

  static String? validateRSA(String? value) {
    if (value != null) {
      if (value.isEmpty || value.trim().isEmpty) {
        return emptyTextField;
      }
      if (!RegExp(r'^PEN\d{12}$').hasMatch(value)) {
        return 'RSA PIN must start with PEN followed by exactly 12 digits';
      }
    } else {
      return null;
    }

    return null;
  }

  static String? compareAndConfirm(
    String? value, {
    required String source,
    required String errorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return emptyTextField;
    }

    if (value.trim() != source.trim()) {
      return errorMessage;
    }

    return null;
  }

  static String? validateLength(
    String? value, {
    required int requiredLength,
    required String errorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return emptyTextField;
    }

    if (value.length != requiredLength) {
      return errorMessage;
    }

    return null;
  }
}

class PasscodeFieldValidator {
  static String? validate(String? value) {
    if (value != null) {
      if (value.isEmpty || value.trim().isEmpty) {
        return emptyTextField;
      }
      if (value.length != 6) {
        return incorrectPasscodeLength;
      }
    } else {
      return null;
    }

    return null;
  }
}

class AmountValidator {
  static String? validateAmount(String? value, {required double maxAmount}) {
    if (value != null) {
      if (value.isEmpty) {
        return emptyTextField;
      }

      final amount = Utilities.formatToDouble(value: value);

      if (amount == null || amount == 0) {
        return 'Please enter a valid amount';
      }

      if (amount > maxAmount) {
        return "Amount can't exceed ₦${Utilities.formatAmount(amount: maxAmount)}";
      }

      return null;
    } else {
      return null;
    }
  }
}
