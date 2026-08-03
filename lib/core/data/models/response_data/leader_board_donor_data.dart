class LeaderBoardDonorData {
  final int? rank;
  final String? totalAmount;
  final String? fulfilledAmount;
  final String? amountInNgn;
  final String? fulfilledAmountNgn;
  final String? currency;
  final LeaderBoardTier? tier;
  final DateTime? lastDonationAt;
  final String? displayName;
  final LeaderBoardDonorType? donorType;
  final String? info;

  const LeaderBoardDonorData({
    this.rank,
    this.totalAmount,
    this.fulfilledAmount,
    this.amountInNgn,
    this.fulfilledAmountNgn,
    this.currency,
    this.tier,
    this.lastDonationAt,
    this.displayName,
    this.donorType,
    this.info,
  });

  factory LeaderBoardDonorData.fromJson(Map<String, dynamic> json) {
    return LeaderBoardDonorData(
      rank: json['rank'],
      totalAmount: json['total_amount'],
      fulfilledAmount: json['fulfilled_amount'],
      amountInNgn: json['amount_in_ngn'],
      fulfilledAmountNgn: json['fulfilled_amount_ngn'],
      currency: json['currency'],
      tier: json['tier'] != null
          ? LeaderBoardTier.fromJson(json['tier'])
          : null,
      lastDonationAt: json['last_donation_at'] != null
          ? DateTime.tryParse(json['last_donation_at'])
          : null,
      displayName: json['display_name'],
      donorType: json['donor_type'] != null
          ? LeaderBoardDonorType.fromJson(
              json['donor_type'])
          : null,
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'total_amount': totalAmount,
      'fulfilled_amount': fulfilledAmount,
      'amount_in_ngn': amountInNgn,
      'fulfilled_amount_ngn': fulfilledAmountNgn,
      'currency': currency,
      'tier': tier?.toJson(),
      'last_donation_at': lastDonationAt?.toIso8601String(),
      'display_name': displayName,
      'donor_type': donorType?.toJson(),
      'info': info,
    };
  }

  LeaderBoardDonorData copyWith({
    int? rank,
    String? totalAmount,
    String? fulfilledAmount,
    String? amountInNgn,
    String? fulfilledAmountNgn,
    String? currency,
    LeaderBoardTier? tier,
    DateTime? lastDonationAt,
    String? displayName,
    LeaderBoardDonorType? donorType,
    String? info,
  }) {
    return LeaderBoardDonorData(
      rank: rank ?? this.rank,
      totalAmount: totalAmount ?? this.totalAmount,
      fulfilledAmount: fulfilledAmount ?? this.fulfilledAmount,
      amountInNgn: amountInNgn ?? this.amountInNgn,
      fulfilledAmountNgn: fulfilledAmountNgn ?? this.fulfilledAmountNgn,
      currency: currency ?? this.currency,
      tier: tier ?? this.tier,
      lastDonationAt: lastDonationAt ?? this.lastDonationAt,
      displayName: displayName ?? this.displayName,
      donorType: donorType ?? this.donorType,
      info: info ?? this.info,
    );
  }

  @override
  String toString() {
    return 'LeaderBoardDonorData(rank: $rank, displayName: $displayName, totalAmount: $totalAmount, currency: $currency, tier: $tier)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeaderBoardDonorData && other.rank == rank;
  }

  @override
  int get hashCode => rank.hashCode;
}

class LeaderBoardTier {
  final String? slug;
  final String? name;
  final String? baseColor;

  const LeaderBoardTier({
    this.slug,
    this.name,
    this.baseColor,
  });

  factory LeaderBoardTier.fromJson(Map<String, dynamic> json) {
    return LeaderBoardTier(
      slug: json['slug'],
      name: json['name'],
      baseColor: json['base_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'base_color': baseColor,
    };
  }

  @override
  String toString() =>
      'LeaderBoardTier(slug: $slug, name: $name, baseColor: $baseColor)';
}

class LeaderBoardDonorType {
  final String? slug;
  final String? label;

  const LeaderBoardDonorType({
    this.slug,
    this.label,
  });

  factory LeaderBoardDonorType.fromJson(Map<String, dynamic> json) {
    return LeaderBoardDonorType(
      slug: json['slug'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'label': label,
    };
  }

  @override
  String toString() =>
      'LeaderBoardDonorType(slug: $slug, label: $label)';
}