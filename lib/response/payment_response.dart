part of myfatoorah_pay;

class PaymentResponse {
  final PaymentStatus status;
  final String? paymentId;
  final String? url;

  bool get isSuccess => status == PaymentStatus.Success;
  bool get isError => status == PaymentStatus.Error;
  bool get isNothing => status == PaymentStatus.None;
  PaymentResponse(this.status, {this.url, this.paymentId});

  @override
  String toString() {
    return "Status: $status     PaymentId: $paymentId";
  }
}
