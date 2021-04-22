library fil_codec.address;

import 'ffi.dart';

String paddingZero(String hexStr) {
  return (hexStr.length.isOdd ? '0' : '') + hexStr;
}

String publicKeyToAddress(String hexX, String hexY, {bool testnet = false}) {
  final plainKey = paddingZero(hexX) + paddingZero(hexY);
  return FilCodec.publicKeyToAddress(plainKey, testnet: testnet);
}
