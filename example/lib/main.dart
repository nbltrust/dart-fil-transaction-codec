import 'package:flutter/material.dart';

import 'package:mylib/mylib.dart';

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
    // sync call
    String response = FilCodec.publicKeyToAddress(
        "048bfab3a70675389cf61836a09d2dd7a61163905d88c0d507ed18a1b94e7119f3e36646cd711337f373b91814fe7258a58e2206273620f71254928389930abd70");

    setState(() {
      _response = response;
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
