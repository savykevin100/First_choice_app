import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Composants/hexadecimal.dart';
import 'Design/CustomDialog.dart';

class Test extends StatefulWidget {
  static String id = "Test";
  Widget displayContains;


Test({
    this.displayContains
});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_connectionStatus == "ConnectivityResult.none")?
          Center(
            child: Icon(Icons.connect_without_contact, size: 60, color: Colors.red,),
          ):widget.displayContains,
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  confirmationPopup(BuildContext dialogContext) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Important",
        description:
        "Oups!!!! Veuillez vérifier votre connexion et réessayer",
        icon: Icon(Icons.dangerous,size: 100,color: HexColor("#001C36")),
      ),
    );
  }
}



