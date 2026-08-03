import 'bank_data.dart';

class InitiateTransferResponse {
  final String? transactionUuid;
  final String? amount;
  final String? currency;
  final String? amountInNaira;
  final String? status;
  final dynamic paidAt;
  final bool? isAnonymous;
  final String? bankTransferReference;
  final String? paidIntoAccountNumber;
  final dynamic awaitingBankVerificationAt;
  final BankData? targetAccount;
  final String? instructions;

  const InitiateTransferResponse({
    this.transactionUuid,
    this.amount,
    this.currency,
    this.amountInNaira,
    this.status,
    this.paidAt,
    this.isAnonymous,
    this.bankTransferReference,
    this.paidIntoAccountNumber,
    this.awaitingBankVerificationAt,
    this.targetAccount,
    this.instructions,
  });

  factory InitiateTransferResponse.fromJson(Map<String, dynamic> json) {
    return InitiateTransferResponse(
      transactionUuid: json['transaction_uuid'] as String?,
      amount: json['amount'] as String?,
      currency: json['currency'] as String?,
      amountInNaira: json['amount_in_naira'] as String?,
      status: json['status'] as String?,
      paidAt: json['paid_at'],
      isAnonymous: json['is_anonymous'] as bool?,
      bankTransferReference: json['bank_transfer_reference'] as String?,
      paidIntoAccountNumber: json['paid_into_account_number'] as String?,
      awaitingBankVerificationAt: json['awaiting_bank_verification_at'],
      targetAccount: json['target_account'] != null
          ? BankData.fromJson(json['target_account'] as Map<String, dynamic>)
          : null,
      instructions: json['instructions'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_uuid': transactionUuid,
      'amount': amount,
      'currency': currency,
      'amount_in_naira': amountInNaira,
      'status': status,
      'paid_at': paidAt,
      'is_anonymous': isAnonymous,
      'bank_transfer_reference': bankTransferReference,
      'paid_into_account_number': paidIntoAccountNumber,
      'awaiting_bank_verification_at': awaitingBankVerificationAt,
      'target_account': targetAccount?.toJson(),
      'instructions': instructions,
    };
  }

  bool get isPending => status == 'pending';
  bool get isPaid => status == 'paid';

  @override
  String toString() {
    return 'InitiateTransferResponse(transactionUuid: $transactionUuid, amount: $amount, currency: $currency, status: $status, bankTransferReference: $bankTransferReference)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InitiateTransferResponse &&
        other.transactionUuid == transactionUuid;
  }

  @override
  int get hashCode => transactionUuid.hashCode;
}