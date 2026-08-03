class LeaderBoardSetData {
  final int? rank;
  final LeaderBoardSet? set;
  final String? totalAmount;
  final String? amountInNgn;
  final String? currency;
  final String? fulfilledAmount;
  final String? fulfilledAmountNgn;

  const LeaderBoardSetData({
    this.rank,
    this.set,
    this.totalAmount,
    this.amountInNgn,
    this.currency,
    this.fulfilledAmount,
    this.fulfilledAmountNgn,
  });

  factory LeaderBoardSetData.fromJson(Map<String, dynamic> json) {
    return LeaderBoardSetData(
      rank: json['rank'],
      set: json['set'] != null ? LeaderBoardSet.fromJson(json['set']) : null,
      totalAmount: json['total_amount'],
      amountInNgn: json['amount_in_ngn'],
      currency: json['currency'],
      fulfilledAmount: json['fulfilled_amount'],
      fulfilledAmountNgn: json['fulfilled_amount_ngn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'set': set?.toJson(),
      'total_amount': totalAmount,
      'amount_in_ngn': amountInNgn,
      'currency': currency,
      'fulfilled_amount': fulfilledAmount,
      'fulfilled_amount_ngn': fulfilledAmountNgn,
    };
  }

  LeaderBoardSetData copyWith({
    int? rank,
    LeaderBoardSet? set,
    String? totalAmount,
    String? amountInNgn,
    String? currency,
    String? fulfilledAmount,
    String? fulfilledAmountNgn,
  }) {
    return LeaderBoardSetData(
      rank: rank ?? this.rank,
      set: set ?? this.set,
      totalAmount: totalAmount ?? this.totalAmount,
      amountInNgn: amountInNgn ?? this.amountInNgn,
      currency: currency ?? this.currency,
      fulfilledAmount: fulfilledAmount ?? this.fulfilledAmount,
      fulfilledAmountNgn: fulfilledAmountNgn ?? this.fulfilledAmountNgn,
    );
  }

  @override
  String toString() {
    return 'LeaderBoardSetData(rank: $rank, set: $set, totalAmount: $totalAmount, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeaderBoardSetData && other.rank == rank;
  }

  @override
  int get hashCode => rank.hashCode;
}

class LeaderBoardSet {
  final String? graduationSetUuid;
  final String? setName;
  final String? setNumber;
  final int? totalMembers;
  final int? contributingDonors;
  final int? registeredMembers;

  const LeaderBoardSet({
    this.graduationSetUuid,
    this.setName,
    this.setNumber,
    this.totalMembers,
    this.contributingDonors,
    this.registeredMembers,
  });

  factory LeaderBoardSet.fromJson(Map<String, dynamic> json) {
    return LeaderBoardSet(
      graduationSetUuid: json['graduation_set_uuid'],
      setName: json['set_name'],
      setNumber: json['set_number'],
      totalMembers: json['total_members'],
      contributingDonors: json['contributing_donors'],
      registeredMembers: json['registered_members'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'graduation_set_uuid': graduationSetUuid,
      'set_name': setName,
      'set_number': setNumber,
      'total_members': totalMembers,
      'contributing_donors': contributingDonors,
      'registered_members': registeredMembers,
    };
  }

  @override
  String toString() {
    return 'LeaderBoardSet(graduationSetUuid: $graduationSetUuid, setName: $setName, setNumber: $setNumber, totalMembers: $totalMembers, contributingDonors: $contributingDonors, registeredMembers: $registeredMembers)';
  }
}
