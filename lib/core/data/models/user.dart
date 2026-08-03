import 'package:icoba_endowment_mobile/core/data/models/response_data/corporate_category.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/donation_category.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/sets_category.dart';

class User {
  final String? uuid;
  final String? firstname;
  final String? lastname;
  final String? middlename;
  final String? email;
  final DateTime? emailVerifiedAt;
  final String? registrationStep;
  final String? phoneNumber;
  final String? countryCode;
  bool? twoFa;
  final bool? emailNotificationsEnabled;
  final bool? pushNotificationsEnabled;
  final bool? biometricsEnabled;
  final int? isActive;
  final int? canLogin;
  final String? lastLoginAt;
  final String? lastActiveAt;
  final UserRole? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Donor? donor;
  final Tier? donationTier;
  final Tier? pledgeTier;

   User({
    this.uuid,
    this.firstname,
    this.lastname,
    this.middlename,
    this.email,
    this.emailVerifiedAt,
    this.registrationStep,
    this.phoneNumber,
    this.countryCode,
    this.twoFa,
    this.emailNotificationsEnabled,
    this.pushNotificationsEnabled,
    this.biometricsEnabled,
    this.isActive,
    this.canLogin,
    this.lastLoginAt,
    this.lastActiveAt,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.donor,
    this.donationTier,
    this.pledgeTier,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      middlename: json['middlename'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      registrationStep: json['registration_step'],
      phoneNumber: json['phone_number'],
      countryCode: json['country_code'],
      twoFa: json['2fa'],
      emailNotificationsEnabled: json['email_notifications_enabled'],
      pushNotificationsEnabled: json['push_notifications_enabled'],
      biometricsEnabled: json['biometrics_enabled'],
      isActive: json['is_active'],
      canLogin: json['can_login'],
      lastLoginAt: json['last_login_at'],
      lastActiveAt: json['last_active_at'],
      role: json['role'] != null
          ? UserRole.fromJson(json['role'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      donor: json['donor'] != null
          ? Donor.fromJson(json['donor'] as Map<String, dynamic>)
          : null,
      donationTier: json['donation_tier'] != null
          ? Tier.fromJson(json['donation_tier'])
          : null,
      pledgeTier: json['pledge_tier'] != null
          ? Tier.fromJson(json['pledge_tier'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'firstname': firstname,
      'lastname': lastname,
      'middlename': middlename,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'registration_step': registrationStep,
      'phone_number': phoneNumber,
      'country_code': countryCode,
      '2fa': twoFa,
      'is_active': isActive,
      'can_login': canLogin,
      'last_login_at': lastLoginAt,
      'last_active_at': lastActiveAt,
      'role': role?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'donor': donor?.toJson(),
      'donation_tier': donationTier?.toJson(),
      'pledge_tier': pledgeTier?.toJson(),
    };
  }

  String get fullName => '${firstname ?? ''} ${lastname ?? ''}'.trim();

  @override
  String toString() {
    return 'LoginUser(uuid: $uuid, firstname: $firstname, lastname: $lastname, email: $email, registrationStep: $registrationStep)';
  }
}

class UserRole {
  final String? name;

  const UserRole({this.name});

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(name: json['name']);
  }

  Map<String, dynamic> toJson() => {'name': name};

  @override
  String toString() => 'UserRole(name: $name)';
}

class Donor {
  final DonationCategory? type;
  final String? organizationName;
  final String? alumniIdentifier;
  final String? rcNumber;
  final String? tin;
  final SetsCategory? set;
  final CorporateCategory? corporateCategory;

  const Donor({
    this.type,
    this.organizationName,
    this.alumniIdentifier,
    this.rcNumber,
    this.tin,
    this.set,
    this.corporateCategory,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      type: json['type'] != null
          ? DonationCategory.fromJson(json['type'])
          : null,
      organizationName: json['organization_name'],
      alumniIdentifier: json['alumni_identifier'],
      rcNumber: json['rc_number'],
      tin: json['tin'],
      set: json['set'] != null ? SetsCategory.fromJson(json['set']) : null,
      corporateCategory: json['corporate_category'] != null
          ? CorporateCategory.fromJson(json['corporate_category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type?.toJson(),
      'organization_name': organizationName,
      'alumni_identifier': alumniIdentifier,
      "rc_number": rcNumber,
      "tin": tin,
      'set': set?.toJson(),
      'corporate_category': corporateCategory?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Donor(type: $type, organizationName: $organizationName, alumniIdentifier: $alumniIdentifier)';
  }
}

class Tier {
  final String? name;
  final String? tierBadgeUrl;
  final String? amountNgn;
  final String? slug;
  final String? baseColor;


  const Tier({this.name, this.tierBadgeUrl, this.amountNgn,this.slug,this.baseColor});

  factory Tier.fromJson(Map<String, dynamic> json) {
    return Tier(
      name: json['name'],
      tierBadgeUrl: json['tier_badge_url'],
      amountNgn: json['amount_ngn']?.toString(),
      slug: json['slug'],
      baseColor: json['base_color']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tier_badge_url': tierBadgeUrl,
      'amount_ngn': amountNgn,
    };
  }

  @override
  String toString() =>
      'Tier(name: $name, tierBadgeUrl: $tierBadgeUrl, amountNgn: $amountNgn)';
}
