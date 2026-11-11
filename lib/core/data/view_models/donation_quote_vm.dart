import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/constants/app_constants.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/donation_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/quote_data.dart';
import 'package:icoba_endowment_mobile/core/data/states/base_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/locator.dart';

class DonationQuoteVm extends BaseState {
  final DonationDataProvider _dataProvider = locator<DonationDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  QuoteData? _quoteData;
  QuoteData? get quoteData => _quoteData;

  String get amount => _quoteData?.donationAmount?.toString() ?? "0";
  String get serviceFee => _quoteData?.feeAmount?.toString() ?? "0";
  String get total => _quoteData?.totalAmount?.toString() ?? "0";
  String get currency => _quoteData?.currency ?? "NGN";


  Future<void> getDonationQuote({
    required String amount,
    required String currency,
  }) async {
    setState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getDonationQuote(amount: amount, currency: currency)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _quoteData = response.data;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }
}

final donationQuoteVm = ChangeNotifierProvider.autoDispose<DonationQuoteVm>((
  ref,
) {
  return DonationQuoteVm();
});
