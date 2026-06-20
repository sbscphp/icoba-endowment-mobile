import 'package:flutter/material.dart';

const String defaultErrorMessage = "An Error Occurred. please try again";
const String defaultSuccessMessage = "Request was successful";
const String defaultName = "CSPE User";
const String emptyEmailField = 'Email field cannot be empty!';
const String emptyTextField = 'Field cannot be empty!';
const String incorrectPasscodeLength = 'Passcode must be 6-digits';
const String emptyPasswordField = 'Password field cannot be empty';
const String invalidEmailField =
    "Invalid email";
const String passwordLengthError = 'Password length must be greater than 6';
const String passwordMatchError = "Your password don't match";
const String emptyUsernameField = 'Username  cannot be empty';
const String usernameLengthError = 'Username length must be greater than 6';
const String emailRegex = '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
    '\\@' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
    '(' +
    '\\.' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
    ')+';

const String phoneNumberRegex = r'0[789][01]\d{8}';
const String phoneNumberLengthError = 'Phone number must be 11 digits';
const String invalidPhoneNumberField =
    "Invalid Phone Number";
const String terms = "https://winit-app.netlify.app/policy";
const String claimPrize = "https://winit-app.netlify.app/prize-claim";

const String gli = "https://access.gaminglabs.com/Certificate/Index?i=601";
const String lslga = "https://lslga.org/";
const String fccpc = "http://www.fccpc.gov.ng/";

//social media pages
const String x = 'https://x.com/WinITng';
const String instagram = 'https://www.instagram.com/winitngn1/';
const String facebook = 'https://www.facebook.com/profile.php?id=61572241784521';
const String youtube = 'https://www.youtube.com/@WinIT-v8q';

const String defaultUrl = 'https://www.google.com';
const String faqURL = 'https://cardinalstonepensions.com/help/faqs/';
const String privacyPolicyURL = 'https://cardinalstonepensions.com/help/privacy-policy/';
const String termsUrl = 'https://cardinalstonepensions.com/help/terms-conditions/';


const String samplePics = 'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg';

const double phoneWidth = 500;
///design height, draft(responsiveness)
const double draftHeight = 852;

///design width, draft(responsiveness)
const double draftWidth = 393;

///pagination limit
const int paginationLimit = 20;


///aspect ratio
double aspectRatio(BuildContext context) {
  final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = MediaQuery.of(context).size.width / 2;

  double aspectRatio = (itemWidth / itemHeight);

  return aspectRatio;
}
