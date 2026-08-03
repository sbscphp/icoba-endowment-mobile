class ChallengeTokenModel {
  final String? challengeToken;
  final int? expiresIn;
  final bool? cooldownActive;
  final bool? twofa;
  final String? otpPurpose;
  final String? otpChannel;
  final String? registrationStep;
  final String? resetToken;

  const ChallengeTokenModel({
    this.challengeToken,
    this.expiresIn,
    this.cooldownActive,
    this.otpPurpose,
    this.otpChannel,
    this.registrationStep,
    this.twofa,
    this.resetToken,
  });

  factory ChallengeTokenModel.fromJson(Map<String, dynamic> json) {
    return ChallengeTokenModel(
      challengeToken: json['challenge_token'],
      expiresIn: json['expires_in'],
      cooldownActive: json['cooldown_active'],
      otpPurpose: json['otp_purpose'],
      otpChannel: json['otp_channel'],
      registrationStep: json['registration_step'],
      twofa: json['2fa'],
      resetToken: json['reset_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'challenge_token': challengeToken,
      'expires_in': expiresIn,
      'cooldown_active': cooldownActive,
      'otp_purpose': otpPurpose,
      'otp_channel': otpChannel,
      'registration_step': registrationStep,
      '2fa': twofa,
      'reset_token': resetToken,
    };
  }

  @override
  String toString() {
    return 'ChallengeTokenModel(challengeToken: $challengeToken, expiresIn: $expiresIn, cooldownActive: $cooldownActive, otpPurpose: $otpPurpose, otpChannel: $otpChannel, registrationStep: $registrationStep)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChallengeTokenModel &&
        other.challengeToken == challengeToken;
  }

  @override
  int get hashCode => challengeToken.hashCode;
}
