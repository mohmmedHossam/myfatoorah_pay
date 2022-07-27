part of myfatoorah_pay;
class _InitiatePaymentResponse
    extends _MyFatoorahResponse<_InitiatePaymentResponseData> {
  _InitiatePaymentResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
  @override
  _InitiatePaymentResponseData mapData(Map<String, dynamic> json) {
    return _InitiatePaymentResponseData.fromJson(json);
  }
}

class _InitiatePaymentResponseData {
  late List<PaymentMethod> paymentMethods;
  _InitiatePaymentResponseData.fromJson(Map<String, dynamic> json) {
    paymentMethods = [];
    if (json['PaymentMethods'] != null || json['paymentMethods'] != null) {
      paymentMethods = <PaymentMethod>[];
      (json['PaymentMethods'] ?? json['paymentMethods']).forEach((v) {
        paymentMethods.add(new PaymentMethod.fromJson(v));
      });
    }
  }
}
