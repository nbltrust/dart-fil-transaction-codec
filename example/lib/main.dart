import 'package:flutter/material.dart';

import 'package:fil_codec/fil_codec.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _response = '(please, wait)';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() {
    Map tx = FilTransaction.deserialize(
        "8a005501fd1d0f4dfcd7e99afcb99a8326b7dc459d32c62855011eaf1c8a4bbfeeb0870b1745b1f57503470b71160144000186a01961a84200014200010040");

    setState(() {
      _response = (tx as FilTransaction).hashToSign().toString();
      // _response = tx['to'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Rust FFI'),
        ),
        body: Center(
          child: Text(
            'Response:\n$_response\n',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
