class CheckoutResponse {
  final String? paymentGateway;
  final String? checkoutUrl;
  final String? checkoutSessionId;
  final String? transactionUuid;

  const CheckoutResponse({
    this.paymentGateway,
    this.checkoutUrl,
    this.checkoutSessionId,
    this.transactionUuid,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      paymentGateway: json['payment_gateway'],
      checkoutUrl: json['checkout_url'],
      checkoutSessionId: json['checkout_session_id'],
      transactionUuid: json['transaction_uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_gateway': paymentGateway,
      'checkout_url': checkoutUrl,
      'checkout_session_id': checkoutSessionId,
      'transaction_uuid': transactionUuid,
    };
  }

  @override
  String toString() {
    return 'CheckoutResponse(paymentGateway: $paymentGateway, checkoutSessionId: $checkoutSessionId, transactionUuid: $transactionUuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckoutResponse &&
        other.transactionUuid == transactionUuid;
  }

  @override
  int get hashCode => transactionUuid.hashCode;
}