
class Regex{
  static final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  static final moniTagAcceptedCharacters = RegExp(r'^[a-zA-Z0-9._]+$'); ///only accepts underscore,dot and dollar sign
  static final digitsOnly = RegExp(r'^[0-9]+$');
  static final nonSpecialCharactersExceptHyphenAndPlus = RegExp(r'[^a-zA-Z0-9+\\-]');
  //static final replaceNonDigitsWithEmptyString = RegExp(r'\D');
  static final replaceNonDigitsWithEmptyString = RegExp(r'[^+\d]');
  static final  nigerianNumberWithPlusSignPattern = RegExp(
      r'^(\+234[789][01]\d{8})');
  static final  nigerianNumberWithoutPlusSignPattern = RegExp(
      r'^(234[78901]\d{8})');
  static final nigerianNumberWithLeadingZeroPattern = RegExp(
      r'^(0[789][01]\d{8})');
  static final noWhiteSpaces = RegExp(r'\s');
  static final replaceAllSpecialCharacters = RegExp(r'[^\w\s]');
  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9\-]+(\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,}$');
}