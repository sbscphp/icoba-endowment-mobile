import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/constants/app_constants.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/user_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/states/base_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/secure_storage/secure_storage_utils.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/locator.dart';

class DeleteAccountVm extends BaseState {
  final UserDataProvider _dataProvider = locator<UserDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  Future<void> deleteAccount({required String reason}) async {
    setState(ViewState.busy);
    final details = {"reason": reason};

    await _dataProvider
        .deleteAccount(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          await SecureStorageUtils.deleteAll();
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }
}

final deleteAccountViewModel = ChangeNotifierProvider<DeleteAccountVm>((ref) {
  return DeleteAccountVm();
});
