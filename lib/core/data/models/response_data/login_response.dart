import 'package:icoba_endowment_mobile/core/data/models/user.dart';

class LoginResponse {
  final String? accessToken;
  final String? refreshTOken;
  final String? tokenType;
  final int? expiresIn;
  final int? refreshExpiresIn;
  final String? registrationStep;
  final String? userType;
  //2FA->active
  final String? challengeToken;
  final bool? cooldownActive;
  final bool? twofa;
  final String? otpPurpose;
  final String? otpChannel;

  final User? user;

  const LoginResponse({
    this.accessToken,
    this.tokenType,
    this.registrationStep,
    this.userType,
    this.user,
    this.refreshTOken,
    this.expiresIn,
    this.refreshExpiresIn,
    //2FA
    this.challengeToken,
    this.cooldownActive,
    this.otpPurpose,
    this.otpChannel,
    this.twofa,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      refreshTOken: json['refresh_token'],
      tokenType: json['token_type'],
      refreshExpiresIn: json['refresh_expires_in'],
      expiresIn: json["expires_in"],
      registrationStep: json['registration_step'],
      userType: json['user_type'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      //2fa
      challengeToken: json['challenge_token'],
      cooldownActive: json['cooldown_active'],
      otpPurpose: json['otp_purpose'],
      otpChannel: json['otp_channel'],
      twofa: json['2fa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'registration_step': registrationStep,
      'user_type': userType,
      'user': user?.toJson(),
      'challenge_token': challengeToken,
      'expires_in': expiresIn,
      'cooldown_active': cooldownActive,
      'otp_purpose': otpPurpose,
      'otp_channel': otpChannel,
      '2fa': twofa,
    };
  }

  @override
  String toString() {
    return 'LoginResponse(accessToken: $accessToken, tokenType: $tokenType, registrationStep: $registrationStep, userType: $userType, user: $user)';
  }
}
