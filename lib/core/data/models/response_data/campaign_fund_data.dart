class CampaignFundData {
  final String? campaignUuid;
  final String? currency;
  final String? campaignName;
  final String? raised;
  final String? target;
  final dynamic percent;

  const CampaignFundData({
    this.campaignUuid,
    this.currency,
    this.campaignName,
    this.raised,
    this.target,
    this.percent,
  });

  factory CampaignFundData.fromJson(Map<String, dynamic> json) {
    return CampaignFundData(
      campaignUuid: json['campaign_uuid'],
      currency: json['currency'],
      campaignName: json['campaign_name'],
      raised: json['raised'],
      target: json['target'],
      percent: json['percent']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campaign_uuid': campaignUuid,
      'currency': currency,
      'campaign_name': campaignName,
      'raised': raised,
      'target': target,
      'percent': percent,
    };
  }


  @override
  String toString() {
    return 'CampaignFundData(campaignUuid: $campaignUuid, currency: $currency, campaignName: $campaignName, raised: $raised, target: $target, percent: $percent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CampaignFundData && other.campaignUuid == campaignUuid;
  }

  @override
  int get hashCode => campaignUuid.hashCode;
}