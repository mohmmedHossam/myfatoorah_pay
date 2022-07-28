# myfatoorah_pay

My Fatoorah Payment

## Getting Started

## Installation

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
import 'package:my_fatoorah/my_fatoorah.dart';
import 'dart:developer';

 var response = await MyFatoorah.startPayment(
                context: context,
                request: MyfatoorahRequest.test(
                  currencyIso: Country.SaudiArabia,
                  invoiceAmount: 100,
                  language: ApiLanguage.Arabic,
                  token: "Your token here",
                ),
              );
              

### Notes
- you can find demo information here https://myfatoorah.readme.io/docs/demo-information

