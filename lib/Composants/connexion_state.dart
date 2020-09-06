import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'hexadecimal.dart';



class ConnexionState extends StatefulWidget {
  Widget body;
  ConnexionState({this.body});
  @override
  _ConnexionStateState createState() => _ConnexionStateState();
}

class _ConnexionStateState extends State<ConnexionState> {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if(connected) return
          widget.body;
        else
          return Center(child: new Text(
            '${"VOUS N'ETES PAS CONNECTER À INTERNET"}',  style: TextStyle(
              color: HexColor("#001C36"),
              fontSize: 15.0,
              fontFamily: "MonseraBold",
              fontWeight: FontWeight.bold),
          ),);
      },
      child: Text(""),
    );
  }
}
