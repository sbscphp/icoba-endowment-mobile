import 'dart:async';
import 'dart:convert';

import 'package:icoba_endowment_mobile/core/data/models/data/pagination_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recent_donor.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/transaction_data.dart';

import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/api_response.dart';
import '../models/response_data/campaign_fund_data.dart';
import '../models/response_data/dashboard_summary.dart';
import '../models/response_data/leader_board_donor_data.dart';
import '../models/response_data/leader_board_set_data.dart';
import '../network_manager/network_manager.dart';
import '../services/api_encryption_service.dart';

class DashboardDataProvider {
  ///get [Dashboard Summary]
  Future<ApiResponse<DashboardSummary>> getDashboardSummary() async {
    var completer = Completer<ApiResponse<DashboardSummary>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.dashboardSummary,
            useAuth: true,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<DashboardSummary>.fromJson(
        parsedData,
        (data) => DashboardSummary.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Funds Update] ✅
  Future<ApiResponse<List<CampaignFundData>>> getFundsData() async {
    var completer = Completer<ApiResponse<List<CampaignFundData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.fundsData,
            useAuth: true,
            // body: jsonEncode(details),
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<List<CampaignFundData>>.fromJson(
        parsedData,
        (data) => List.from(data)
            .map(
              (item) => CampaignFundData.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Transactions] ✅
  Future<ApiResponse<PaginationData<TransactionData>>> getTransactions({
    String? search,
    String? startDate,
    String? endDate,
    int? page,
    String? sortDirection,
    String? sortBy,
    String? filterScope,
  }) async {
    var completer = Completer<ApiResponse<PaginationData<TransactionData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.transactions,
            useAuth: true,
            // body: jsonEncode(details),
            queryParameters: {
              "search": search,
              "start_date": startDate,
              "end_date": endDate,
              "page": page ?? 1,
              "sort_direction": sortDirection,
              "sort_by": sortBy,
              "filters[scope]": filterScope,
            },
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<PaginationData<TransactionData>>.fromJson(
        parsedData,
        (data) => PaginationData<TransactionData>.fromJson(
          data,
          (item) => TransactionData.fromJson(item),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [RECENT DONORS] ✅
  Future<ApiResponse<List<RecentDonor>>> getRecentDonations() async {
    var completer = Completer<ApiResponse<List<RecentDonor>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.recentDonors,
            // useAuth: true,
            // body: jsonEncode(details),
            // queryParameters: {
            //   "search": search,
            //   "start_date": startDate,
            //   "end_date": endDate,
            //   "page": page ?? 1,
            //   "sort_direction": sortDirection,
            //   "sort_by": sortBy,
            //   "filters[scope]": filterScope,
            // },
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<List<RecentDonor>>.fromJson(
        parsedData,
        (data) => List.from(data).map((e) => RecentDonor.fromJson(e)).toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Leader Board Donors] ✅
  Future<ApiResponse<PaginationData<LeaderBoardDonorData>>>
  getLeaderBoardDonors({
    String? search,
    String? scope = "donations", //default
    int? page,
    String? sortDirection = "desc",
    String? sortBy = "amount",
    String? tierUUID,
  }) async {
    var completer =
        Completer<ApiResponse<PaginationData<LeaderBoardDonorData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.leaderBoard,
            useAuth: false,
            // body: jsonEncode(details),
            queryParameters: {
              "search": search,
              "scope": scope,
              "page": page ?? 1,
              "sort_dir": sortDirection,
              "sort_by": sortBy,
              "tier_uuid": tierUUID,
            },
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<PaginationData<LeaderBoardDonorData>>.fromJson(
        parsedData,
        (data) => PaginationData<LeaderBoardDonorData>.fromJson(
          data,
          (item) => LeaderBoardDonorData.fromJson(item),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  ///get [Leader Board Sets] ✅
  Future<ApiResponse<PaginationData<LeaderBoardSetData>>> getLeaderBoardSets({
    String? search,
    String? scope = "donations", //default
    int? page,
    String? sortDirection = "asc",
    String? sortBy = "amount",
  }) async {
    var completer =
        Completer<ApiResponse<PaginationData<LeaderBoardSetData>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(
            RequestType.get,
            ApiRoutes.leaderBoardSets,
            useAuth: false,
            // body: jsonEncode(details),
            queryParameters: {
              "search": search,
              "scope": scope,
              "page": page ?? 1,
              "sort_dir": sortDirection,
              "sort_by": sortBy,
            },
          );

      final decryptedString = aesDecrypt(response["response"]);

      final parsedData = jsonDecode(decryptedString);

      var result = ApiResponse<PaginationData<LeaderBoardSetData>>.fromJson(
        parsedData,
        (data) => PaginationData<LeaderBoardSetData>.fromJson(
          data,
          (item) => LeaderBoardSetData.fromJson(item),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
}
