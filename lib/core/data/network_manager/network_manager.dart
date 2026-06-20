import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';
import '../../constants/app_config.dart';
import '../../constants/named_routes.dart';
import '../../utilities/extensions/num_extension.dart';
import '../../utilities/secure_storage/secure_storage_utils.dart';
import '../../utilities/utilities.dart';
import '../enum/request_type.dart';
import '../services/navigation_service.dart';

/////A WORK IN PROGRESS //////////

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  static BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      'Platform': 'mobile',
    },
  );

  late final Dio client;

  factory NetworkManager() {
    return _instance;
  }

  NetworkManager._internal() {
    client = Dio(options);

    client.interceptors.clear();
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool useAuth = options.extra["useAuth"] ?? true;
          // bool useGuestToken = options.extra["useGuestToken"] ?? false;
          if (useAuth) {
            String? token = await SecureStorageUtils.retrieveToken();
            print('token:::$token>>>');
            if (token != null && token.isNotEmpty) {
              options.headers["Authorization"] = "Bearer $token";
            }
          }
          // if (useGuestToken) {
          //   String? guestToken = await SecureStorageUtils.retrieveGuestToken();
          //   print('guest token:::$guestToken>>>');
          //   if (guestToken != null && guestToken.isNotEmpty) {
          //     options.headers["X-Guest-Cart-ID"] = guestToken;
          //   }
          // }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          final response = error.response;
          final requestOptions = error.requestOptions;
          final useAuth = requestOptions.extra["useAuth"] ?? true;

          if (useAuth && response?.statusCode == 401) {
            if (!requestOptions.path.contains('/auth/refresh')) {
              //todo: update route
              try {
                final refreshToken =
                    await SecureStorageUtils.retrieveRefreshToken();
                final refreshResponse = await client.post(
                  '${AppConfig.baseUrl}/auth/refresh',
                  data: {"refresh_token": refreshToken},
                );

                final newAccessToken = refreshResponse.data['access_token'];
                await SecureStorageUtils.saveToken(token: newAccessToken);

                final newRequestOptions = requestOptions
                  ..headers["Authorization"] = "Bearer $newAccessToken";
                final clonedResponse = await client.fetch(newRequestOptions);
                return handler.resolve(clonedResponse);
              } catch (_) {
                if (Utilities.unauthorizedFlag == false) {
                  // sessionExpired();
                }
                return handler.reject(error);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> networkRequestManager(
    RequestType requestType,
    String requestUrl, {
    dynamic body,
    queryParameters,
    bool useAuth = true,
    bool useGuestToken = false,
    File? backFile,
    bool retrieveResponse = false,
    bool retrieveUnauthorizedResponse = false,
  }) async {
    Map<String, dynamic> apiResponse;
    final baseUrl = AppConfig.baseUrl;
    final url = '$baseUrl$requestUrl';

    print("Url: $url, Body: $body, Query: $queryParameters, useAuth: $useAuth");

    try {
      Response response;
      final options = Options(
        extra: {"useAuth": useAuth, "useGuestToken": useGuestToken},
      );

      switch (requestType) {
        case RequestType.get:
          response = await client.get(
            url,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.post:
          response = await client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.multiPartPost:
          response = await client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.put:
          response = await client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.patch:
          response = await client.patch(
            url,
            data: body,
            queryParameters: queryParameters,
            options: options,
          );
          break;
        case RequestType.delete:
          response = await client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: options,
          );
          break;
      }

      apiResponse = response.data;
      log("${requestType.name} response: $apiResponse");
      return apiResponse;
    } on TimeoutException {
      throw ("Network timed out, please check your network connection and try again");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ("Network timed out, please check your network connection and try again");
      }

      if (e.type == DioExceptionType.unknown &&
          e.message?.contains('SocketException') == true) {
        throw ("No internet connection, please check your network connection and try again");
      }

      debugPrint('code: ${e.response?.statusCode}');

      if (e.response != null) {
        final statusCode = e.response!.statusCode!;
        final responseData = e.response!.data;

        if (statusCode == 400) {
          if (retrieveResponse) return responseData;
          throw (responseData['message']);
        } else if (statusCode == 401) {
          // if (Utilities.unauthorizedFlag == false) sessionExpired();
          if (retrieveUnauthorizedResponse) return responseData;
          throw (responseData['message']);
        } else if (statusCode == 403 || statusCode == 404) {
          throw (responseData['message'] ?? "Resource not available");
        } else if (statusCode.isBetween(402, 422)) {
          throw (responseData['message'] ?? "Invalid credentials");
        } else if (statusCode.isBetween(500, 599)) {
          if (statusCode == 502) {
            throw ("We are unable to process request at this time, please try again later");
          }
          throw (responseData['message'] ??
              "Server error, please try again later");
        } else {
          throw ("Unable to process request, ${responseData['message'] ?? 'Unknown error'}");
        }
      } else {
        throw ("An unexpected error occurred");
      }
    } catch (e) {
      throw ("An error occurred while processing this request");
    }
  }

  Future<List<int>> networkBytesRequestManager(
  RequestType requestType,
  String requestUrl, {
  dynamic body,
  Map<String, dynamic>? queryParameters,
  bool useAuth = true,
}) async {
  final baseUrl = AppConfig.baseUrl;
  final url = '$baseUrl$requestUrl';

  try {
    Response response;
    final options = Options(
      responseType: ResponseType.bytes, // 👈 bytes response
      extra: {"useAuth": useAuth},
    );

    switch (requestType) {
      case RequestType.get:
        response = await client.get(url, queryParameters: queryParameters, options: options);
        break;
      case RequestType.post:
        response = await client.post(url, data: body, queryParameters: queryParameters, options: options);
        break;
      default:
        response = await client.get(url, options: options);
    }

    return response.data as List<int>;
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw ("Network timed out, please check your connection and try again");
    }
    throw ("Failed to fetch file: ${e.message}");
  } catch (e) {
    throw ("An error occurred while fetching file");
  }
}
}

// sessionExpired() {
//   Utilities.unauthorizedFlag = true;
//   NavigationService navigationService = locator<NavigationService>();
//   navigationService.pushAndClearRoutes(
//     routeName: NamedRoutes.login,
//     clearRoute: NamedRoutes.onboarding,
//   );
// }
