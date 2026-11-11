num? _parseNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  return num.tryParse(value.toString());
}

class QuoteData {
  final num? donationAmount;
  final num? feeAmount;
  final num? totalAmount;
  final String? currency;
  final bool? chargesEnabled;
  final bool? feeApplied;
  final QuoteRule? rule;

  QuoteData({
    this.donationAmount,
    this.feeAmount,
    this.totalAmount,
    this.currency,
    this.chargesEnabled,
    this.feeApplied,
    this.rule,
  });

  factory QuoteData.fromJson(Map<String, dynamic> json) {
    return QuoteData(
      donationAmount: _parseNum(json['donation_amount']),
      feeAmount: _parseNum(json['fee_amount']),
      totalAmount: _parseNum(json['total_amount']),
      currency: json['currency'] as String?,
      chargesEnabled: json['charges_enabled'] as bool?,
      feeApplied: json['fee_applied'] as bool?,
      rule: json['rule'] == null
          ? null
          : QuoteRule.fromJson(json['rule'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'donation_amount': donationAmount,
      'fee_amount': feeAmount,
      'total_amount': totalAmount,
      'currency': currency,
      'charges_enabled': chargesEnabled,
      'fee_applied': feeApplied,
      'rule': rule?.toJson(),
    };
  }

  QuoteData copyWith({
    num? donationAmount,
    num? feeAmount,
    num? totalAmount,
    String? currency,
    bool? chargesEnabled,
    bool? feeApplied,
    QuoteRule? rule,
  }) {
    return QuoteData(
      donationAmount: donationAmount ?? this.donationAmount,
      feeAmount: feeAmount ?? this.feeAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      chargesEnabled: chargesEnabled ?? this.chargesEnabled,
      feeApplied: feeApplied ?? this.feeApplied,
      rule: rule ?? this.rule,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuoteData &&
        other.donationAmount == donationAmount &&
        other.feeAmount == feeAmount &&
        other.totalAmount == totalAmount &&
        other.currency == currency &&
        other.chargesEnabled == chargesEnabled &&
        other.feeApplied == feeApplied &&
        other.rule == rule;
  }

  @override
  int get hashCode {
    return Object.hash(
      donationAmount,
      feeAmount,
      totalAmount,
      currency,
      chargesEnabled,
      feeApplied,
      rule,
    );
  }

  @override
  String toString() {
    return 'QuoteData(donationAmount: $donationAmount, feeAmount: $feeAmount, '
        'totalAmount: $totalAmount, currency: $currency, '
        'chargesEnabled: $chargesEnabled, feeApplied: $feeApplied, '
        'rule: $rule)';
  }
}

class QuoteRule {
  final String? ruleId;
  final String? name;
  final num? percentage;
  final num? fixedAmount;
  final num? capAmount;
  final String? capCurrency;
  final num? effectiveCapAmount;
  final num? capExchangeRate;

  QuoteRule({
    this.ruleId,
    this.name,
    this.percentage,
    this.fixedAmount,
    this.capAmount,
    this.capCurrency,
    this.effectiveCapAmount,
    this.capExchangeRate,
  });

  factory QuoteRule.fromJson(Map<String, dynamic> json) {
    return QuoteRule(
      ruleId: json['rule_id'] as String?,
      name: json['name'] as String?,
      percentage: _parseNum(json['percentage']),
      fixedAmount: _parseNum(json['fixed_amount']),
      capAmount: _parseNum(json['cap_amount']),
      capCurrency: json['cap_currency'] as String?,
      effectiveCapAmount: _parseNum(json['effective_cap_amount']),
      capExchangeRate: _parseNum(json['cap_exchange_rate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rule_id': ruleId,
      'name': name,
      'percentage': percentage,
      'fixed_amount': fixedAmount,
      'cap_amount': capAmount,
      'cap_currency': capCurrency,
      'effective_cap_amount': effectiveCapAmount,
      'cap_exchange_rate': capExchangeRate,
    };
  }

  QuoteRule copyWith({
    String? ruleId,
    String? name,
    num? percentage,
    num? fixedAmount,
    num? capAmount,
    String? capCurrency,
    num? effectiveCapAmount,
    num? capExchangeRate,
  }) {
    return QuoteRule(
      ruleId: ruleId ?? this.ruleId,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
      fixedAmount: fixedAmount ?? this.fixedAmount,
      capAmount: capAmount ?? this.capAmount,
      capCurrency: capCurrency ?? this.capCurrency,
      effectiveCapAmount: effectiveCapAmount ?? this.effectiveCapAmount,
      capExchangeRate: capExchangeRate ?? this.capExchangeRate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuoteRule &&
        other.ruleId == ruleId &&
        other.name == name &&
        other.percentage == percentage &&
        other.fixedAmount == fixedAmount &&
        other.capAmount == capAmount &&
        other.capCurrency == capCurrency &&
        other.effectiveCapAmount == effectiveCapAmount &&
        other.capExchangeRate == capExchangeRate;
  }

  @override
  int get hashCode {
    return Object.hash(
      ruleId,
      name,
      percentage,
      fixedAmount,
      capAmount,
      capCurrency,
      effectiveCapAmount,
      capExchangeRate,
    );
  }

  @override
  String toString() {
    return 'QuoteRule(ruleId: $ruleId, name: $name, percentage: $percentage, '
        'fixedAmount: $fixedAmount, capAmount: $capAmount, '
        'capCurrency: $capCurrency, effectiveCapAmount: $effectiveCapAmount, '
        'capExchangeRate: $capExchangeRate)';
  }
}