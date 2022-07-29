# myfatoorah_pay

My Fatoorah Pay

## Getting Started

## Installation
<table>
  <tr>
    <td>Payment methods</td>
     <td>Card inputs</td>
     <td>result Success</td>
     <td>result Failed</td>
  </tr>

  <tr>
    <td><img src="https://raw.githubusercontent.com/mohmmedHossam/myfatoorah_pay/master/1.png"></td>
    <td><img src="https://raw.githubusercontent.com/mohmmedHossam/myfatoorah_pay/master/2.png"></td>
    <td><img src="https://raw.githubusercontent.com/mohmmedHossam/myfatoorah_pay/master/3.png"></td>
    <td><img src="https://raw.githubusercontent.com/mohmmedHossam/myfatoorah_pay/master/4.png"></td>
  </tr>
 </table>

```dart
# add this to your pubspec.yaml
myfatoorah_pay: any
```

## Config

### Ios

### add this to your `Info.plist`

```xml
<key>io.flutter.embedded_views_preview</key>
<true/>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### if this url is not using ssl you have to use clear text traffic . put this value in your `manifest` for android

### and allow arbitrary loads in your `Info.plist` for ios

### Android

```xml
 <application android:usesCleartextTraffic="true">

  </application>
```


## Dialog Usage

```dart
import 'package:myfatoorah_pay/myfatoorah_pay.dart';
import 'dart:developer';

 var response = await MyFatoorahPay.startPayment(
                context: context,
                request: MyfatoorahRequest.test(
                  currencyIso: Country.SaudiArabia,
                  invoiceAmount: 100,
                  language: ApiLanguage.English,
                  token: "Your token here",
                ),
              );
              

### Notes
- you can find demo information here https://myfatoorah.readme.io/docs/demo-information

