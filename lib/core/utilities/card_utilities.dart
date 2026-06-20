
// class CardUtils {
//   static PaymentCardType getCardTypeFrmNumber(String input) {
//     PaymentCardType cardType;
//     input = getCleanedNumber(input);

//     if (input.startsWith(
//       RegExp(
//         r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))',
//       ),
//     )) {
//       cardType = PaymentCardType.Master;
//     } else if (input.startsWith(RegExp(r'[4]'))) {
//       cardType = PaymentCardType.Visa;
//     } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
//       cardType = PaymentCardType.Verve;
//     } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
//       cardType = PaymentCardType.AmericanExpress;
//     } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
//       cardType = PaymentCardType.Discover;
//     } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
//       cardType = PaymentCardType.DinersClub;
//     } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
//       cardType = PaymentCardType.Jcb;
//     } else if (input.length <= 8) {
//       cardType = PaymentCardType.Others;
//     } else {
//       cardType = PaymentCardType.Invalid;
//     }

//     return cardType;
//   }

//   static String? setCardIcon({required PaymentCardType? cardType}) {
//     String? selectedSvg;

//     if (cardType == null) {
//       return null;
//     }

//     switch (cardType) {
//       case PaymentCardType.Master:
//         selectedSvg = "master_card.svg";
//         break;
//       case PaymentCardType.Visa:
//         selectedSvg = "visa.svg";
//         break;
//       case PaymentCardType.Verve:
//         selectedSvg = "verve.svg";
//         break;
//       case PaymentCardType.Discover:
//         selectedSvg = "discover.svg";
//         break;
//       case PaymentCardType.AmericanExpress:
//         selectedSvg = "american_express.svg";
//         break;
//       case PaymentCardType.DinersClub:
//         selectedSvg = "dinners_club.svg";
//         break;
//       case PaymentCardType.Jcb:
//         selectedSvg = "jcb.svg";
//         break;
//       case PaymentCardType.Invalid:
//         selectedSvg = "invalid_card.svg";
//         break;
//       case PaymentCardType.Others:
//       default:
//         selectedSvg = "others.svg";
//         break;
//     }

//     return selectedSvg;
//   }

//   /// Convert the two-digit year to four-digit year if necessary
//   static int convertYearTo4Digits(int year) {
//     if (year < 100 && year >= 0) {
//       var now = DateTime.now();
//       String currentYear = now.year.toString();
//       String prefix = currentYear.substring(0, currentYear.length - 2);
//       year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
//     }
//     return year;
//   }

//   static bool hasDateExpired(int month, int year) {
//     return !(year == null) && isNotExpired(year, month);
//   }

//   static bool isNotExpired(int year, int month) {
//     // It has not expired if both the year and date has not passed
//     return !hasYearPassed(year) && !hasMonthPassed(year, month);
//   }

//   static List<String> getExpiryDate(String value) {
//     var split = value.split(RegExp(r'(\/)'));
//     return split;
//   }

//   static bool hasMonthPassed(int year, int month) {
//     var now = DateTime.now();
//     // The month has passed if:
//     // 1. The year is in the past. In that case, we just assume that the month
//     // has passed
//     // 2. Card's month (plus another month) is more than current month.
//     return hasYearPassed(year) ||
//         convertYearTo4Digits(year) == now.year &&
//             (month <
//                 now.month +
//                     1); //see current month as expired: (month < now.month + 1);
//   }

//   static bool hasYearPassed(int year) {
//     int fourDigitsYear = convertYearTo4Digits(year);
//     var now = DateTime.now();
//     // The year has passed if the year we are currently is more than card's
//     // year
//     return fourDigitsYear < now.year;
//   }

//   static String getCleanedNumber(String text) {
//     RegExp regExp = RegExp(r"[^0-9]");
//     return text.replaceAll(regExp, '');
//   }
// }
