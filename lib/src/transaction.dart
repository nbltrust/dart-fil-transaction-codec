library fil_codec.transaction;

import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:quiver/collection.dart';

import 'ffi.dart';

class FilTransaction extends DelegatingMap {
  final delegate = new Map<String, dynamic>();

  FilTransaction(String cbor, bool testnet) {
    final decoded = FilCodec.txDecode(cbor, testnet: testnet);
    Map<String, dynamic> map = json.decode(decoded);

    this.delegate['cbor'] = cbor;
    this.delegate['to'] = map['to'];
    this.delegate['from'] = map['from'];
    this.delegate['nonce'] = BigInt.parse(map['nonce'].toString(), radix: 10);
    this.delegate['value'] = BigInt.parse(map['value'].toString(), radix: 10);
    this.delegate['gaslimit'] = BigInt.parse(map['gaslimit'].toString(), radix: 10);
    this.delegate['gasfeecap'] = BigInt.parse(map['gasfeecap'].toString(), radix: 10);
    this.delegate['gaspremium'] = BigInt.parse(map['gaspremium'].toString(), radix: 10);
    this.delegate['method'] = map['method'];
    this.delegate['params'] = map['params'];
  }

  factory FilTransaction.deserialize(String cbor, {bool testnet = false}) {
    FilTransaction tx = new FilTransaction(cbor, testnet);

    return tx;
  }

  Uint8List hashToSign() {
    return Uint8List.fromList(hex.decode(FilCodec.txDigest(this.delegate['cbor'])));
  }
}
