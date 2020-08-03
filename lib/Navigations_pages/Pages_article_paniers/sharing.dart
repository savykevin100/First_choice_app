import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';


class Sharing extends StatefulWidget {
  static String id="Sharing";
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Sharing> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ImageViewer example app'),
        ),
        body: Center(

        ),
      ),
    );
  }
}