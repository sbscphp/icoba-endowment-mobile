class CampaignData {
  final String? campaignId;
  final String? publicCampaignCode;
  final String? name;
  final String? shortDescription;
  final String? coverImage;
  final List<String>? categories;
  final String? baseCurrency;
  final List<String>? availableDonationCurrencies;
  final String? targetAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final bool? isDefault;
  final bool? allowAnonymousDonation;
  final String? amountRealizedNgn;
  final String? donationPledgeNgn;
  final dynamic fundProgressPercent;
  final String? longDescription;
  final List<String>? galleryImages;
  final bool? appliesToAllGraduationSets;
  final List<CampaignGraduationSet>? graduationSets;

  const CampaignData({
    this.campaignId,
    this.publicCampaignCode,
    this.name,
    this.shortDescription,
    this.coverImage,
    this.categories,
    this.baseCurrency,
    this.availableDonationCurrencies,
    this.targetAmount,
    this.startDate,
    this.endDate,
    this.status,
    this.isDefault,
    this.allowAnonymousDonation,
    this.amountRealizedNgn,
    this.donationPledgeNgn,
    this.fundProgressPercent,
    this.longDescription,
    this.galleryImages,
    this.appliesToAllGraduationSets,
    this.graduationSets,
  });

  factory CampaignData.fromJson(Map<String, dynamic> json) {
    return CampaignData(
      campaignId: json['campaign_id'],
      publicCampaignCode: json['public_campaign_code'],
      name: json['name'],
      shortDescription: json['short_description'],
      coverImage: json['cover_image'],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'].map((e) => e.toString()))
          : null,
      baseCurrency: json['base_currency'],
      availableDonationCurrencies: json['available_donation_currencies'] != null
          ? List<String>.from(
              json['available_donation_currencies'].map((e) => e.toString()))
          : null,
      targetAmount: json['target_amount'],
      startDate: json['start_date'] != null
          ? DateTime.tryParse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.tryParse(json['end_date'])
          : null,
      status: json['status'],
      isDefault: json['is_default'],
      allowAnonymousDonation: json['allow_anonymous_donation'],
      amountRealizedNgn: json['amount_realized_ngn'],
      donationPledgeNgn: json['donation_pledge_ngn'],
      fundProgressPercent: json['fund_progress_percent'],
      longDescription: json['long_description'],
      galleryImages: json['gallery_images'] != null
          ? List<String>.from(
              (json['gallery_images'] as List)
                  .where((e) => e != null)
                  .map((e) => e.toString()),
            )
          : null,
      appliesToAllGraduationSets:
          json['applies_to_all_graduation_sets'],
      graduationSets: json['graduation_sets'] != null
          ? List.from(json['graduation_sets'])
              .map((e) =>
                  CampaignGraduationSet.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campaign_id': campaignId,
      'public_campaign_code': publicCampaignCode,
      'name': name,
      'short_description': shortDescription,
      'cover_image': coverImage,
      'categories': categories,
      'base_currency': baseCurrency,
      'available_donation_currencies': availableDonationCurrencies,
      'target_amount': targetAmount,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'is_default': isDefault,
      'allow_anonymous_donation': allowAnonymousDonation,
      'amount_realized_ngn': amountRealizedNgn,
      'donation_pledge_ngn': donationPledgeNgn,
      'fund_progress_percent': fundProgressPercent,
      'long_description': longDescription,
      'gallery_images': galleryImages,
      'applies_to_all_graduation_sets': appliesToAllGraduationSets,
      'graduation_sets': graduationSets?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CampaignData(campaignId: $campaignId, name: $name, status: $status, isDefault: $isDefault, fundProgressPercent: $fundProgressPercent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CampaignData && other.campaignId == campaignId;
  }

  @override
  int get hashCode => campaignId.hashCode;
}

class CampaignGraduationSet {
  final String? graduationSetId;
  final String? name;
  final String? setNumber;

  const CampaignGraduationSet({
    this.graduationSetId,
    this.name,
    this.setNumber,
  });

  factory CampaignGraduationSet.fromJson(Map<String, dynamic> json) {
    return CampaignGraduationSet(
      graduationSetId: json['graduation_set_id'],
      name: json['name'],
      setNumber: json['set_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'graduation_set_id': graduationSetId,
      'name': name,
      'set_number': setNumber,
    };
  }


  @override
  String toString() =>
      'CampaignGraduationSet(graduationSetId: $graduationSetId, name: $name, setNumber: $setNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CampaignGraduationSet &&
        other.graduationSetId == graduationSetId;
  }

  @override
  int get hashCode => graduationSetId.hashCode;
}