import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  Widget build(BuildContext context) {
   AppBarClasse _appBar = AppBarClasse(titre: "Notications", context: context);
    return Scaffold(
      appBar: _appBar.appBarFunction(),
      drawer: ProfileSettings(),
      body: Container(
      ),
    );
  }
}
