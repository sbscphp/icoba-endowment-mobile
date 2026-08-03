import '../../enum/signup_type.dart';

class DonationCategory {
  final String? uuid;
  final String? slug;
  final String? label;
  final String? description;

  const DonationCategory({
    required this.uuid,
    required this.slug,
    required this.label,
    required this.description,
  });

  factory DonationCategory.fromJson(Map<String, dynamic> json) {
    return DonationCategory(
      uuid: json['uuid'],
      slug: json['slug'],
      label: json['label'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'slug': slug,
      'label': label,
      'description': description,
    };
  }

  DonationCategory copyWith({
    String? uuid,
    String? slug,
    String? label,
    String? description,
  }) {
    return DonationCategory(
      uuid: uuid ?? this.uuid,
      slug: slug ?? this.slug,
      label: label ?? this.label,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'DonationCategory(uuid: $uuid, slug: $slug, label: $label, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DonationCategory && other.uuid == uuid;
  }

  @override
  int get hashCode => uuid.hashCode;

  SignupType get signupType {
    switch (slug) {
      case "icoba_alumni":
        return SignupType.alumni;
      case "corporate_donor":
        return SignupType.corporateDonor;
      case "friends_of_icoba":
        return SignupType.friendOfIcoba;
      case "relatives_of_icoba":
        return SignupType.familiesOfIcoba;
      default:
        return SignupType.none;
    }
  }
}
