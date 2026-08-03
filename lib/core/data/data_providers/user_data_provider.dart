import 'dart:async';
import 'dart:convert';

import 'package:icoba_endowment_mobile/core/data/models/data/pagination_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/default_response.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/notification_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recognition_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/user.dart';

import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/api_response.dart';
import '../models/response_data/notification_preference.dart';
import '../network_manager/network_manager.dart';
import '../services/api_encryption_service.dart';

class UserDataProvider {
  ///get [USER] data ✅
  Future<ApiResponse<User>> getUserProfile() async {
    var completer = Completer<ApiResponse<User>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.profile,
            useAuth: true,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<User>.fromJson(
        parsedData,
        (data) => User.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///toggles [2FA] ✅
  Future<ApiResponse<DefaultResponse>> toggle2FA() async {
    var completer = Completer<ApiResponse<DefaultResponse>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.patch,
            ApiRoutes.toggle2FA,
            useAuth: true,
            // body: jsonEncode(details),
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

  ///changes [User] password  ✅
  Future<ApiResponse<DefaultResponse>> updatePassword({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<DefaultResponse>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.patch,
            ApiRoutes.updatePassword,
            useAuth: true,
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

  /// updates [Notification] preferences ✅
  Future<ApiResponse<NotificationPreference>> updateNotificationPreserence({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<NotificationPreference>>();
    try {
      final encryptedPayload = aesEncrypt(jsonEncode(details));
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.patch,
            ApiRoutes.notificationPreference,
            useAuth: true,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<NotificationPreference>.fromJson(
        parsedData,
        (data) => NotificationPreference.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [USER] notifications ✅
  Future<ApiResponse<PaginationData<NotificationData>>>
  getNotifications() async {
    var completer = Completer<ApiResponse<PaginationData<NotificationData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.inAppNotifications,
            useAuth: true,
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<PaginationData<NotificationData>>.fromJson(
        parsedData,
        (data) => PaginationData<NotificationData>.fromJson(
          data,
          (e) => NotificationData.fromJson(e),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Recognitions] ✅
  Future<ApiResponse<PaginationData<RecognitionData>>> getRecognitions({
    int? page,
    int? perPage,
    String? startDate,
    String? endDate,
    bool? download,
  }) async {
    var completer = Completer<ApiResponse<PaginationData<RecognitionData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.recognitions,
            useAuth: true,
            // body: jsonEncode(details),
            queryParameters: {
              "page": page ?? 1,
              "per_page": perPage ?? 10,
              "start_date": startDate,
              "end_date": endDate,
              "download": download,
            },
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<PaginationData<RecognitionData>>.fromJson(
        parsedData,
        (data) => PaginationData<RecognitionData>.fromJson(
          data,
          (item) => RecognitionData.fromJson(item),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
