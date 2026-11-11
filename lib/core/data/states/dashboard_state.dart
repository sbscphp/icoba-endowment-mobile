import 'package:flutter/material.dart';

import '../enum/view_state.dart';

class DashboardState extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  ViewState _secondState = ViewState.idle;
  ViewState get secondState => _secondState;

  ViewState _thirdState = ViewState.idle;
  ViewState get thirdState => _thirdState;

  ViewState _paginatedState = ViewState.idle;
  ViewState get paginatedState => _paginatedState;

  void setState(ViewState viewState, {bool notifyListener = true}) {
    _state = viewState;
    if (notifyListener) {
      notifyListeners();
    }
  }

  void setSecondState(ViewState viewState) {
    _secondState = viewState;
    notifyListeners();
  }

  void setThirdState(ViewState viewState) {
    _thirdState = viewState;
    notifyListeners();
  }

  void setPaginatedState(ViewState viewState) {
    _paginatedState = viewState;
    notifyListeners();
  }

}
