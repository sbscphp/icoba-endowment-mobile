// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'app_constants.dart';


const String _v1 = '/api/v1';
const String _auth = '$_v1/auth';
const String _settings = '$_v1/settings';

class ApiRoutes {
  //Authentication+Onboarding
  static var registrationDropdowns = "$_auth/registration/options";
  static var signup = "$_auth/signup";
  static var verifyOtp = "$_auth/email/verify-otp";
  static var resendOtp = "$_auth/email/resend-otp";
  static var logout = "$_auth/logout";
  static var login = "$_auth/login";
  static var verifyLoginOtp = "$_auth/login/verify-otp";
  static var resendLoginOtp = "$_auth/login/resend-otp";

  static var forgotPassword = "$_auth/forgot-password";
  static var verifyResetOtp = "$_auth/forgot-password/verify";
  static var resendResetOtp = "$_auth/forgot-password/resend";
  static var resetPassword = "$_auth/reset-password";

  //User Mgt
  static var profile = "$_settings/profile";
  static var deleteAccount = "$_settings/profile/delete";
  static var toggle2FA = "$_settings/2fa";
  static var updatePassword = "$_settings/password";
  static var notificationPreference = "$_settings/notifications";
  static var inAppNotifications = "$_v1/notifications";
  static var recognitions = "$_v1/me/recognitions";

  //Dashboard
  static var dashboardSummary = "$_v1/me/dashboard/summary";
  static var transactions = "$_v1/me/transactions";
  static var events = "$_v1/public/events";
  static String viewEvent(String eventId) => "$_v1/public/events/$eventId";
  static var recentDonors = "$_v1/public/leaderboard/recent-donations";
  static var fundsData = "$_v1/public/campaigns/fund-progress";
  static var leaderBoard = "$_v1/public/leaderboard";
  static var leaderBoardSets = "$_v1/public/leaderboard/sets";
  static var leaderBoardHouses = "$_v1/public/leaderboard/houses";
  static var campaignDropDowns = "$_v1/public/campaigns/dropdown";
  static String singleCampaign(String campaignId) =>
      "$_v1/public/campaigns/$campaignId";
  static var checkoutStripe = "$_v1/donations/checkout";
  static var initiateBankTransfer = "$_v1/donations/bank-transfer/intent";
  static var verifyCheckout = "$_v1/donations/checkout/verify";
  static var verifyGuestCheckout = "$_v1/donations/stripe/checkout/verify";
  static var availableBankLists = "$_v1/public/bank-accounts";
  static String acknowledgeBankTransfer(String transactionUUID) =>
      "$_v1/donations/bank-transfer/$transactionUUID/confirm-payment";
  static var createPledge = "$_v1/pledges";
  static var getPledges = "$_v1/me/pledges";
  static String downloadReceipt(String receiptNumber) =>
      "$_v1/public/receipts/$receiptNumber/download";
  static String donationQuote({
    required String amount,
    required String currency,
  }) => "$_v1/donations/fee-quote?amount=$amount&currency=$currency";
}
