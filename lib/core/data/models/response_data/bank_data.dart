
class BankAccountData {
  final String? bankName;
  final String? accountName;
  final List<BankData>? accounts;

  const BankAccountData({
    this.bankName,
    this.accountName,
    this.accounts,
  });

  factory BankAccountData.fromJson(Map<String, dynamic> json) {
    return BankAccountData(
      bankName: json['bank_name'] as String?,
      accountName: json['account_name'] as String?,
      accounts: json['accounts'] != null
          ? (json['accounts'] as List)
              .map((e) => BankData.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bank_name': bankName,
      'account_name': accountName,
      'accounts': accounts?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'BankAccountData(bankName: $bankName, accountName: $accountName, accounts: $accounts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BankAccountData && other.bankName == bankName;
  }

  @override
  int get hashCode => bankName.hashCode;
}

class BankData {
  final String? accountKey;
  final String? currency;
  final String? currencySymbol;
  final String? accountNumber;

  const BankData({
    this.accountKey,
    this.currency,
    this.currencySymbol,
    this.accountNumber,
  });

  factory BankData.fromJson(Map<String, dynamic> json) {
    return BankData(
      accountKey: json['account_key'] as String?,
      currency: json['currency'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
      accountNumber: json['account_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_key': accountKey,
      'currency': currency,
      'currency_symbol': currencySymbol,
      'account_number': accountNumber,
    };
  }

  @override
  String toString() {
    return 'BankData(accountKey: $accountKey, currency: $currency, currencySymbol: $currencySymbol, accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BankData && other.accountKey == accountKey;
  }

  @override
  int get hashCode => accountKey.hashCode;
}