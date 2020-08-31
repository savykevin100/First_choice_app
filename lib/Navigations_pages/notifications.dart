import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
 int nombreAjoutPanier;
 final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Notifications", context: context, controller: controller, nbAjoutPanier: nombreAjoutPanier);
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: _appBar.appBarFunctionStream(),
      drawer: ProfileSettings(
        userCurrent:Renseignements.emailUser,
        firstLetter: Renseignements.emailUser[0],
      ),
      body: Container(
        child:   elementsVides(context, Icons.add_alert, " aucune notification",),
      ),
    );

  }
}
