// import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/login_response.dart';
import 'package:icoba_endowment_mobile/core/utilities/secure_storage/secure_storage_utils.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_providers/auth_data_provider.dart';
import '../../models/country.dart';
import '../../models/response_data/challenge_token_model.dart';
import '../../models/response_data/corporate_category.dart';
import '../../models/response_data/donation_category.dart';
import '../../models/response_data/onboarding_dropdown_data.dart';
import '../../models/response_data/sets_category.dart';
import '../../states/base_state.dart';

class AuthVm extends BaseState {
  final AuthDataProvider _dataProvider = locator<AuthDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  OnboardingDropdownData? _onboardingDropdownData;
  OnboardingDropdownData? get onboardingDropdownData => _onboardingDropdownData;

  List<DonationCategory> get donorTypes =>
      _onboardingDropdownData?.donorTypes ?? [];
  List<CorporateCategory> get corporateCategories =>
      _onboardingDropdownData?.corporateCategories ?? [];
  List<SetsCategory> get sets => _onboardingDropdownData?.sets ?? [];
  List<Country> get countries => _onboardingDropdownData?.countries ?? [];

  DonationCategory? selectedDonorType;

  Future<void> getOnboardingDropdownData() async {
    setState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getOnboardingData()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _onboardingDropdownData = response.data;
          selectedDonorType = null;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  SetsCategory? selectedSet;
  Country? selectedCountry;
  CorporateCategory? selectedCorporateCategory;
  ChallengeTokenModel? _tokenResponse;
  int? get timerDuration => _tokenResponse?.expiresIn;

  Future<void> registerAlumni({
    required String email,
    required String password,
    required String phone,
    required String fname,
    required String lname,
    String? alumniId,
  }) async {
    setState(ViewState.busy);

    final details = {
      "donor_type": "icoba_alumni",
      "email": email,
      "password": password,
      "password_confirmation": password,
      "phone_number": phone, //"+2348012345684",
      "country_uuid": selectedCountry?.uuid,
      "firstname": fname,
      "lastname": lname,
      "set_number": selectedSet?.setNumber,
      "alumni_identifier": alumniId,
      "client": "mobile",
      // "otp_channel": "email", //default is email. options: email, sms
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .signup(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          selectedDonorType = null;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  Future<void> registerCorporate({
    required String email,
    required String password,
    required String phone,
    required String orgName,
    required String rcNumber,
    required String tin,
  }) async {
    setState(ViewState.busy);

    final details = {
      "donor_type": "corporate_donor",
      "email": email,
      "password": password,
      "password_confirmation": password,
      "phone_number": phone, //"+2348023455789",
      "country_uuid": selectedCountry?.uuid,
      "organization_name": orgName,
      "corporate_category_uuid": selectedCorporateCategory?.uuid,
      "rc_number": rcNumber, //"12345",
      "tin": tin, //"31213050-0001",
      "client": "mobile", //web or mobile
      // "otp_channel": "email" //default is email. options: email, sms
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .signup(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          selectedDonorType = null;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  Future<void> registerFriends({
    required String email,
    required String password,
    required String phone,
    required String fname,
    required String lname,
  }) async {
    setState(ViewState.busy);

    final details = {
      "donor_type": "friends_of_icoba",
      "email": email,
      "password": password,
      "password_confirmation": password,
      "phone_number": phone, //"+14155552672",
      "country_uuid": selectedCountry?.uuid,
      "firstname": fname,
      "lastname": lname,
      "client": "mobile", //web or mobile
      // "otp_channel": "email" //default is email. options: email, sms
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .signup(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  LoginResponse? _loginResponse;

  Future<void> verifyOTP({required String otp}) async {
    setSecondState(ViewState.busy);

    final details = {
      "challenge_token": _tokenResponse?.challengeToken,
      "otp": otp,
      "client": "mobile", //web or mobile
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .verifyOtp(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _loginResponse = response.data;
          //todo::: handle token cache here and route to bottom nav on Retrived
          await SecureStorageUtils.saveToken(
            token: _loginResponse?.accessToken ?? "",
          );
          await SecureStorageUtils.saveRefreshToken(
            refreshToken: _loginResponse?.refreshTOken ?? "",
          );
          // await SecureStorageUtils.saveUser(
          //   user: jsonEncode(_loginResponse?.user?.toJson()),
          // );
          setSecondState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setSecondState(ViewState.error);
        });
  }

  Future<void> resendOTP() async {
    setThirdState(ViewState.busy);

    final details = {
      "challenge_token": _tokenResponse?.challengeToken,
      // "otp_channel": "sms",
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .resendOtp(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          setThirdState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setThirdState(ViewState.error);
        });
  }

  String? _userMail;
  String? get userMail => _userMail;

  bool _isUserBioUser = false;
  bool get isUserBioUser => _isUserBioUser;


  Future<void> getCachedUser() async {
    final userData = await SecureStorageUtils.retrieveEmail();
    _isUserBioUser = await SecureStorageUtils.retrieveBiometricPref();
    if (userData != null) {
      _userMail = userData;
      notifyListeners();
    }
  }

  bool get is2FA => _loginResponse?.twofa ?? false;
  int? get twoFaDuration => _loginResponse?.expiresIn;

  Future<void> login({
    required String email,
    String? password,
    bool isBiometricLogin = false,
  }) async {
    setState(ViewState.busy);
    final userPassword = await SecureStorageUtils.retrievePassword();

    final details = {
      "email": email,
      "password": isBiometricLogin ? userPassword : password,
      "client": "mobile", //web or mobile
    };

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .login(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _loginResponse = response.data;
          if (!isBiometricLogin) {
            await SecureStorageUtils.savePassword(value: password);
          }

          if (response.data?.user != null) {
            //2FA false cache data and login
            await SecureStorageUtils.saveToken(
              token: _loginResponse?.accessToken ?? "",
            );
            await SecureStorageUtils.saveRefreshToken(
              refreshToken: _loginResponse?.refreshTOken ?? "",
            );
            await SecureStorageUtils.saveEmail(user: email);
            //todo::: no welcome back design<-> using remember me email
            // await SecureStorageUtils.saveUser(
            //   user: jsonEncode(_loginResponse?.user?.toJson()),
            // );

            // Future.delayed(Duration(seconds: 1));
          }

          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  Future<void> verifyLoginOTP({required String otp}) async {
    setSecondState(ViewState.busy);

    final details = {
      "challenge_token": _loginResponse?.challengeToken,
      "otp": otp,
      "client": "mobile", //web or mobile
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .verifyLoginOtp(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _loginResponse = response.data;
          await SecureStorageUtils.saveToken(
            token: _loginResponse?.accessToken ?? "",
          );
          await SecureStorageUtils.saveRefreshToken(
            refreshToken: _loginResponse?.refreshTOken ?? "",
          );
          // await SecureStorageUtils.saveUser(
          //   user: jsonEncode(_loginResponse?.user?.toJson()),
          // );
          setSecondState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setSecondState(ViewState.error);
        });
  }

  Future<void> resendLoginOTP() async {
    setThirdState(ViewState.busy);

    final details = {
      "challenge_token": _loginResponse?.challengeToken,
      // "otp_channel": "sms",
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .resendLoginOtp(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          setThirdState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setThirdState(ViewState.error);
        });
  }

  Future<void> forgotPassword({required String email}) async {
    setState(ViewState.busy);

    final details = {
      "email": email,
      "otp_channel": "email", //web or mobile
    };

    await _dataProvider
        .forgotPassword(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  Future<void> verifyResetOTP({required String otp}) async {
    setSecondState(ViewState.busy);

    final details = {
      "challenge_token": _tokenResponse?.challengeToken,
      "otp": otp,
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .verifyResetOtp(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          setSecondState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setSecondState(ViewState.error);
        });
  }

  Future<void> resendResetOTP() async {
    setThirdState(ViewState.busy);

    final details = {
      "challenge_token": _tokenResponse?.challengeToken,
      // "otp_channel": "sms",
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .resendResetOtp(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _tokenResponse = response.data;
          setThirdState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setThirdState(ViewState.error);
        });
  }

  Future<void> resetPassword({required String password}) async {
    setState(ViewState.busy);

    final details = {
      "reset_token": _tokenResponse?.resetToken,
      "password": password,
      "password_confirmation": password,
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .resetPassword(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }
}

final authViewModel = ChangeNotifierProvider<AuthVm>((ref) {
  return AuthVm();
});
