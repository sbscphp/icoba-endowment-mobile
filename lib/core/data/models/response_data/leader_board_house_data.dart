num? _parseNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  return num.tryParse(value.toString());
}

class LeaderBoardHouseData {
  final int? rank;
  final LeaderBoardHouse? house;
  final num? totalAmount;
  final num? amountInNgn;
  final String? currency;
  final num? fulfilledAmount;
  final num? fulfilledAmountNgn;

  LeaderBoardHouseData({
    this.rank,
    this.house,
    this.totalAmount,
    this.amountInNgn,
    this.currency,
    this.fulfilledAmount,
    this.fulfilledAmountNgn,
  });

  factory LeaderBoardHouseData.fromJson(Map<String, dynamic> json) {
    return LeaderBoardHouseData(
      rank: json['rank'] as int?,
      house: json['house'] == null
          ? null
          : LeaderBoardHouse.fromJson(json['house'] as Map<String, dynamic>),
      totalAmount: _parseNum(json['total_amount']),
      amountInNgn: _parseNum(json['amount_in_ngn']),
      currency: json['currency'] as String?,
      fulfilledAmount: _parseNum(json['fulfilled_amount']),
      fulfilledAmountNgn: _parseNum(json['fulfilled_amount_ngn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'house': house?.toJson(),
      'total_amount': totalAmount,
      'amount_in_ngn': amountInNgn,
      'currency': currency,
      'fulfilled_amount': fulfilledAmount,
      'fulfilled_amount_ngn': fulfilledAmountNgn,
    };
  }

  LeaderBoardHouseData copyWith({
    int? rank,
    LeaderBoardHouse? house,
    num? totalAmount,
    num? amountInNgn,
    String? currency,
    num? fulfilledAmount,
    num? fulfilledAmountNgn,
  }) {
    return LeaderBoardHouseData(
      rank: rank ?? this.rank,
      house: house ?? this.house,
      totalAmount: totalAmount ?? this.totalAmount,
      amountInNgn: amountInNgn ?? this.amountInNgn,
      currency: currency ?? this.currency,
      fulfilledAmount: fulfilledAmount ?? this.fulfilledAmount,
      fulfilledAmountNgn: fulfilledAmountNgn ?? this.fulfilledAmountNgn,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeaderBoardHouseData &&
        other.rank == rank &&
        other.house == house &&
        other.totalAmount == totalAmount &&
        other.amountInNgn == amountInNgn &&
        other.currency == currency &&
        other.fulfilledAmount == fulfilledAmount &&
        other.fulfilledAmountNgn == fulfilledAmountNgn;
  }

  @override
  int get hashCode {
    return Object.hash(
      rank,
      house,
      totalAmount,
      amountInNgn,
      currency,
      fulfilledAmount,
      fulfilledAmountNgn,
    );
  }

  @override
  String toString() {
    return 'LeaderBoardHouseData(rank: $rank, house: $house, '
        'totalAmount: $totalAmount, amountInNgn: $amountInNgn, '
        'currency: $currency, fulfilledAmount: $fulfilledAmount, '
        'fulfilledAmountNgn: $fulfilledAmountNgn)';
  }
}

class LeaderBoardHouse {
  final String? value;
  final String? label;
  final int? totalMembers;
  final int? contributingDonors;
  final int? registeredMembers;

  LeaderBoardHouse({
    this.value,
    this.label,
    this.totalMembers,
    this.contributingDonors,
    this.registeredMembers,
  });

  factory LeaderBoardHouse.fromJson(Map<String, dynamic> json) {
    return LeaderBoardHouse(
      value: json['value'] as String?,
      label: json['label'] as String?,
      totalMembers: json['total_members'] as int?,
      contributingDonors: json['contributing_donors'] as int?,
      registeredMembers: json['registered_members'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
      'total_members': totalMembers,
      'contributing_donors': contributingDonors,
      'registered_members': registeredMembers,
    };
  }

  LeaderBoardHouse copyWith({
    String? value,
    String? label,
    int? totalMembers,
    int? contributingDonors,
    int? registeredMembers,
  }) {
    return LeaderBoardHouse(
      value: value ?? this.value,
      label: label ?? this.label,
      totalMembers: totalMembers ?? this.totalMembers,
      contributingDonors: contributingDonors ?? this.contributingDonors,
      registeredMembers: registeredMembers ?? this.registeredMembers,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeaderBoardHouse &&
        other.value == value &&
        other.label == label &&
        other.totalMembers == totalMembers &&
        other.contributingDonors == contributingDonors &&
        other.registeredMembers == registeredMembers;
  }

  @override
  int get hashCode => Object.hash(
        value,
        label,
        totalMembers,
        contributingDonors,
        registeredMembers,
      );

  @override
  String toString() {
    return 'LeaderBoardHouse(value: $value, label: $label, '
        'totalMembers: $totalMembers, contributingDonors: $contributingDonors, '
        'registeredMembers: $registeredMembers)';
  }
}