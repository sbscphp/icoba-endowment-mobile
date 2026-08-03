class CreatePledgeResponse {
  final String? pledgeUuid;
  final PledgeCampaign? campaign;
  final String? committedAmount;
  final String? committedAmountNgn;
  final String? exchangeRateToNaira;
  final String? currency;
  final String? paymentPlanType;
  final int? installmentCount;
  final String? status;
  final bool? isPaused;
  final dynamic pausedAt;
  final dynamic fulfilledAmount;
  final dynamic remainingAmount;
  final PledgeSchedule? schedule;
  final bool? isAnonymous;
  final DateTime? createdAt;
  final PledgeUser? user;

  const CreatePledgeResponse({
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

  factory CreatePledgeResponse.fromJson(Map<String, dynamic> json) {
    return CreatePledgeResponse(
      pledgeUuid: json['pledge_uuid'] as String?,
      campaign: json['campaign'] != null
          ? PledgeCampaign.fromJson(json['campaign'] as Map<String, dynamic>)
          : null,
      committedAmount: json['committed_amount'] as String?,
      committedAmountNgn: json['committed_amount_ngn'] as String?,
      exchangeRateToNaira: json['exchange_rate_to_naira'] as String?,
      currency: json['currency'] as String?,
      paymentPlanType: json['payment_plan_type'] as String?,
      installmentCount: json['installment_count'] as int?,
      status: json['status'] as String?,
      isPaused: json['is_paused'] as bool?,
      pausedAt: json['paused_at'],
      fulfilledAmount: json['fulfilled_amount'],
      remainingAmount: json['remaining_amount'],
      schedule: json['schedule'] != null
          ? PledgeSchedule.fromJson(json['schedule'] as Map<String, dynamic>)
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


  @override
  String toString() {
    return 'CreatePledgeResponse(pledgeUuid: $pledgeUuid, committedAmount: $committedAmount, currency: $currency, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreatePledgeResponse && other.pledgeUuid == pledgeUuid;
  }

  @override
  int get hashCode => pledgeUuid.hashCode;
}

class PledgeCampaign {
  final String? uuid;
  final String? name;

  const PledgeCampaign({this.uuid, this.name});

  factory PledgeCampaign.fromJson(Map<String, dynamic> json) {
    return PledgeCampaign(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'uuid': uuid, 'name': name};

  @override
  String toString() => 'PledgeCampaign(uuid: $uuid, name: $name)';
}

class PledgeSchedule {
  final int? installmentCount;
  final String? paymentPlanType;
  final String? paymentPreference;
  final PledgeScheduleConfig? scheduleConfig;
  final String? amountPerInstallment;
  final List<PledgeScheduleItem>? items;

  const PledgeSchedule({
    this.installmentCount,
    this.paymentPlanType,
    this.paymentPreference,
    this.scheduleConfig,
    this.amountPerInstallment,
    this.items,
  });

  factory PledgeSchedule.fromJson(Map<String, dynamic> json) {
    return PledgeSchedule(
      installmentCount: json['installment_count'] as int?,
      paymentPlanType: json['payment_plan_type'] as String?,
      paymentPreference: json['payment_preference'] as String?,
      scheduleConfig: json['schedule_config'] != null
          ? PledgeScheduleConfig.fromJson(
              json['schedule_config'] as Map<String, dynamic>)
          : null,
      amountPerInstallment: json['amount_per_installment'] as String?,
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
      'schedule_config': scheduleConfig?.toJson(),
      'amount_per_installment': amountPerInstallment,
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'PledgeSchedule(installmentCount: $installmentCount, paymentPlanType: $paymentPlanType, amountPerInstallment: $amountPerInstallment)';
  }
}

class PledgeScheduleConfig {
  final String? frequency;
  final int? interval;

  const PledgeScheduleConfig({this.frequency, this.interval});

  factory PledgeScheduleConfig.fromJson(Map<String, dynamic> json) {
    return PledgeScheduleConfig(
      frequency: json['frequency'] as String?,
      interval: json['interval'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'frequency': frequency,
        'interval': interval,
      };

  @override
  String toString() =>
      'PledgeScheduleConfig(frequency: $frequency, interval: $interval)';
}

class PledgeScheduleItem {
  final String? id;
  final int? sequence;
  final DateTime? dueDate;
  final String? pledgedAmount;
  final String? pledgedAmountNgn;
  final String? paidAmount;
  final String? paidAmountNgn;
  final String? remainingAmount;
  final String? remainingAmountNgn;
  final String? currency;
  final String? status;

  const PledgeScheduleItem({
    this.id,
    this.sequence,
    this.dueDate,
    this.pledgedAmount,
    this.pledgedAmountNgn,
    this.paidAmount,
    this.paidAmountNgn,
    this.remainingAmount,
    this.remainingAmountNgn,
    this.currency,
    this.status,
  });

  factory PledgeScheduleItem.fromJson(Map<String, dynamic> json) {
    return PledgeScheduleItem(
      id: json['id'] as String?,
      sequence: json['sequence'] as int?,
      dueDate: json['due_date'] != null
          ? DateTime.tryParse(json['due_date'] as String)
          : null,
      pledgedAmount: json['pledged_amount'] as String?,
      pledgedAmountNgn: json['pledged_amount_ngn'] as String?,
      paidAmount: json['paid_amount'] as String?,
      paidAmountNgn: json['paid_amount_ngn'] as String?,
      remainingAmount: json['remaining_amount'] as String?,
      remainingAmountNgn: json['remaining_amount_ngn'] as String?,
      currency: json['currency'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sequence': sequence,
      'due_date': dueDate?.toIso8601String(),
      'pledged_amount': pledgedAmount,
      'pledged_amount_ngn': pledgedAmountNgn,
      'paid_amount': paidAmount,
      'paid_amount_ngn': paidAmountNgn,
      'remaining_amount': remainingAmount,
      'remaining_amount_ngn': remainingAmountNgn,
      'currency': currency,
      'status': status,
    };
  }

  bool get isPending => status == 'pending';
  bool get isPaid => status == 'paid';

  @override
  String toString() {
    return 'PledgeScheduleItem(id: $id, sequence: $sequence, dueDate: $dueDate, pledgedAmount: $pledgedAmount, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PledgeScheduleItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class PledgeUser {
  final String? uuid;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;

  const PledgeUser({
    this.uuid,
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
  });

  factory PledgeUser.fromJson(Map<String, dynamic> json) {
    return PledgeUser(
      uuid: json['uuid'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  String get fullName => '${firstname ?? ''} ${lastname ?? ''}'.trim();

  @override
  String toString() =>
      'PledgeUser(uuid: $uuid, firstname: $firstname, lastname: $lastname, email: $email)';
}