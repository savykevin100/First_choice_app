import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';


class ConditionGenerales extends StatefulWidget {
  static String id="ConditionGenerales";
  @override
  _ConditionGeneralesState createState() => _ConditionGeneralesState();
}

class _ConditionGeneralesState extends State<ConditionGenerales> {
  ScrollController controller=ScrollController();
  int ajoutPanier;
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Conditions Générales",
        controller: controller,
        context: context,
        nbAjoutPanier: ajoutPanier);
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: _appBar.appBarFunctionStream(),
      drawer:  ProfileSettings(
        userCurrent:Renseignements.emailUser,
        firstLetter: Renseignements.emailUser[0],
      ),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: longueurPerCent(20.0, context),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Lorem Ipsum"),
            )
          ],
        ),
      ),
    );
  }
}