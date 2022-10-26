import 'package:flutter_test/flutter_test.dart';
import 'package:fil_codec/fil_codec.dart';
import 'package:fil_codec/fil_codec_platform_interface.dart';
import 'package:fil_codec/fil_codec_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFilCodecPlatform
    with MockPlatformInterfaceMixin
    implements FilCodecPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {

  test('test txDecode txEncode', () async {
    final de = FilCodec.txDecode("8a005501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c62855011eaf1c8a4bbfeeb0870b1745b1f57503470b71160144000186a01961a84200014200010040");
    final en = FilCodec.txEncode(de);
    expect(en, '8a005501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c62855011eaf1c8a4bbfeeb0870b1745b1f57503470b71160144000186a01961a84200014200010040');

  });

  test('test publicKeyToAddress', () async{

    final address = FilCodec.publicKeyToAddress("048bfab3a70675389cf61836a09d2dd7a61163905d88c0d507ed18a1b94e7119f3e36646cd711337f373b91814fe7258a58e2206273620f71254928389930abd70");
    expect(address, 'f1j5klxt6zktifpibt7jlafmdxkfe4fwjhm6yqjhq');

  });

  test('test txDigest', () async{

    final d = FilCodec.txDigest("885501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c6285501b882619d46558f3d9e316d11b48dcf211327025a0144000186a0430009c4430061a80040");
    expect(d, '5a51287d2e5401b75014da0f050c8db96fe0bacdad75fce964520ca063b697e1');
  });
}
