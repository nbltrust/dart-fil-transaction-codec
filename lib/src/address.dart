library fil_codec.address;

import 'ffi.dart';

String paddingZero(String hexStr) {
  return (hexStr.length.isOdd ? '0' : '') + hexStr;
}

String publicKeyToAddress(String hexX, String hexY, {bool testnet = false}) {
  var plainKey = paddingZero(hexX) + paddingZero(hexY);
  if (plainKey.length == 128) {
    plainKey = '04' + plainKey;
  }

  return FilCodec.publicKeyToAddress(plainKey, testnet: testnet);
}
