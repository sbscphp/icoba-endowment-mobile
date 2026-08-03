class TransactionData {
  final String? transactionUuid;
  final String? transactionId;
  final String? amount;
  final String? currency;
  final String? amountInNaira;
  final String? status;
  final String? paidAt;
  final bool? isAnonymous;
  final dynamic applicationType;
  final dynamic pledgeUuid;
  final LinkedCampaign? linkedCampaign;
  final String? donorName;
  final String? donorEmail;
  final String? donorPhone;
  final String? displayName;

  const TransactionData({
    this.transactionUuid,
    this.transactionId,
    this.amount,
    this.currency,
    this.amountInNaira,
    this.status,
    this.paidAt,
    this.isAnonymous,
    this.applicationType,
    this.pledgeUuid,
    this.linkedCampaign,
    this.donorName,
    this.donorEmail,
    this.donorPhone,
    this.displayName,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      transactionUuid: json['transaction_uuid'],
      transactionId: json['transaction_id'],
      amount: json['amount'],
      currency: json['currency'],
      amountInNaira: json['amount_in_naira'],
      status: json['status'],
      paidAt: json['paid_at'],
      isAnonymous: json['is_anonymous'],
      applicationType: json['application_type'],
      pledgeUuid: json['pledge_uuid'],
      linkedCampaign: json['linked_campaign'] != null
          ? LinkedCampaign.fromJson(json['linked_campaign'])
          : null,
      donorName: json['donor_name'],
      donorEmail: json['donor_email'],
      donorPhone: json['donor_phone'],
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_uuid': transactionUuid,
      'transaction_id': transactionId,
      'amount': amount,
      'currency': currency,
      'amount_in_naira': amountInNaira,
      'status': status,
      'paid_at': paidAt,
      'is_anonymous': isAnonymous,
      'application_type': applicationType,
      'pledge_uuid': pledgeUuid,
      'linked_campaign': linkedCampaign?.toJson(),
      'donor_name': donorName,
      'donor_email': donorEmail,
      'donor_phone': donorPhone,
      'display_name': displayName,
    };
  }

  TransactionData copyWith({
    String? transactionUuid,
    String? transactionId,
    String? amount,
    String? currency,
    String? amountInNaira,
    String? status,
    String? paidAt,
    bool? isAnonymous,
    dynamic applicationType,
    dynamic pledgeUuid,
    LinkedCampaign? linkedCampaign,
    String? donorName,
    String? donorEmail,
    String? donorPhone,
    String? displayName,
  }) {
    return TransactionData(
      transactionUuid: transactionUuid ?? this.transactionUuid,
      transactionId: transactionId ?? this.transactionId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      amountInNaira: amountInNaira ?? this.amountInNaira,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      applicationType: applicationType ?? this.applicationType,
      pledgeUuid: pledgeUuid ?? this.pledgeUuid,
      linkedCampaign: linkedCampaign ?? this.linkedCampaign,
      donorName: donorName ?? this.donorName,
      donorEmail: donorEmail ?? this.donorEmail,
      donorPhone: donorPhone ?? this.donorPhone,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  String toString() {
    return 'TransactionData(transactionUuid: $transactionUuid, transactionId: $transactionId, amount: $amount, currency: $currency, status: $status, donorName: $donorName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionData && other.transactionUuid == transactionUuid;
  }

  @override
  int get hashCode => transactionUuid.hashCode;
}

class LinkedCampaign {
  final String? name;

  const LinkedCampaign({this.name});

  factory LinkedCampaign.fromJson(Map<String, dynamic> json) {
    return LinkedCampaign(name: json['name']);
  }

  Map<String, dynamic> toJson() => {'name': name};

  @override
  String toString() => 'LinkedCampaign(name: $name)';
}
