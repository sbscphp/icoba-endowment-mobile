import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:icoba_endowment_mobile/core/data/enum/request_type.dart';
import 'package:icoba_endowment_mobile/core/data/models/default_response.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/challenge_token_model.dart';
import 'package:icoba_endowment_mobile/core/data/network_manager/network_manager.dart';
import 'package:icoba_endowment_mobile/core/data/services/api_encryption_service.dart';

import '../../constants/api_routes.dart';
import '../models/api_response.dart';
import '../models/response_data/login_response.dart';
import '../models/response_data/onboarding_dropdown_data.dart';

class AuthDataProvider {
  ///onboarding data ✅
  Future<ApiResponse<OnboardingDropdownData>> getOnboardingData() async {
    var completer = Completer<ApiResponse<OnboardingDropdownData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.registrationDropdowns,
            useAuth: false,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<OnboardingDropdownData>.fromJson(
        parsedData,
        (data) => OnboardingDropdownData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///signup user ✅
  Future<ApiResponse<ChallengeTokenModel>> signup({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ChallengeTokenModel>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.signup,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<ChallengeTokenModel>.fromJson(
        parsedData,
        (data) => ChallengeTokenModel.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///verify otp ✅
  Future<ApiResponse<LoginResponse>> verifyOtp({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<LoginResponse>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.verifyOtp,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<LoginResponse>.fromJson(
        parsedData,
        (data) => LoginResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///resend otp ✅
  Future<ApiResponse<ChallengeTokenModel>> resendOtp({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ChallengeTokenModel>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.resendOtp,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<ChallengeTokenModel>.fromJson(
        parsedData,
        (data) => ChallengeTokenModel.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///logout
  Future<ApiResponse<DefaultResponse>> logOut() async {
    var completer = Completer<ApiResponse<DefaultResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.logout,
            useAuth: false,
            // body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<DefaultResponse>.fromJson(
        parsedData,
        (data) => DefaultResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///login ✅
  Future<ApiResponse<LoginResponse>> login({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<LoginResponse>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.login,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);
      log("DECODED_JSON_DATA_TYPE::4:: ${parsedData}");

      var result = ApiResponse<LoginResponse>.fromJson(
        parsedData,
        (data) => LoginResponse.fromJson(data),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///verify login otp✅
  Future<ApiResponse<LoginResponse>> verifyLoginOtp({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<LoginResponse>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.verifyLoginOtp,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<LoginResponse>.fromJson(
        parsedData,
        (data) => LoginResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///resend login otp✅
  Future<ApiResponse<ChallengeTokenModel>> resendLoginOtp({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ChallengeTokenModel>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.resendLoginOtp,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<ChallengeTokenModel>.fromJson(
        parsedData,
        (data) => ChallengeTokenModel.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///forgot password ✅
  Future<ApiResponse<ChallengeTokenModel>> forgotPassword({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ChallengeTokenModel>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.forgotPassword,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<ChallengeTokenModel>.fromJson(
        parsedData,
        (data) => ChallengeTokenModel.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //verify reset password otp ✅
  Future<ApiResponse<ChallengeTokenModel>> verifyResetOtp({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ChallengeTokenModel>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.verifyResetOtp,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<ChallengeTokenModel>.fromJson(
        parsedData,
        (data) => ChallengeTokenModel.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///resend reset password otp ✅
  Future<ApiResponse<ChallengeTokenModel>> resendResetOtp({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<ChallengeTokenModel>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.resendResetOtp,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<ChallengeTokenModel>.fromJson(
        parsedData,
        (data) => ChallengeTokenModel.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///reset password ✅
  Future<ApiResponse<DefaultResponse>> resetPassword({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<DefaultResponse>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.resetPassword,
            useAuth: false,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<DefaultResponse>.fromJson(
        parsedData,
        (data) => DefaultResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
