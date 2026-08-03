import 'package:icoba_endowment_mobile/core/data/models/response_data/create_pledge_response.dart';

class PledgeData {
  final String? pledgeUuid;
  final PledgeDataCampaign? campaign;
  final String? committedAmount;
  final String? committedAmountNgn;
  final String? exchangeRateToNaira;
  final String? currency;
  final String? paymentPlanType;
  final dynamic installmentCount;
  final String? status;
  final bool? isPaused;
  final dynamic pausedAt;
  final String? fulfilledAmount;
  final String? remainingAmount;
  final PledgeDataSchedule? schedule;
  final bool? isAnonymous;
  final DateTime? createdAt;
  final PledgeUser? user;

  const PledgeData({
    this.pledgeUuid,
    this.campaign,
    this.committedAmount,
    this.committedAmountNgn,
    this.exchangeRateToNaira,
    this.currency,
    this.paymentPlanType,
    this.installmentCount,
    this.status,
    this.isPaused,
    this.pausedAt,
    this.fulfilledAmount,
    this.remainingAmount,
    this.schedule,
    this.isAnonymous,
    this.createdAt,
    this.user,
  });

  factory PledgeData.fromJson(Map<String, dynamic> json) {
    return PledgeData(
      pledgeUuid: json['pledge_uuid'] as String?,
      campaign: json['campaign'] != null
          ? PledgeDataCampaign.fromJson(
              json['campaign'] as Map<String, dynamic>)
          : null,
      committedAmount: json['committed_amount'] as String?,
      committedAmountNgn: json['committed_amount_ngn'] as String?,
      exchangeRateToNaira: json['exchange_rate_to_naira'] as String?,
      currency: json['currency'] as String?,
      paymentPlanType: json['payment_plan_type'] as String?,
      installmentCount: json['installment_count'],
      status: json['status'] as String?,
      isPaused: json['is_paused'] as bool?,
      pausedAt: json['paused_at'],
      fulfilledAmount: json['fulfilled_amount'] as String?,
      remainingAmount: json['remaining_amount'] as String?,
      schedule: json['schedule'] != null
          ? PledgeDataSchedule.fromJson(
              json['schedule'] as Map<String, dynamic>)
          : null,
      isAnonymous: json['is_anonymous'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      user: json['user'] != null
          ? PledgeUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pledge_uuid': pledgeUuid,
      'campaign': campaign?.toJson(),
      'committed_amount': committedAmount,
      'committed_amount_ngn': committedAmountNgn,
      'exchange_rate_to_naira': exchangeRateToNaira,
      'currency': currency,
      'payment_plan_type': paymentPlanType,
      'installment_count': installmentCount,
      'status': status,
      'is_paused': isPaused,
      'paused_at': pausedAt,
      'fulfilled_amount': fulfilledAmount,
      'remaining_amount': remainingAmount,
      'schedule': schedule?.toJson(),
      'is_anonymous': isAnonymous,
      'created_at': createdAt?.toIso8601String(),
      'user': user?.toJson(),
    };
  }

  bool get isActive => status == 'active';
  bool get isOneTimeFuture => paymentPlanType == 'one_time_future';

  PledgeData copyWith({
    String? pledgeUuid,
    PledgeDataCampaign? campaign,
    String? committedAmount,
    String? committedAmountNgn,
    String? exchangeRateToNaira,
    String? currency,
    String? paymentPlanType,
    dynamic installmentCount,
    String? status,
    bool? isPaused,
    dynamic pausedAt,
    String? fulfilledAmount,
    String? remainingAmount,
    PledgeDataSchedule? schedule,
    bool? isAnonymous,
    DateTime? createdAt,
    PledgeUser? user,
  }) {
    return PledgeData(
      pledgeUuid: pledgeUuid ?? this.pledgeUuid,
      campaign: campaign ?? this.campaign,
      committedAmount: committedAmount ?? this.committedAmount,
      committedAmountNgn: committedAmountNgn ?? this.committedAmountNgn,
      exchangeRateToNaira: exchangeRateToNaira ?? this.exchangeRateToNaira,
      currency: currency ?? this.currency,
      paymentPlanType: paymentPlanType ?? this.paymentPlanType,
      installmentCount: installmentCount ?? this.installmentCount,
      status: status ?? this.status,
      isPaused: isPaused ?? this.isPaused,
      pausedAt: pausedAt ?? this.pausedAt,
      fulfilledAmount: fulfilledAmount ?? this.fulfilledAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      schedule: schedule ?? this.schedule,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'PledgeData(pledgeUuid: $pledgeUuid, committedAmount: $committedAmount, currency: $currency, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PledgeData && other.pledgeUuid == pledgeUuid;
  }

  @override
  int get hashCode => pledgeUuid.hashCode;
}

class PledgeDataCampaign {
  final String? uuid;
  final String? name;
  final String? status;
  final bool? allowAnonymousDonation;

  const PledgeDataCampaign({
    this.uuid,
    this.name,
    this.status,
    this.allowAnonymousDonation,
  });

  factory PledgeDataCampaign.fromJson(Map<String, dynamic> json) {
    return PledgeDataCampaign(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      allowAnonymousDonation: json['allow_anonymous_donation'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'status': status,
      'allow_anonymous_donation': allowAnonymousDonation,
    };
  }

  @override
  String toString() =>
      'PledgeDataCampaign(uuid: $uuid, name: $name, status: $status)';
}

class PledgeDataSchedule {
  final dynamic installmentCount;
  final String? paymentPlanType;
  final String? paymentPreference;
  final List<PledgeScheduleItem>? items;

  const PledgeDataSchedule({
    this.installmentCount,
    this.paymentPlanType,
    this.paymentPreference,
    this.items,
  });

  factory PledgeDataSchedule.fromJson(Map<String, dynamic> json) {
    return PledgeDataSchedule(
      installmentCount: json['installment_count'],
      paymentPlanType: json['payment_plan_type'] as String?,
      paymentPreference: json['payment_preference'] as String?,
      items: json['items'] != null
          ? (json['items'] as List)
              .map((e) =>
                  PledgeScheduleItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'installment_count': installmentCount,
      'payment_plan_type': paymentPlanType,
      'payment_preference': paymentPreference,
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() =>
      'PledgeDataSchedule(paymentPlanType: $paymentPlanType, paymentPreference: $paymentPreference, itemCount: ${items?.length})';
}