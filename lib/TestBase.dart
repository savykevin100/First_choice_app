import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.Dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestBase extends StatefulWidget {
  static String id="Test";
  @override
  _TestBaseState createState() => _TestBaseState();
}

class _TestBaseState extends State<TestBase> {
  String _base64;

  @override
  void initState() {
    super.initState();
    (() async {
      http.Response response = await http.get(
        'https://flutter.io/images/flutt-square-100.png',
      );
      if (mounted) {
        setState(() {
          _base64 = base64.encode(response.bodyBytes);
        });
        print(_base64);
      }
    })();
  }


  @override
  Widget build(BuildContext context) {
    if (_base64 == null)
      return new Container();
    Uint8List bytes = base64.decode(_base64);
    return new Scaffold(
      appBar: new AppBar(title: new Text('Example App')),
      body: new ListTile(
        leading: new Image.memory(bytes),
        title: new Text(_base64),
      ),
    );
  }
}