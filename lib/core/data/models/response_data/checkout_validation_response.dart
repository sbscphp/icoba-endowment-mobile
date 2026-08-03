class CheckoutValidationResponse {
  final String? paymentGateway;
  final String? checkoutSessionId;
  final String? paymentStatus;
  final String? sessionStatus;
  final String? syncAction;
  final String? receiptNumber;
  final String? redirectUrl;
  final String? successUrl;
  final String? failedUrl;

  const CheckoutValidationResponse({
    this.paymentGateway,
    this.checkoutSessionId,
    this.paymentStatus,
    this.sessionStatus,
    this.syncAction,
    this.receiptNumber,
    this.redirectUrl,
    this.successUrl,
    this.failedUrl,
  });

  factory CheckoutValidationResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutValidationResponse(
      paymentGateway: json['payment_gateway'] as String?,
      checkoutSessionId: json['checkout_session_id'] as String?,
      paymentStatus: json['payment_status'] as String?,
      sessionStatus: json['session_status'] as String?,
      syncAction: json['sync_action'] as String?,
      receiptNumber: json['receipt_number'] as String?,
      redirectUrl: json['redirect_url'] as String?,
      successUrl: json['success_url'] as String?,
      failedUrl: json['failed_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_gateway': paymentGateway,
      'checkout_session_id': checkoutSessionId,
      'payment_status': paymentStatus,
      'session_status': sessionStatus,
      'sync_action': syncAction,
      'receipt_number': receiptNumber,
      'redirect_url': redirectUrl,
      'success_url': successUrl,
      'failed_url': failedUrl,
    };
  }

  bool get isPaymentSuccessful => paymentStatus == 'paid';
  bool get isSessionComplete => sessionStatus == 'complete';

  @override
  String toString() {
    return 'CheckoutValidationResponse(paymentGateway: $paymentGateway, checkoutSessionId: $checkoutSessionId, paymentStatus: $paymentStatus, sessionStatus: $sessionStatus, receiptNumber: $receiptNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckoutValidationResponse &&
        other.checkoutSessionId == checkoutSessionId;
  }

  @override
  int get hashCode => checkoutSessionId.hashCode;
}