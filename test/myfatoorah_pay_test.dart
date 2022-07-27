import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myfatoorah_pay/myfatoorah_pay.dart';

void main() {
  const MethodChannel channel = MethodChannel('my_fatoorah_smz');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await MyFatoorah.platformVersion, '42');
  });
}
