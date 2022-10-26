import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fil_codec/fil_codec_method_channel.dart';

void main() {
  MethodChannelFilCodec platform = MethodChannelFilCodec();
  const MethodChannel channel = MethodChannel('fil_codec');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
