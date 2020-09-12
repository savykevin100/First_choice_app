import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:premierchoixapp/Composants/calcul.dart';

import 'hexadecimal.dart';

// ignore: must_be_immutable
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
        if (connected)
          return widget.body;
        else
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.signal_cellular_connected_no_internet_4_bar, size: 100, color: Theme.of(context).primaryColor,),
                SizedBox(height:longueurPerCent(20, context)),
                Text(
                  '${"VOUS N'ETES PAS CONNECTER À INTERNET"}',
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15.0,
                      fontFamily: "MonseraBold",
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
      },
      child: Text(""),
    );
  }
}


