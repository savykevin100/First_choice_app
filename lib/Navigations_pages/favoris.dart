import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';


class Favoris extends StatefulWidget {
  @override
  _FavorisState createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(titre: "Favoris", context: context);
    return Scaffold(
      appBar: _appBar.appBarFunction(),
      drawer: ProfileSettings(),
      body: Container(
      ),
    );
  }
}
