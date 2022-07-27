# my_fatoorah

My Fatoorah Payment
# Screenshots in Test mode
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

# Screenshots in Live(Release) mode


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
              log(response.paymentId.toString());
              
See the example for more details
```
Example
```dart
 var response = await MyFatoorah.startPayment(
                context: context,
                request: MyfatoorahRequest.test(
                  currencyIso: Country.SaudiArabia,
                  successUrl: 'https://www.facebook.com',
                  errorUrl: 'https://www.google.com/',
                  invoiceAmount: 100,
                  language: ApiLanguage.English,
                  token:
                      'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
                ),
              );
              log(response.paymentId.toString());

```                                    
Result:
// <td><img width="210" src="https://user-images.githubusercontent.com/29352955/164888146-fc3a8c84-8f7a-4512-9a5a-fe148add1506.png"></td>


### Notes

- you can find demo information here https://myfatoorah.readme.io/docs/demo-information
- after version 3.0.2 you can use `MyfatoorahRequest.test` or `MyfatoorahRequest.live`
- After redirected to the success url You will get a paymentId which will help your backend to track the payment status with my fatoorah
