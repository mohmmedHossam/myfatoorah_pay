part of myfatoorah_pay;

///The request that will be send to may fatoorah api
///
///first thing we do is to fetch payment methods as described in their docs
///
///[https://myfatoorah.readme.io/docs/api-initiate-payment]
///
///Then we make the execute payment as described here
///
///[https://myfatoorah.readme.io/docs/api-execute-payment]
///
///if the request success we navigate to anew page that contains webview redirected to the returned url
///
/// if you need to pop immediately after payment done pass `finishAfterCallback` equal `true`
///
/// # Note
///
/// In case you are using the `invoiceItem`, the value sent in `invoiceAmount` should be equal to the total
/// sum value of the item `unitPrice` multiplied by the item Quantity ,
///
/// for example of you are having 1 item with price of 5 KD and quantity 3,
/// so the value of the `invoiceAmount` should be 15

class MyfatoorahRequest {
  final String url;

  /// url to use instead of my fatoorah url
  /// Must not be null if you run on the web
  /// if you set initiatePaymentUrl or executePayment you can set token equal to null
  /// and make these urls set the token from backend for security reasons
  /// This url must return the base response of my fatoorah without any edits
  final String? initiatePaymentUrl;

  /// url to use instead of my fatoorah url
  /// Must not be null if you run on the web
  /// if you set initiatePaymentUrl or executePayment you can set token equal to null
  /// and make these urls set the token from backend for security reasons
  /// This url must return the base response of my fatoorah without any edits
  final String? executePaymentUrl;

  /// authorization token without bearer
  /// ### Leave it null to use test value
  final String token;

  ///Language of  displaying payment methods
  final ApiLanguage language;

  /// The amount you are seeking to charge the customer and accepts decimal value e.g. 2.500
  final double invoiceAmount;

  /// Callback that will be called after payment success note that this url preferred to return html content with
  /// success message
  ///
  /// The api will call this url with a query string `paymentId` so the back end developer can validate
  /// the payment  by following this docs
  ///
  /// [https://myfatoorah.readme.io/docs/api-payment-enquiry]
  ///
  /// # Note
  /// if this url is not using ssl you have to use clear text traffic . put this value in your `manifest`  for android
  /// and allow arbitrary loads in your `Info.plist` for ios
  ///
  /// ### Android
  /// ```xml
  ///  <application
  ///   ...
  ///   android:usesCleartextTraffic="true"
  ///   ...>
  ///   ...
  ///   </application>
  /// ```
  ///  ### Ios
  ///  ```xml
  ///  <key>NSAppTransportSecurity</key>
  ///  <dict>
  ///      <key>NSAllowsArbitraryLoads</key>
  ///      <true/>
  ///  </dict>
  /// ```


  /// The currency code that you need to charge your customer through
  final Country currencyIso;

  /// Customer mobile number country code
  final String? mobileCountryCode;

  /// Customer mobile number
  final String? customerMobile;
  final String? customerEmail;
  final String? customerName;

  ///Refers to the order or transaction ID in your own system and you can use for payment inquiry as well
  final String? customerReference;

  ///Your customer civil ID that you can associate with the transaction if needed
  final String? customerCivilId;

  ///A custom field that you may use as additional information to be stored with the transaction
  final String? userDefinedField;

  final CustomerAddress? customerAddress;

  ///The date you want the payment to be expired, if not passed the default is considered from the account profile in the portal
  final DateTime? expiryDate;

  ///Array of InvoiceItemModel objects, optional
  final List<InvoiceItem>? invoiceItems;

  /// 1 for DHL
  /// 2 for ARAMEX
  final int? shippingMethod;

  /// This parameter is only mandatory if you are creating a Shipping invoice.
  final ShippingConsignee? shippingConsignee;

  ///This parameter is only mandatory if you are using the Multi-Vendors feature.

  final List<Supplier>? suppliers;
  final RecurringModel? recurringModel;

  @Deprecated("Use `MyfatoorahRequest.test` or MyfatoorahRequest.live")
  MyfatoorahRequest({
    required this.token,
    required this.language,
    required this.invoiceAmount,
    required this.currencyIso,
    this.shippingConsignee,
    this.mobileCountryCode,
    this.initiatePaymentUrl,
    this.executePaymentUrl,
    this.customerMobile,
    this.url = "https://api.myfatoorah.com",
    this.customerName,
    this.customerEmail,
    this.customerReference,
    this.customerCivilId,
    this.userDefinedField,
    this.customerAddress,
    this.expiryDate,
    this.suppliers,
    this.shippingMethod,
    this.invoiceItems,
    this.recurringModel,
  });

  MyfatoorahRequest.live({
    required this.token,
    required this.language,
    required this.invoiceAmount,
    required this.currencyIso,
    this.shippingConsignee,
    this.mobileCountryCode,
    this.initiatePaymentUrl,
    this.executePaymentUrl,
    this.customerMobile,
    this.customerName,
    this.customerEmail,
    this.customerReference,
    this.customerCivilId,
    this.userDefinedField,
    this.customerAddress,
    this.expiryDate,
    this.suppliers,
    this.shippingMethod,
    this.invoiceItems,
    this.recurringModel,
  }) : url = "https://api.myfatoorah.com";
  MyfatoorahRequest.test({
    required this.token,
    required this.language,
    required this.invoiceAmount,
    required this.currencyIso,
    this.shippingConsignee,
    this.mobileCountryCode,
    this.initiatePaymentUrl,
    this.executePaymentUrl,
    this.customerMobile,
    this.customerName,
    this.customerEmail,
    this.customerReference,
    this.customerCivilId,
    this.userDefinedField,
    this.customerAddress,
    this.expiryDate,
    this.suppliers,
    this.shippingMethod,
    this.invoiceItems,
    this.recurringModel,
  }) : url = "https://apitest.myfatoorah.com";
  Map<String, dynamic> executePaymentRequest(int paymentMethod) {
    var data = {
      "PaymentMethodId": paymentMethod,
      "CustomerName": customerName,
      "DisplayCurrencyIso": _currencies[currencyIso],
      "MobileCountryCode": mobileCountryCode,
      "CustomerMobile": customerMobile,
      "CustomerEmail": customerEmail,
      "InvoiceValue": invoiceAmount,
      "Language": _languages[language],
      "CustomerReference": customerReference,
      "CustomerCivilId": customerCivilId,
      "UserDefinedField": userDefinedField,
      "CustomerAddress": customerAddress?.toJson(),
      "ExpiryDate": expiryDate?.toUtc().toIso8601String(),
      "InvoiceItems": invoiceItems?.map<Map<String, dynamic>>((e) {
        return e.toJson();
      }).toList(),
      "ShippingMethod": shippingMethod,
      "ShippingConsignee": shippingConsignee?.toJson(),
      "Suppliers": suppliers?.map<Map<String, dynamic>>((e) {
        return e.toJson();
      }).toList(),
      "RecurringModel": recurringModel?.toJson(),
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }

  Map<String, dynamic> initiatePaymentRequest() {
    return {
      "currencyIso": _currencies[currencyIso],
      "invoiceAmount": invoiceAmount,
      "language": _languages[language],
    };
  }
}
