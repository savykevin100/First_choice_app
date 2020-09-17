import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
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
 String nameUser;


 Future<bool> _onBackPressed() {
   return showDialog(
     context: context,
     builder: (context) => new AlertDialog(
       title: new Text("Fermer l'application",  style: TextStyle(fontFamily: "MonseraBold")),
       content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
       actions: <Widget>[
         new GestureDetector(
             onTap: () => Navigator.of(context).pop(false),
             child: Text("Non", style: TextStyle(fontFamily: "MonseraBold"),)
         ),
         SizedBox(width: largeurPerCent(50, context),),
         new GestureDetector(
             onTap: () => Navigator.of(context).pop(true),
             child: Text("Oui", style: TextStyle(fontFamily: "MonseraBold"),)
         ),
         SizedBox(width: largeurPerCent(20, context),),
       ],
     ),
   ) ??
       false;
 }

 Future<void> fetchDataUser(String id) async {
   await Firestore.instance
       .collection("Utilisateurs")
       .document(id)
       .get()
       .then((value) {
     if (this.mounted) {
       setState(() {
         nameUser = value.data["nomComplet"];
       });
     }
   });
 }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataUser(Renseignements.emailUser);
 }

 @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Notifications", context: context, controller: controller, nbAjoutPanier: nombreAjoutPanier);
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: _appBar.appBarFunctionStream(),
      drawer: ProfileSettings(
        userCurrent:Renseignements.emailUser,
          firstLetter:(nameUser!=null)?nameUser[0]:""
      ),
      body: WillPopScope(
        onWillPop:_onBackPressed,
        child: Container(
          child:   elementsVides(context, Icons.add_alert, " Aucune notification",),
        ),
      ),
    );

  }
}
