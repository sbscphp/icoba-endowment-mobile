import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/constants/app_constants.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/dashboard_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/transaction_data.dart';
import 'package:icoba_endowment_mobile/core/data/states/dashboard_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/locator.dart';

class TransactionsVm extends DashboardState {
  final DashboardDataProvider _dataProvider = locator<DashboardDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  List<TransactionData> _transactions = [];
  List<TransactionData> get transactions => _transactions;

  int transactionPage = 1;
  int transactionTotal = 0;

  Future<void> getTransactions({bool firstCall = true}) async {
    if (firstCall) {
      transactionPage = 1;
      setState(ViewState.busy);
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
            setState(ViewState.retrieved);
          } else {
            _transactions.addAll(response.data?.data ?? []);
            transactionPage++;
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
}

final transactionsViewModel = ChangeNotifierProvider<TransactionsVm>((ref) {
  return TransactionsVm();
});
