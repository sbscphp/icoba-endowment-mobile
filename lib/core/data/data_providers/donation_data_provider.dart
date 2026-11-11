import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:icoba_endowment_mobile/core/data/models/data/pagination_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/bank_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/checkout_response.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/checkout_validation_response.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/pledge_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/quote_data.dart';

import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/api_response.dart';
import '../models/response_data/campaign_data.dart';
import '../models/response_data/create_pledge_response.dart';
import '../models/response_data/initiate_transfer_response.dart';
import '../network_manager/network_manager.dart';
import '../services/api_encryption_service.dart';

class DonationDataProvider {
  ///get [Campaign Dropdown]
  Future<ApiResponse<List<CampaignData>>> getCampaignDropdown() async {
    var completer = Completer<ApiResponse<List<CampaignData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.campaignDropDowns,
            useAuth: false,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<List<CampaignData>>.fromJson(
        parsedData,
        (data) => List.from(data).map((e) => CampaignData.fromJson(e)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Single Campaign]
  Future<ApiResponse<CampaignData>> getSingleCampaign({
    required String campaignId,
  }) async {
    var completer = Completer<ApiResponse<CampaignData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.singleCampaign(campaignId),
            useAuth: false,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<CampaignData>.fromJson(
        parsedData,
        (data) => CampaignData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///post [Checkout Stripe]
  Future<ApiResponse<CheckoutResponse>> checkoutStripe({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<CheckoutResponse>>();
    final encryptedPayload = aesEncrypt(jsonEncode(details));
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.checkoutStripe,
            useAuth: true,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<CheckoutResponse>.fromJson(
        parsedData,
        (data) => CheckoutResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///post [manual verify donation]
  Future<ApiResponse<CheckoutValidationResponse>> manualVerifyDonation({
    required Map<String, dynamic> details,
    bool useAuth = true,
  }) async {
    var completer = Completer<ApiResponse<CheckoutValidationResponse>>();
    final encryptedPayload = aesEncrypt(jsonEncode(details));
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.verifyCheckout,
            useAuth: useAuth,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<CheckoutValidationResponse>.fromJson(
        parsedData,
        (data) =>
            CheckoutValidationResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Available Banks]
  Future<ApiResponse<BankAccountData>> getAvailableBanks() async {
    var completer = Completer<ApiResponse<BankAccountData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.availableBankLists,
            useAuth: false,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<BankAccountData>.fromJson(
        parsedData,
        (data) => BankAccountData.fromJson(data),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///post [Initiate Bank Transfer]
  Future<ApiResponse<InitiateTransferResponse>> initiateBankTransfer({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<InitiateTransferResponse>>();
    final encryptedPayload = aesEncrypt(jsonEncode(details));
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.initiateBankTransfer,
            useAuth: true,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<InitiateTransferResponse>.fromJson(
        parsedData,
        (data) =>
            InitiateTransferResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///post [Acknowledge Bank Transfer]
  Future<ApiResponse<InitiateTransferResponse>> acknowledgeBankTransfer({
    required String transactionUUID,
  }) async {
    var completer = Completer<ApiResponse<InitiateTransferResponse>>();
    // final encryptedPayload = aesEncrypt(jsonEncode(details));
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.acknowledgeBankTransfer(transactionUUID),
            useAuth: true,
            // body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<InitiateTransferResponse>.fromJson(
        parsedData,
        (data) =>
            InitiateTransferResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //PLEDGES

  ///post [Create Pledge]
  Future<ApiResponse<CreatePledgeResponse>> createPledge({
    required Map<String, dynamic> details,
  }) async {
    var completer = Completer<ApiResponse<CreatePledgeResponse>>();
    final encryptedPayload = aesEncrypt(jsonEncode(details));
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.post,
            ApiRoutes.createPledge,
            useAuth: true,
            body: jsonEncode({'payload': encryptedPayload}),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<CreatePledgeResponse>.fromJson(
        parsedData,
        (data) => CreatePledgeResponse.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Pledges]
  Future<ApiResponse<PaginationData<PledgeData>>> getPledges({
    String? search,
    String? startDate,
    String? endDate,
    int? page,
    String? sortDirection,
    String? sortBy,
    String? filterScope,
  }) async {
    var completer = Completer<ApiResponse<PaginationData<PledgeData>>>();
    // final encryptedPayload = aesEncrypt(jsonEncode(details));
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.getPledges,
            useAuth: true,
            // body: jsonEncode({'payload': encryptedPayload}),
            queryParameters: {
              "search": search,
              "start_date": startDate,
              "end_date": endDate,
              "page": page ?? 1,
              "sort_direction": sortDirection ?? "DESC",
              "sort_by": sortBy ?? "created_at",
              "filters[status]": filterScope,
            },
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<PaginationData<PledgeData>>.fromJson(
        parsedData,
        (data) => PaginationData<PledgeData>.fromJson(
          data,
          (item) => PledgeData.fromJson(item),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Quote Data]
  Future<ApiResponse<QuoteData>> getDonationQuote({
    required String amount,
    required String currency,
  }) async {
    var completer = Completer<ApiResponse<QuoteData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.donationQuote(amount: amount, currency: currency),
            useAuth: false,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<QuoteData>.fromJson(
        parsedData,
        (data) => QuoteData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///bytes request
  Future<Uint8List> makeBytesRequest({
    RequestType requestType = RequestType.get,
    String requestUrl = "",
    Map<String, dynamic>? details,
  }) async {
    try {
      final bytes = await NetworkManager().networkBytesRequestManager(
        requestType,
        requestUrl,
        body: details != null ? jsonEncode(details) : null,
      );
      return Uint8List.fromList(bytes);
    } catch (e) {
      rethrow;
    }
  }
}
