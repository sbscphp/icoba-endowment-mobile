// import 'dart:convert';

import 'package:flutter/material.dart';

import '../../constants/secure_storage_constants.dart';
import 'secure_storage_init.dart';

class SecureStorageUtils {
  ///retrieve token
  static Future<String?> retrieveToken() async {
    return SecureStorageInit.storage.read(key: SecuredStorageConstants.token);
  }

  ///save passcode
  static saveToken({required String token}) async {
    await SecureStorageInit.storage.write(
      key: SecuredStorageConstants.token,
      value: token,
    );
  }

  ///retrieve refresh token
  static Future<String?> retrieveRefreshToken() async {
    return SecureStorageInit.storage.read(
      key: SecuredStorageConstants.refreshToken,
    );
  }

  static Future<void> saveRefreshToken({required String refreshToken}) async {
    await SecureStorageInit.storage.write(
      key: SecuredStorageConstants.refreshToken,
      value: refreshToken,
    );
  }

  ///save user details
  static saveUser({required String user}) async {
    SecureStorageInit.storage.write(
      key: SecuredStorageConstants.user,
      value: user,
    );
  }

  ///retrieve user details
  // static Future<User?> retrieveUser() async {
  //   final userString = await SecureStorageInit.storage.read(
  //     key: SecuredStorageConstants.user,
  //   );
  //   if (userString != null) {
  //     final user = User.fromJson(json.decode(userString));
  //     return user;
  //   }
  //   return null;
  // }

  ///save password
  static savePassword({required String? value}) async {
    SecureStorageInit.storage.write(
      key: SecuredStorageConstants.password,
      value: value,
    );
  }

  ///save passkey
  static savePasskey({required String? value}) async {
    SecureStorageInit.storage.write(
      key: SecuredStorageConstants.passkey,
      value: value,
    );
  }

  ///retrieve password
  static Future<String?> retrievePassword() async {
    final pref = await SecureStorageInit.storage.read(
      key: SecuredStorageConstants.password,
    );
    return pref;
  }

  ///retrieve passkey
  static Future<String?> retrievePasskey() async {
    final pref = await SecureStorageInit.storage.read(
      key: SecuredStorageConstants.passkey,
    );
    return pref;
  }

  // ///retrieve user details
  // static Future<User?> retrieveUser() async{
  //   final userString = await SecureStorageInit.storage.read(key: SecuredStorageConstants.user);
  //   if(userString != null) {
  //     final user = User.fromJson(json.decode(userString));
  //     return user;
  //   }
  //   return null;
  // }

  ///saves biometrics flag
  static biometricsEnabled() async {
    SecureStorageInit.storage.write(
      key: SecuredStorageConstants.biometricStatus,
      value: 'true',
    );
  }

  // ///retrieves 'biometrics status flag'
  // static Future<bool> isBiometricsEnabled() async{
  //   final seen = await SecureStorageInit.storage.read(key: SecuredStorageConstants.biometricStatus);
  //   return seen == 'true' ?  true : false;
  // }

  ///retrieves 'biometrics pref'
  static Future<bool> retrieveBiometricPref() async {
    final pref = await SecureStorageInit.storage.read(
      key: SecuredStorageConstants.biometricPref,
    );
    if (pref == null) return false;
    return pref == 'true' ? true : false;
  }

  ///saves biometrics pref
  static saveBiometricsPref({required bool? value}) async {
    print('pref to save::::::$value>>>>');
    SecureStorageInit.storage.write(
      key: SecuredStorageConstants.biometricPref,
      value: value == true ? 'true' : 'false',
    );
  }

  // static saveUserDetailsToStorage({required LoginResponse response, required String password})async{
  //
  //   //save token
  //   await SecureStorageUtils.saveToken(token: response.data?.accessToken ?? '');
  //
  //   //save password
  //   //await SecureStorageUtils.savePassword(value: password);
  //
  //   //retrieve saved user
  //   final savedUser = await SecureStorageUtils.retrieveUser();
  //
  //   if(savedUser == null || (savedUser.phoneno != response.data?.user?.phoneno)){
  //
  //     //update data in secure storage
  //     //await SecureStorageUtils.savePasskey(value: null);
  //     //await SecureStorageUtils.saveSavingsStatBalPref(value: null);
  //     //await SecureStorageUtils.saveInvestmentBalPref(value: null);
  //     //await SecureStorageUtils.saveAccountBalPref(value: null);
  //     //await SecureStorageUtils.saveBiometricsPref(value: null);
  //   }
  //
  //   if(response.data?.user != null){
  //     //convert user to string
  //     final userString = json.encode(response.data?.user?.toJson());
  //
  //     //save user
  //     await SecureStorageUtils.saveUser(user: userString);
  //   }
  // }

  ///delete all records
  static deleteAll() async {
    SecureStorageInit.storage.deleteAll();
  }

  ///delete a particular key

  static deleteKey({required String key}) async {
    SecureStorageInit.storage.delete(key: key);
    debugPrint('$key deleted>>>>>>');
  }

  ///retrieves 'theme pref'
  static Future<bool> retrieveThemePref() async {
    final pref = await SecureStorageInit.storage.read(
      key: SecuredStorageConstants.themePref,
    );
    if (pref == null) return false;
    return pref == 'true' ? true : false;
  }

  ///saves theme pref
  static saveThemePref({required bool? isDarkTheme}) async {
    SecureStorageInit.storage.write(
      key: SecuredStorageConstants.themePref,
      value: isDarkTheme == true ? 'true' : 'false',
    );
  }

  ///retrieve chat Session Token
  static Future<String?> retrieveSessionToken() async {
    return SecureStorageInit.storage.read(
      key: SecuredStorageConstants.chatSessionToken,
    );
  }

  ///save passcode
  static saveSessionToken({required String token}) async {
    await SecureStorageInit.storage.write(
      key: SecuredStorageConstants.chatSessionToken,
      value: token,
    );
  }

  static Future<String?> retrieveDashboardSummary() async {
    return SecureStorageInit.storage.read(
      key: SecuredStorageConstants.dashboardSummary,
    );
  }

  static Future<void> saveDashboardSummary({required String dashboardSummary}) async {
    await SecureStorageInit.storage.write(
      key: SecuredStorageConstants.dashboardSummary,
      value: dashboardSummary,
    );
  }

    static Future<void> deletedashboardSummary({required String dashboardSummary}) async {
    await SecureStorageInit.storage.delete(
      key: SecuredStorageConstants.dashboardSummary,
    );
  }
}
