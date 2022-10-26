import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fil_codec/fil_codec.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';


  @override
  void initState() {
    super.initState();
    initPlatformState();
    final de = FilCodec.txDecode("8a005501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c62855011eaf1c8a4bbfeeb0870b1745b1f57503470b71160144000186a01961a84200014200010040");
    print("-------- txDecode $de");
    final en = FilCodec.txEncode(de);
    print("-------- txEncode $en");
    final address = FilCodec.publicKeyToAddress("048bfab3a70675389cf61836a09d2dd7a61163905d88c0d507ed18a1b94e7119f3e36646cd711337f373b91814fe7258a58e2206273620f71254928389930abd70");
    print("-------- address $address");
    if(address == "f1j5klxt6zktifpibt7jlafmdxkfe4fwjhm6yqjhq"){
      print("-------- address YES");
    }
    final d = FilCodec.txDigest("885501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c6285501b882619d46558f3d9e316d11b48dcf211327025a0144000186a0430009c4430061a80040");

    print("-------- txDigest $d   5a51287d2e5401b75014da0f050c8db96fe0bacdad75fce964520ca063b697e1");

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
