import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/user_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/notification_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/notification_preference.dart';
import 'package:icoba_endowment_mobile/core/data/models/user.dart';
import 'package:icoba_endowment_mobile/core/data/states/base_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/secure_storage/secure_storage_utils.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../models/response_data/recognition_data.dart';

class UserVm extends BaseState {
  final UserDataProvider _dataProvider = locator<UserDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  User? _user;
  User? get user => _user;

  String get firstName => _user?.firstname ?? "N/A";
  String get middleName => _user?.middlename ?? "N/A";
  String get lastName => _user?.lastname ?? "N/A";
  String get fullName => _user?.fullName ?? "N/A";
  String get email => _user?.email ?? "N/A";
  String get setName => _user?.donor?.set?.setNumber ?? "N/A";
  String get affiliatedSetName =>
      _user?.donor?.affiliatedSet?.setNumber ?? "N/A";
  bool get twoFA => _user?.twoFa ?? false;
  bool get isPushnotificationEnabled =>
      _user?.pushNotificationsEnabled ?? false;
  bool get isEmailNotificationsEnabled =>
      _user?.emailNotificationsEnabled ?? false;
  bool get isOrganization => _user?.donor?.rcNumber != null;
  bool get isWife => _user?.donor?.wivesType != null;
  String get house => _user?.donor?.house?.label ?? "N/A";
  String get phone => _user?.phoneNumber ?? "N/A";
  String get tierBadgeUrl => _user?.donationTier?.tierBadgeUrl ?? "";
  bool _isBioUser = false;
  bool get isBioUser => _isBioUser;
  set isBioUser(bool val) {
    _isBioUser = val;
    notifyListeners();
  }

  Future<void> getUserProfile() async {
    setState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getUserProfile()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _user = response.data;
          //get biometrics update
          _isBioUser = await SecureStorageUtils.retrieveBiometricPref();
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  Future<void> toggle2FA({bool? value}) async {
    _user?.twoFa = value;
    setState(ViewState.busy);

    await _dataProvider
        .toggle2FA()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _user?.twoFa = !(value ?? false);

          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  Future<void> updatePassword({required String password}) async {
    setState(ViewState.busy);
    final details = {"password": password, "password_confirmation": password};

    await _dataProvider
        .updatePassword(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          await SecureStorageUtils.savePassword(value: password);
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  NotificationPreference? _notificationPreference;
  // bool get pushNotificationPreference =>
  //     _notificationPreference?.pushNotificationsEnabled ?? false;
  // bool get emailNotificationPreference =>
  //     _notificationPreference?.emailNotificationsEnabled ?? false;

  Future<void> updateNotificationPreference({
    bool? pushNotifications,
    bool? emailNotifications,
  }) async {
    if (pushNotifications != null) {
      _user?.pushNotificationsEnabled = pushNotifications;
    }
    if (emailNotifications != null) {
      _user?.emailNotificationsEnabled = emailNotifications;
    }
    setState(ViewState.busy);
    final details = {
      "email_notifications_enabled": emailNotifications,
      "push_notifications_enabled": pushNotifications,
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .updateNotificationPreserence(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _notificationPreference = response.data;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          if (pushNotifications != null) {
            _notificationPreference?.pushNotificationsEnabled =
                !pushNotifications;
          }
          if (emailNotifications != null) {
            _notificationPreference?.emailNotificationsEnabled =
                !emailNotifications;
          }
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  List<NotificationData> _notifications = [];
  List<NotificationData> get notifications => _notifications;

  Future<void> getNotifications() async {
    setState(ViewState.busy);

    await _dataProvider
        .getNotifications()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _notifications = response.data?.data ?? [];
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  List<RecognitionData> _recognitions = [];
  List<RecognitionData> get recognitions => _recognitions;

  Future<void> getRecognitions() async {
    setState(ViewState.busy);

    await _dataProvider
        .getRecognitions()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _recognitions = response.data?.data ?? [];
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }
}

final userViewModel = ChangeNotifierProvider<UserVm>((ref) {
  return UserVm();
});
