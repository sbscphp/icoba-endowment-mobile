import 'package:icoba_endowment_mobile/core/data/models/user.dart';

class RecentDonor {
  final String? transactionUuid;
  final String? amount;
  final String? currency;
  final DateTime? paidAt;
  final String? tierLabel;
  final String? displayName;
  final Tier? tier;

  const RecentDonor({
    this.transactionUuid,
    this.amount,
    this.currency,
    this.paidAt,
    this.tierLabel,
    this.displayName,
    this.tier,
  });

  factory RecentDonor.fromJson(Map<String, dynamic> json) {
    return RecentDonor(
      transactionUuid: json['transaction_uuid'] as String?,
      amount: json['amount'] as String?,
      currency: json['currency'] as String?,
      paidAt: json['paid_at'] != null
          ? DateTime.tryParse(json['paid_at'] as String)
          : null,
      tierLabel: json['tier_label'] as String?,
      displayName: json['display_name'] as String?,
      tier: json['tier'] != null ? Tier.fromJson(json['tier']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_uuid': transactionUuid,
      'amount': amount,
      'currency': currency,
      'paid_at': paidAt?.toIso8601String(),
      'tier_label': tierLabel,
      'display_name': displayName,
    };
  }

  RecentDonor copyWith({
    String? transactionUuid,
    String? amount,
    String? currency,
    DateTime? paidAt,
    String? tierLabel,
    String? displayName,
  }) {
    return RecentDonor(
      transactionUuid: transactionUuid ?? this.transactionUuid,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paidAt: paidAt ?? this.paidAt,
      tierLabel: tierLabel ?? this.tierLabel,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  String toString() {
    return 'RecentDonor(transactionUuid: $transactionUuid, amount: $amount, currency: $currency, displayName: $displayName, tierLabel: $tierLabel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecentDonor && other.transactionUuid == transactionUuid;
  }

  @override
  int get hashCode => transactionUuid.hashCode;
}
