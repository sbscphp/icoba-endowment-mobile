// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'app_constants.dart';

import '../env/env.dart';

class ApiRoutes {
  //Authentication+Onboarding
  static var registrationDropdowns = "${Env.auth}/registration/options";
  static var signup = "${Env.auth}/signup";
  static var verifyOtp = "${Env.auth}/email/verify-otp";
  static var resendOtp = "${Env.auth}/email/resend-otp";
  static var logout = "${Env.auth}/logout";
  static var login = "${Env.auth}/login";
  static var verifyLoginOtp = "${Env.auth}/login/verify-otp";
  static var resendLoginOtp = "${Env.auth}/login/resend-otp";

  static var forgotPassword = "${Env.auth}/forgot-password";
  static var verifyResetOtp = "${Env.auth}/forgot-password/verify";
  static var resendResetOtp = "${Env.auth}/forgot-password/resend";
  static var resetPassword = "${Env.auth}/reset-password";

  //User Mgt
  static var profile = "${Env.settings}/profile";
  static var toggle2FA = "${Env.settings}/2fa";
  static var updatePassword = "${Env.settings}/password";
  static var notificationPreference = "${Env.settings}/notifications";
  static var inAppNotifications = "${Env.v1}/notifications";
  static var recognitions = "${Env.v1}/me/recognitions";

  //Dashboard
  static var dashboardSummary = "${Env.v1}/me/dashboard/summary";
  static var transactions = "${Env.v1}/me/transactions";
  static var recentDonors = "${Env.v1}/public/leaderboard/recent-donations";
  static var fundsData = "${Env.v1}/public/campaigns/fund-progress";
  static var leaderBoard = "${Env.v1}/public/leaderboard";
  static var leaderBoardSets = "${Env.v1}/public/leaderboard/sets";
  static var campaignDropDowns = "${Env.v1}/public/campaigns/dropdown";
  static String singleCampaign(String campaignId) =>
      "${Env.v1}/public/campaigns/$campaignId";
  static var checkoutStripe = "${Env.v1}/donations/checkout";
  static var initiateBankTransfer = "${Env.v1}/donations/bank-transfer/intent";
  static var verifyCheckout = "${Env.v1}/donations/checkout/verify";
  static var verifyGuestCheckout = "${Env.v1}/donations/stripe/checkout/verify";
  static var availableBankLists = "${Env.v1}/public/bank-accounts";
  static String acknowledgeBankTransfer(String transactionUUID) =>
      "${Env.v1}/donations/bank-transfer/$transactionUUID/confirm-payment";
  static var createPledge = "${Env.v1}/pledges";
  static var getPledges = "${Env.v1}/me/pledges";
  static String downloadReceipt(String receiptNumber) =>
      "${Env.v1}/public/receipts/$receiptNumber/download";
}
