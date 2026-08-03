class DashboardSummary {
  final String? totalDonationsAmountNgn;
  final int? donationCount;
  final String? pledgesCommittedAmountNgn;
  final List<PledgeCommittedByCurrency>? pledgesCommittedByCurrency;
  final String? pledgesCommittedAmount;
  final String? currencyPreview;

  const DashboardSummary({
    this.totalDonationsAmountNgn,
    this.donationCount,
    this.pledgesCommittedAmountNgn,
    this.pledgesCommittedByCurrency,
    this.pledgesCommittedAmount,
    this.currencyPreview,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalDonationsAmountNgn: json['total_donations_amount_ngn'],
      donationCount: json['donation_count'],
      pledgesCommittedAmountNgn:
          json['pledges_committed_amount_ngn'],
      pledgesCommittedByCurrency: json['pledges_committed_by_currency'] != null
          ? (json['pledges_committed_by_currency'] as List)
              .map((e) => PledgeCommittedByCurrency.fromJson(
                    e as Map<String, dynamic>,
                  ))
              .toList()
          : null,
      pledgesCommittedAmount: json['pledges_committed_amount'],
      currencyPreview: json['currency_preview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_donations_amount_ngn': totalDonationsAmountNgn,
      'donation_count': donationCount,
      'pledges_committed_amount_ngn': pledgesCommittedAmountNgn,
      'pledges_committed_by_currency':
          pledgesCommittedByCurrency?.map((e) => e.toJson()).toList(),
      'pledges_committed_amount': pledgesCommittedAmount,
      'currency_preview': currencyPreview,
    };
  }

  @override
  String toString() {
    return 'DashboardSummary(totalDonationsAmountNgn: $totalDonationsAmountNgn, donationCount: $donationCount, pledgesCommittedAmountNgn: $pledgesCommittedAmountNgn, currencyPreview: $currencyPreview)';
  }
}

class PledgeCommittedByCurrency {
  final String? currency;
  final String? totalCommitted;
  final String? totalCommittedNgn;

  const PledgeCommittedByCurrency({
    this.currency,
    this.totalCommitted,
    this.totalCommittedNgn,
  });

  factory PledgeCommittedByCurrency.fromJson(Map<String, dynamic> json) {
    return PledgeCommittedByCurrency(
      currency: json['currency'],
      totalCommitted: json['total_committed'],
      totalCommittedNgn: json['total_committed_ngn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'total_committed': totalCommitted,
      'total_committed_ngn': totalCommittedNgn,
    };
  }

  PledgeCommittedByCurrency copyWith({
    String? currency,
    String? totalCommitted,
    String? totalCommittedNgn,
  }) {
    return PledgeCommittedByCurrency(
      currency: currency ?? this.currency,
      totalCommitted: totalCommitted ?? this.totalCommitted,
      totalCommittedNgn: totalCommittedNgn ?? this.totalCommittedNgn,
    );
  }

  @override
  String toString() {
    return 'PledgeCommittedByCurrency(currency: $currency, totalCommitted: $totalCommitted, totalCommittedNgn: $totalCommittedNgn)';
  }
}