
import 'dart:convert';

GetPaymentsStatus getPaymentsStatusFromJson(String str) => GetPaymentsStatus.fromJson(json.decode(str));

String getPaymentsStatusToJson(GetPaymentsStatus data) => json.encode(data.toJson());

class GetPaymentsStatus {
  bool isSuccess;
  String message;
  dynamic validationErrors;
  Data data;

  GetPaymentsStatus({
    required this.isSuccess,
    required this.message,
    required this.validationErrors,
    required this.data,
  });

  factory GetPaymentsStatus.fromJson(Map<String, dynamic> json) => GetPaymentsStatus(
    isSuccess: json["IsSuccess"],
    message: json["Message"],
    validationErrors: json["ValidationErrors"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "IsSuccess": isSuccess,
    "Message": message,
    "ValidationErrors": validationErrors,
    "Data": data.toJson(),
  };
}

class Data {
  int invoiceId;
  String invoiceStatus;
  String invoiceReference;
  dynamic customerReference;
  DateTime createdDate;
  String expiryDate;
  String expiryTime;
  double invoiceValue;
  dynamic comments;
  String customerName;
  String customerMobile;
  dynamic customerEmail;
  dynamic userDefinedField;
  String invoiceDisplayValue;
  double dueDeposit;
  String depositStatus;
  List<dynamic> invoiceItems;
  List<InvoiceTransaction> invoiceTransactions;
  List<dynamic> suppliers;

  Data({
    required this.invoiceId,
    required this.invoiceStatus,
    required this.invoiceReference,
    required this.customerReference,
    required this.createdDate,
    required this.expiryDate,
    required this.expiryTime,
    required this.invoiceValue,
    required this.comments,
    required this.customerName,
    required this.customerMobile,
    required this.customerEmail,
    required this.userDefinedField,
    required this.invoiceDisplayValue,
    required this.dueDeposit,
    required this.depositStatus,
    required this.invoiceItems,
    required this.invoiceTransactions,
    required this.suppliers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    invoiceId: json["InvoiceId"],
    invoiceStatus: json["InvoiceStatus"],
    invoiceReference: json["InvoiceReference"],
    customerReference: json["CustomerReference"],
    createdDate: DateTime.parse(json["CreatedDate"]),
    expiryDate: json["ExpiryDate"],
    expiryTime: json["ExpiryTime"],
    invoiceValue: json["InvoiceValue"]?.toDouble(),
    comments: json["Comments"],
    customerName: json["CustomerName"],
    customerMobile: json["CustomerMobile"],
    customerEmail: json["CustomerEmail"],
    userDefinedField: json["UserDefinedField"],
    invoiceDisplayValue: json["InvoiceDisplayValue"],
    dueDeposit: json["DueDeposit"]?.toDouble(),
    depositStatus: json["DepositStatus"],
    invoiceItems: List<dynamic>.from(json["InvoiceItems"].map((x) => x)),
    invoiceTransactions: List<InvoiceTransaction>.from(json["InvoiceTransactions"].map((x) => InvoiceTransaction.fromJson(x))),
    suppliers: List<dynamic>.from(json["Suppliers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "InvoiceId": invoiceId,
    "InvoiceStatus": invoiceStatus,
    "InvoiceReference": invoiceReference,
    "CustomerReference": customerReference,
    "CreatedDate": createdDate.toIso8601String(),
    "ExpiryDate": expiryDate,
    "ExpiryTime": expiryTime,
    "InvoiceValue": invoiceValue,
    "Comments": comments,
    "CustomerName": customerName,
    "CustomerMobile": customerMobile,
    "CustomerEmail": customerEmail,
    "UserDefinedField": userDefinedField,
    "InvoiceDisplayValue": invoiceDisplayValue,
    "DueDeposit": dueDeposit,
    "DepositStatus": depositStatus,
    "InvoiceItems": List<dynamic>.from(invoiceItems.map((x) => x)),
    "InvoiceTransactions": List<dynamic>.from(invoiceTransactions.map((x) => x.toJson())),
    "Suppliers": List<dynamic>.from(suppliers.map((x) => x)),
  };
}

class InvoiceTransaction {
  DateTime transactionDate;
  String paymentGateway;
  String referenceId;
  String trackId;
  String transactionId;
  String paymentId;
  String authorizationId;
  String transactionStatus;
  String transationValue;
  String customerServiceCharge;
  String totalServiceCharge;
  String dueValue;
  String paidCurrency;
  String paidCurrencyValue;
  String vatAmount;
  String ipAddress;
  String country;
  String currency;
  dynamic error;
  String cardNumber;
  String errorCode;

  InvoiceTransaction({
    required this.transactionDate,
    required this.paymentGateway,
    required this.referenceId,
    required this.trackId,
    required this.transactionId,
    required this.paymentId,
    required this.authorizationId,
    required this.transactionStatus,
    required this.transationValue,
    required this.customerServiceCharge,
    required this.totalServiceCharge,
    required this.dueValue,
    required this.paidCurrency,
    required this.paidCurrencyValue,
    required this.vatAmount,
    required this.ipAddress,
    required this.country,
    required this.currency,
    required this.error,
    required this.cardNumber,
    required this.errorCode,
  });

  factory InvoiceTransaction.fromJson(Map<String, dynamic> json) => InvoiceTransaction(
    transactionDate: DateTime.parse(json["TransactionDate"]),
    paymentGateway: json["PaymentGateway"],
    referenceId: json["ReferenceId"],
    trackId: json["TrackId"],
    transactionId: json["TransactionId"],
    paymentId: json["PaymentId"],
    authorizationId: json["AuthorizationId"],
    transactionStatus: json["TransactionStatus"],
    transationValue: json["TransationValue"],
    customerServiceCharge: json["CustomerServiceCharge"],
    totalServiceCharge: json["TotalServiceCharge"],
    dueValue: json["DueValue"],
    paidCurrency: json["PaidCurrency"],
    paidCurrencyValue: json["PaidCurrencyValue"],
    vatAmount: json["VatAmount"],
    ipAddress: json["IpAddress"],
    country: json["Country"],
    currency: json["Currency"],
    error: json["Error"],
    cardNumber: json["CardNumber"],
    errorCode: json["ErrorCode"],
  );

  Map<String, dynamic> toJson() => {
    "TransactionDate": transactionDate.toIso8601String(),
    "PaymentGateway": paymentGateway,
    "ReferenceId": referenceId,
    "TrackId": trackId,
    "TransactionId": transactionId,
    "PaymentId": paymentId,
    "AuthorizationId": authorizationId,
    "TransactionStatus": transactionStatus,
    "TransationValue": transationValue,
    "CustomerServiceCharge": customerServiceCharge,
    "TotalServiceCharge": totalServiceCharge,
    "DueValue": dueValue,
    "PaidCurrency": paidCurrency,
    "PaidCurrencyValue": paidCurrencyValue,
    "VatAmount": vatAmount,
    "IpAddress": ipAddress,
    "Country": country,
    "Currency": currency,
    "Error": error,
    "CardNumber": cardNumber,
    "ErrorCode": errorCode,
  };
}
