import 'package:icoba_endowment_mobile/core/data/models/country.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/corporate_category.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/donation_category.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/info_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/sets_category.dart';

class OnboardingDropdownData {
  final List<DonationCategory>? donorTypes;
  final List<CorporateCategory>? corporateCategories;
  final List<SetsCategory>? sets;
  final List<Country>? countries;
  final List<InfoData>? houses;
  final List<InfoData>? icobaWivesType;
  final List<InfoData>? donationPurposes;

  OnboardingDropdownData({
    this.donorTypes,
    this.corporateCategories,
    this.sets,
    this.countries,
    this.houses,
    this.icobaWivesType,
    this.donationPurposes,
  });

  factory OnboardingDropdownData.fromJson(Map<String, dynamic> json) {
    return OnboardingDropdownData(
      donorTypes: List.from(
        json['donor_types'],
      ).map((e) => DonationCategory.fromJson(e)).toList(),
      corporateCategories: List.from(
        json['corporate_categories'],
      ).map((e) => CorporateCategory.fromJson(e)).toList(),
      sets: List.from(
        json['sets'],
      ).map((e) => SetsCategory.fromJson(e)).toList(),
      countries: List.from(
        json['countries'],
      ).map((e) => Country.fromJson(e)).toList(),
      houses: List.from(
        json['houses'],
      ).map((e) => InfoData.fromJson(e)).toList(),
      icobaWivesType: List.from(
        json['icoba_wives_type'],
      ).map((e) => InfoData.fromJson(e)).toList(),
      donationPurposes: List.from(
        json['donation_purposes'],
      ).map((e) => InfoData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'donor_types': donorTypes?.map((e) => e.toJson()).toList(),
    'corporate_categories': corporateCategories
        ?.map((e) => e.toJson())
        .toList(),
    'sets': sets?.map((e) => e.toJson()).toList(),
    'countries': countries?.map((e) => e.toJson()).toList(),
    'houses': houses?.map((e) => e.toJson()).toList(),
    'icoba_wives_type': icobaWivesType?.map((e) => e.toJson()).toList(),
    'donation_purposes': donationPurposes?.map((e) => e.toJson()).toList(),
  };
}
