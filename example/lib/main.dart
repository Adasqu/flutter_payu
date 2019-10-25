import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_payu/flutter_payu.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(onPressed: () {
            _buttonTap();
          }),
        ),
      ),
    );
  }

  Future _buttonTap() async {
    final response = await FlutterPayu.googlePay("1000", 10000);
    print(response.status);
    print(response.message);
  }
}
