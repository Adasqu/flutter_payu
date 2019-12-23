import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_payu/flutter_payu.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _posIdController;
  TextEditingController _tokenController;

  @override
  void initState() {
    super.initState();
    _posIdController = TextEditingController();
    _tokenController = TextEditingController();
    _posIdController.text = "349133";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Pos ID:"),
              TextField(
                controller: _posIdController,
              ),
              RaisedButton(
                  onPressed: () {
                _buttonTap();
              },
              child: Text("get token"),
              ),
              TextField(
                maxLines: 10,
                controller: _tokenController,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _buttonTap() async {
    final response = await FlutterPayu.googlePay(_posIdController.text, 1);
    print(response.status);
    print(response.message);
    _tokenController.text = response.message;
  }
}
