import 'package:flutter/material.dart';

import '../enum/view_state.dart';

class BaseState extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ViewState _secondState = ViewState.idle;
  ViewState get secondState => _secondState;

  ViewState _thirdState = ViewState.idle;
  ViewState get thirdState => _thirdState;

  ViewState _paginatedState = ViewState.idle;
  ViewState get paginatedState => _paginatedState;

  setState(ViewState viewState, {bool notifyListener = true}) {
    _state = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  setSecondState(ViewState viewState) {
    _secondState = viewState;
    notifyListeners();
  }

  setThirdState(ViewState viewState) {
    _thirdState = viewState;
    notifyListeners();
  }

  setPaginatedState(ViewState viewState) {
    _paginatedState = viewState;
    notifyListeners();
  }

  ViewState _dashboardState = ViewState.idle;
  ViewState get dashboardState => _dashboardState;

  setDashboardState(ViewState viewState, {bool notifyListener = true}) {
    _dashboardState = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  ViewState _leaderboardState = ViewState.idle;
  ViewState get leaderboardState => _leaderboardState;

  setLeaderboardState(ViewState viewState, {bool notifyListener = true}) {
    _leaderboardState = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  ViewState _donationState = ViewState.idle;
  ViewState get donationState => _donationState;

  setDonationState(ViewState viewState, {bool notifyListener = true}) {
    _donationState = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  ViewState _pledgeState = ViewState.idle;
  ViewState get pledgeState => _pledgeState;

  setPledgeState(ViewState viewState, {bool notifyListener = true}) {
    _pledgeState = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }
}
