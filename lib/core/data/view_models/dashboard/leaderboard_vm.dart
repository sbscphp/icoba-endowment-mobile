
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/dashboard_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/leader_board_house_data.dart';
import 'package:icoba_endowment_mobile/core/data/states/dashboard_state.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../models/response_data/leader_board_donor_data.dart';
import '../../models/response_data/leader_board_set_data.dart';

class LeaderboardVm extends DashboardState {
  final DashboardDataProvider _dataProvider = locator<DashboardDataProvider>();

  //message
  String _message = '';
  String get message => _message;

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
      setState(ViewState.busy);
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
            setState(ViewState.retrieved);
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
            setState(ViewState.error);
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

  List<LeaderBoardSetData> sortByFulfilledAmountAscending(
    List<LeaderBoardSetData> data,
  ) {
    final sorted = List<LeaderBoardSetData>.from(data);
    sorted.sort((a, b) {
      final aValue = double.tryParse(a.fulfilledAmountNgn ?? '0') ?? 0.0;
      final bValue = double.tryParse(b.fulfilledAmountNgn ?? '0') ?? 0.0;
      return bValue.compareTo(aValue); // b vs a instead of a vs b
    });
    return sorted;
  }

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
      setSecondState(ViewState.busy);
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
                setPledgeOne = sortByFulfilledAmountAscending(
                  _leaderBoardSetsPledges,
                )[0];
                setPledgeTwo = sortByFulfilledAmountAscending(
                  _leaderBoardSetsPledges,
                )[1];
                setPledgeThree = sortByFulfilledAmountAscending(
                  _leaderBoardSetsPledges,
                )[2];
              }
            }
            if (isSearch) setPaginatedState(ViewState.retrieved);
            setSecondState(ViewState.retrieved);
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
            setSecondState(ViewState.error);
          } else {
            setPaginatedState(ViewState.error);
          }
        });
  }

  List<LeaderBoardHouseData> _leaderBoardHouses = [];
  List<LeaderBoardHouseData> get leaderBoardHouses => _leaderBoardHouses;

  List<LeaderBoardHouseData> _leaderBoardHousesPledges = [];
  List<LeaderBoardHouseData> get leaderBoardHousesPledges =>
      _leaderBoardHousesPledges;

  //pagination details
  int housePledgePage = 1;
  int houseDonationPage = 1;

  int housePledgetotal = 0;
  int houseDonationtotal = 0;
  //?GETS LEADERBOARD SETS
  Future<void> getLeaderBoardHouses({
    String? scope = "donations", //??DONATIONS??PLEDGES??ALL
    String? sortDirection = 'asc',
    bool firstCall = true,
    bool isSearch = false,
    String? searchQuery,
  }) async {
    if (firstCall) {
      if (scope == "donations") {
        houseDonationPage = 1;
      } else {
        housePledgePage = 1;
      }
      setThirdState(ViewState.busy);
    } else {
      if (isSearch) {
        houseDonationPage = 1;
        housePledgePage = 1;
      }
      setPaginatedState(ViewState.busy);
    }

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getLeaderBoardHouses(
          scope: scope,
          search: searchQuery,
          sortDirection: sortDirection,
          page: scope == "donations" ? houseDonationPage : housePledgePage,
        )
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          if (firstCall || isSearch) {
            if (scope == "donations") {
              _leaderBoardHouses = response.data?.data ?? [];
              houseDonationPage++;
              setDonationtotal = response.data?.total ?? 0;
            } else {
              _leaderBoardHousesPledges = response.data?.data ?? [];
              housePledgePage++;
              housePledgetotal = response.data?.total ?? 0;
            }
            if (isSearch) setPaginatedState(ViewState.retrieved);
            setThirdState(ViewState.retrieved);
          } else {
            //add to list
            if (scope == "donations") {
              _leaderBoardHouses.addAll(List.from(response.data?.data ?? []));
              houseDonationPage++;
            } else {
              _leaderBoardHousesPledges.addAll(
                List.from(response.data?.data ?? []),
              );
              housePledgePage++;
            }
            setPaginatedState(ViewState.retrieved);
          }
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          if (firstCall) {
            setThirdState(ViewState.error);
          } else {
            setPaginatedState(ViewState.error);
          }
        });
  }
}

final leaderboardViewModel = ChangeNotifierProvider<LeaderboardVm>((ref) {
  return LeaderboardVm();
});
