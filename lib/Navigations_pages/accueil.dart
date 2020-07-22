import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(titre: "Acceuil", context: context);
    return Scaffold(
      appBar: _appBar.appBarFunction(),
      drawer: ProfileSettings(),
      body: Container(
      ),
    );
  }
}
