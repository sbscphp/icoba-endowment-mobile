
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/dashboard_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/recent_donor.dart';
import 'package:icoba_endowment_mobile/core/data/states/dashboard_state.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../models/response_data/campaign_fund_data.dart';
import '../../models/response_data/dashboard_summary.dart';

class DashboardVm extends DashboardState {
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
    setState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getDashboardSummary()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _dashboardSummary = response.data;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  List<RecentDonor> _donors = [];
  List<RecentDonor> get donors => _donors;

  // int recdonPage = 1;
  // int recdonTotal = 0;

  Future<void> getRecentDonations({bool firstCall = true}) async {
    if (firstCall) {
      // recdonPage = 1;
      setSecondState(ViewState.busy);
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
            setSecondState(ViewState.retrieved);
          } else {
            _donors.addAll(response.data ?? []);
            // recdonPage++;
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

  List<CampaignFundData> _fundsData = [];
  List<CampaignFundData> get fundsData => _fundsData;

  Future<void> getFundsData() async {
    setThirdState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getFundsData()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _fundsData = response.data ?? [];
          setThirdState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setThirdState(ViewState.error);
        });
  }
}

final dashboardViewModel = ChangeNotifierProvider<DashboardVm>((ref) {
  return DashboardVm();
});
