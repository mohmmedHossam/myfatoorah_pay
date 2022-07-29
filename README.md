# myfatoorah_pay

My Fatoorah Payment

## Getting Started

## Installation
<table>
  <tr>
    <td>Payment methods</td>
     <td>Card inputs</td>
     <td>Acs Emulator</td>
     <td>result</td>
  </tr>

  <tr>
    <td><img src="https://raw.githubusercontent.com/mo-ah-dawood/my_fatoorah/master/screen_1.png"></td>
    <td><img src="https://raw.githubusercontent.com/mo-ah-dawood/my_fatoorah/master/screen_2.png"></td>
    <td><img width="210" src="https://user-images.githubusercontent.com/29352955/164155489-681b62c0-9cff-4ff6-90e8-c9a11db9ffa6.png"></td>
    <td><img src="https://raw.githubusercontent.com/mo-ah-dawood/my_fatoorah/master/screen_3.png"></td>
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

