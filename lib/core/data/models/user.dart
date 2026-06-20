class User {
  final String? uuid;
  final String? firstname;
  final String? lastname;
  final String? middlename;
  final DateTime? dateOfBirth;
  final String? email;
  final String? phoneNumber;
  final String? countryCode;
  final String? imageUrl;
  final String? stateOfOrigin;
  final String? nationality;
  final String? religion;
  final String? maritalStatus;
  final String? appTheme;
  final String? onboardingType;
  final String? nin;
  final String? bvn;
  final String? rsaPin;
  final String? residenceAddress;
  final DateTime? emailVerifiedAt;
  final DateTime? transactionPinSetAt;
  final bool? biometricEnabled;
  final int? twoFa;
  final DateTime? twoFaExpiresAt;
  final String? userStatus;
  final int? canLogin;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? picture;
  final String? gender;

  User({
    this.uuid,
    this.firstname,
    this.lastname,
    this.middlename,
    this.dateOfBirth,
    this.email,
    this.phoneNumber,
    this.countryCode,
    this.imageUrl,
    this.stateOfOrigin,
    this.nationality,
    this.religion,
    this.maritalStatus,
    this.appTheme,
    this.onboardingType,
    this.nin,
    this.bvn,
    this.rsaPin,
    this.emailVerifiedAt,
    this.transactionPinSetAt,
    this.biometricEnabled,
    this.residenceAddress,
    this.twoFa,
    this.twoFaExpiresAt,
    this.userStatus,
    this.canLogin,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.picture,
    this.gender,
  });

  String get fullName => [
    firstname,
    middlename,
    lastname,
  ].where((e) => e != null && e.isNotEmpty).join(' ');

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      middlename: json['middlename'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.tryParse(json['date_of_birth'])
          : null,
      email: json['email'],
      phoneNumber: json['phone_number'],
      countryCode: json['country_code'],
      imageUrl: json['image_url'],
      stateOfOrigin: json['state_of_origin'],
      nationality: json['nationality'],
      religion: json['religion'],
      maritalStatus: json['marital_status'],
      appTheme: json['app_theme'],
      onboardingType: json['onboarding_type'],
      nin: json['nin'],
      bvn: json['bvn'],
      rsaPin: json['rsa_pin'],
      residenceAddress: json['residence_address'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      transactionPinSetAt: json['transaction_pin_set_at'] != null
          ? DateTime.tryParse(json['transaction_pin_set_at'])
          : null,
      biometricEnabled: json['biometric_enabled'],
      twoFa: json['2fa'],
      twoFaExpiresAt: json['2fa_expires_at'] != null
          ? DateTime.tryParse(json['2fa_expires_at'])
          : null,
      userStatus: json['user_status'],
      canLogin: json['can_login'],
      role: json['role'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      picture: json['picture'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'firstname': firstname,
      'lastname': lastname,
      'middlename': middlename,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'email': email,
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'image_url': imageUrl,
      'state_of_origin': stateOfOrigin,
      'nationality': nationality,
      'religion': religion,
      'marital_status': maritalStatus,
      'app_theme': appTheme,
      'onboarding_type': onboardingType,
      'nin': nin,
      'bvn': bvn,
      'rsa_pin': rsaPin,
      'residence_address': residenceAddress,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'transaction_pin_set_at': transactionPinSetAt?.toIso8601String(),
      'biometric_enabled': biometricEnabled,
      '2fa': twoFa,
      '2fa_expires_at': twoFaExpiresAt?.toIso8601String(),
      'user_status': userStatus,
      'can_login': canLogin,
      'role': role,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'picture': picture,
      'gender': gender,
    };
  }
}
