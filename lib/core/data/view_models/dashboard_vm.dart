import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/dashboard_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recent_donor.dart';
import 'package:icoba_endowment_mobile/core/data/states/base_state.dart';

import '../../../locator.dart';
import '../../constants/app_constants.dart';
import '../../utilities/utilities.dart';
import '../enum/view_state.dart';
import '../models/response_data/campaign_fund_data.dart';
import '../models/response_data/dashboard_summary.dart';
import '../models/response_data/leader_board_donor_data.dart';
import '../models/response_data/leader_board_set_data.dart';
import '../models/response_data/transaction_data.dart';

class DashboardVm extends BaseState {
  final DashboardDataProvider _dataProvider = locator<DashboardDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  DashboardSummary? _dashboardSummary;
  int get donationCount => _dashboardSummary?.donationCount ?? 0;
  String get currency => _dashboardSummary?.currencyPreview ?? "NGN";

  double get totalDonation =>
      double.tryParse(_dashboardSummary?.totalDonationsAmountNgn ?? '0') ?? 0;
  double get totalPledges =>
      double.tryParse(_dashboardSummary?.pledgesCommittedAmountNgn ?? '0') ?? 0;

  Future<void> getDashboardSummary() async {
    setDashboardState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getDashboardSummary()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _dashboardSummary = response.data;
          setDashboardState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDashboardState(ViewState.error);
        });
  }

  List<TransactionData> _transactions = [];
  List<TransactionData> get transactions => _transactions;

  int transactionPage = 1;
  int transactionTotal = 0;

  Future<void> getTransactions({bool firstCall = true}) async {
    if (firstCall) {
      transactionPage = 1;
      setDashboardState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getTransactions(page: transactionPage)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          if (firstCall) {
            _transactions = response.data?.data ?? [];
            transactionPage++;
            transactionTotal = response.data?.total ?? 0;
            setDashboardState(ViewState.retrieved);
          } else {
            _transactions.addAll(response.data?.data ?? []);
            transactionPage++;
            setPaginatedState(ViewState.retrieved);
          }
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          if (firstCall) {
            setDashboardState(ViewState.error);
          } else {
            setPaginatedState(ViewState.error);
          }
        });
  }

  List<RecentDonor> _donors = [];
  List<RecentDonor> get donors => _donors;

  int recdonPage = 1;
  int recdonTotal = 0;

  Future<void> getRecentDonations({bool firstCall = true}) async {
    if (firstCall) {
      // recdonPage = 1;
      setDashboardState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getRecentDonations()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          if (firstCall) {
            _donors = response.data ?? [];
            // recdonPage++;
            // transactionTotal = response.data?.total ?? 0;
            setDashboardState(ViewState.retrieved);
          } else {
            _donors.addAll(response.data ?? []);
            // recdonPage++;
            setPaginatedState(ViewState.retrieved);
          }
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          if (firstCall) {
            setDashboardState(ViewState.error);
          } else {
            setPaginatedState(ViewState.error);
          }
        });
  }

  String _selectedDonationViewType = "";
  String get selectedDonationViewType => _selectedDonationViewType;
  set selectedDonationViewType(String value) {
    _selectedDonationViewType = value;
    notifyListeners();
  }

  String _selectedPledgeViewType = "";
  String get selectedPledgeViewType => _selectedPledgeViewType;
  set selectedPledgeViewType(String value) {
    _selectedPledgeViewType = value;
    notifyListeners();
  }

  List<CampaignFundData> _fundsData = [];
  List<CampaignFundData> get fundsData => _fundsData;

  Future<void> getFundsData() async {
    setDashboardState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getFundsData()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _fundsData = response.data ?? [];
          setDashboardState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDashboardState(ViewState.error);
        });
  }

  List<LeaderBoardDonorData> _leaderBoardDonors = [];
  List<LeaderBoardDonorData> get leaderBoardDonors => _leaderBoardDonors;

  List<LeaderBoardDonorData> _leaderBoardDonorsPledges = [];
  List<LeaderBoardDonorData> get leaderBoardDonorsPledges =>
      _leaderBoardDonorsPledges;

  //pagination details
  int donorDonationPage = 1;
  int donorPledgePage = 1;

  int donorDonationtotal = 0;
  int donorPledgetotal = 0;

  //?GETS LEADERBOARD DONORS
  Future<void> getLeaderBoardDonors({
    String? scope = "donations", //??DONATIONS??PLEDGES??ALL
    bool firstCall = true,
    bool isSearch = false,
    String? searchQuery,
  }) async {
    if (firstCall) {
      if (scope == "donations") {
        donorDonationPage = 1;
      } else {
        donorPledgePage = 1;
      }
      setLeaderboardState(ViewState.busy);
    } else {
      if (isSearch) {
        donorDonationPage = 1;
        donorPledgePage = 1;
      }
      setPaginatedState(ViewState.busy);
    }

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getLeaderBoardDonors(
          scope: scope,
          search: searchQuery,
          page: scope == "donations" ? donorDonationPage : donorPledgePage,
        )
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;

          if (firstCall || isSearch) {
            if (scope == "donations") {
              _leaderBoardDonors = response.data?.data ?? [];
              donorDonationPage++;
              donorDonationtotal = response.data?.total ?? 0;
            } else {
              _leaderBoardDonorsPledges = response.data?.data ?? [];
              donorPledgePage++;
              donorPledgetotal = response.data?.total ?? 0;
            }
            if (isSearch) setPaginatedState(ViewState.retrieved);
            setLeaderboardState(ViewState.retrieved);
          } else {
            //add to list
            if (scope == "donations") {
              _leaderBoardDonors.addAll(List.from(response.data?.data ?? []));
              donorDonationPage++;
            } else {
              _leaderBoardDonorsPledges.addAll(
                List.from(response.data?.data ?? []),
              );
              donorPledgePage++;
            }
            setPaginatedState(ViewState.retrieved);
          }
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          if (firstCall) {
            setLeaderboardState(ViewState.error);
          } else {
            setPaginatedState(ViewState.error);
          }
        });
  }

  List<LeaderBoardSetData> _leaderBoardSets = [];
  List<LeaderBoardSetData> get leaderBoardSets => _leaderBoardSets;

  List<LeaderBoardSetData> _leaderBoardSetsPledges = [];
  List<LeaderBoardSetData> get leaderBoardSetsPledges =>
      _leaderBoardSetsPledges;

  //donations
  LeaderBoardSetData? setDonationOne;
  LeaderBoardSetData? setDonationTwo;
  LeaderBoardSetData? setDonationThree;

  //pledges
  LeaderBoardSetData? setPledgeOne;
  LeaderBoardSetData? setPledgeTwo;
  LeaderBoardSetData? setPledgeThree;

  //pagination details
  int setPledgePage = 1;
  int setDonationPage = 1;

  int setPledgetotal = 0;
  int setDonationtotal = 0;
  //?GETS LEADERBOARD SETS
  Future<void> getLeaderBoardSets({
    String? scope = "donations", //??DONATIONS??PLEDGES??ALL
    String? sortDirection = 'asc',
    bool firstCall = true,
    bool isSearch = false,
    String? searchQuery,
  }) async {
    if (firstCall) {
      if (scope == "donations") {
        setDonationPage = 1;
      } else {
        setPledgePage = 1;
      }
      setLeaderboardState(ViewState.busy);
    } else {
      if (isSearch) {
        setDonationPage = 1;
        setPledgePage = 1;
      }
      setPaginatedState(ViewState.busy);
    }

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getLeaderBoardSets(
          scope: scope,
          search: searchQuery,
          sortDirection: sortDirection,
          page: scope == "donations" ? setDonationPage : setPledgePage,
        )
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          if (firstCall || isSearch) {
            if (scope == "donations") {
              _leaderBoardSets = response.data?.data ?? [];
              setDonationPage++;
              setDonationtotal = response.data?.total ?? 0;

              if (_leaderBoardSets.isNotEmpty &&
                  _leaderBoardSets.length > 3 &&
                  !isSearch) {
                setDonationOne = _leaderBoardSets[0];
                setDonationTwo = _leaderBoardSets[1];
                setDonationThree = _leaderBoardSets[2];
              }
            } else {
              _leaderBoardSetsPledges = response.data?.data ?? [];
              setPledgePage++;
              setPledgetotal = response.data?.total ?? 0;

              if (_leaderBoardSetsPledges.isNotEmpty &&
                  _leaderBoardSetsPledges.length > 3 &&
                  !isSearch) {
                setPledgeOne = _leaderBoardSetsPledges[0];
                setPledgeTwo = _leaderBoardSetsPledges[1];
                setPledgeThree = _leaderBoardSetsPledges[2];
              }
            }
            if (isSearch) setPaginatedState(ViewState.retrieved);
            setLeaderboardState(ViewState.retrieved);
          } else {
            //add to list
            if (scope == "donations") {
              _leaderBoardSets.addAll(List.from(response.data?.data ?? []));
              setDonationPage++;
            } else {
              _leaderBoardSetsPledges.addAll(
                List.from(response.data?.data ?? []),
              );
              setPledgePage++;
            }
            setPaginatedState(ViewState.retrieved);
          }
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          if (firstCall) {
            setLeaderboardState(ViewState.error);
          } else {
            setPaginatedState(ViewState.error);
          }
        });
  }
}

final dashboardViewModel = ChangeNotifierProvider<DashboardVm>((ref) {
  return DashboardVm();
});
