import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(titre: "Chat", context: context);
    return Scaffold(
      appBar: _appBar.appBarFunction(),
      drawer: ProfileSettings(),
      body: Container(
      ),
    );
  }
}
