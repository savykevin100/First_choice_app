import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';



class Sharing extends StatefulWidget {
  static String id="Sharing";
  @override
  _SharingState createState() => _SharingState();
}

class _SharingState extends State<Sharing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Esys Share Plugin Sample'),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                MaterialButton(
                  child: Text('Share text'),
                  onPressed: () async => await _shareText(),
                ),
                MaterialButton(
                  child: Text('Share image'),
                  onPressed: () async => await _shareImage(),
                ),
                MaterialButton(
                  child: Text('Share images'),
                  onPressed: () async => await _shareImages(),
                ),
                MaterialButton(
                  child: Text('Share CSV'),
                  onPressed: () async => await _shareCSV(),
                ),
                MaterialButton(
                  child: Text('Share mixed'),
                  onPressed: () async => await _shareMixed(),
                ),
                MaterialButton(
                  child: Text('Share image from url'),
                  onPressed: () async => await _shareImageFromUrl(),
                ),
              ],
            )));
  }

  Future<void> _shareText() async {
    try {
      Share.text('my text title',
          'This is my text to share with other applications.', 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/image1.png');
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png', text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImages() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/images/1erchoix01.png');
      final ByteData bytes2 = await rootBundle.load('assets/images/1erchoix01.png');

      await Share.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
          },
          'image/png');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareCSV() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/addresses.csv');
      await Share.file(
          'addresses', 'addresses.csv', bytes.buffer.asUint8List(), 'text/csv');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareMixed() async {
    try {
      final ByteData bytes1 = await rootBundle.load('assets/image1.png');
      final ByteData bytes2 = await rootBundle.load('assets/image2.png');
      final ByteData bytes3 = await rootBundle.load('assets/addresses.csv');

      await Share.files(
          'esys images',
          {
            'esys.png': bytes1.buffer.asUint8List(),
            'bluedan.png': bytes2.buffer.asUint8List(),
            'addresses.csv': bytes3.buffer.asUint8List(),
          },
          '*/*', text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> _shareImageFromUrl() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/marketeurfollomme.appspot.com/o/categorie%2Faccessoires.jpg?alt=media&token=06bb1100-ba62-4f65-a7bd-bca97e0e63d2'));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg', text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }
}