import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Design/FirstPage.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/scrollable_products_horizontal.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final controller = ScrollController();
  final _auth = FirebaseAuth.instance;
  Firestore _db = Firestore.instance;
  int nombreAjoutPanier;
  FirebaseUser utilisateurConnecte;


  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          utilisateurConnecte = user;
          ajouter(utilisateurConnecte.email);
        });
      }
    } catch (e) {
      print(e);
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }


  @override
  Widget build(BuildContext context) {
   if(utilisateurConnecte!=null){
     print(Renseignements.emailUser);
     AppBarClasse _appBar = AppBarClasse(
         titre: "Accueil", context: context, controller: controller, nbAjoutPanier: nombreAjoutPanier);
     return Scaffold(
         appBar: _appBar.appBarFunctionStream(),
         drawer: ProfileSettings(userCurrent: utilisateurConnecte.email,),
         body: Snap(
           controller: controller.appBar,
           child: ListView(controller: controller, children: <Widget>[
             SizedBox(
               height: longueurPerCent(20, context),
             ),
             Container(
                 margin: EdgeInsets.symmetric(horizontal: largeurPerCent(20, context)),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                   color: HexColor("#DDDDDD"),
                 ),
                 child: TextFormField(
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     prefixIcon: Padding(
                       padding:  EdgeInsets.only(left: largeurPerCent(20, context)),
                       child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                     ),
                     labelText: "Rechercher un produit",
                     labelStyle: TextStyle(
                         color: HexColor('#9B9B9B'),
                         fontSize: 17.0,
                         fontFamily: 'MonseraLight'),
                     contentPadding: EdgeInsets.only(top: 10, bottom: 5, left:100),

                   ),
                 )),
             Padding(
               padding: EdgeInsets.only(
                   top: longueurPerCent(20, context),
                   left: largeurPerCent(10, context)),
               child: Text(
                 "RECOMMANDÉS",
                 style: TextStyle(
                     color: HexColor("#001C36"),
                     fontSize: 22,
                     fontFamily: "MonseraBold"),
               ),
             ),
             SizedBox(
               height: longueurPerCent(20, context),
             ),
             scrollabe_products_horizontal(context),
             Padding(
               padding: EdgeInsets.only(
                   top: longueurPerCent(20, context),
                   left: largeurPerCent(10, context)),
               child: Text(
                 "DÉCOUVERTES",
                 style: TextStyle(
                     color: HexColor("#001C36"),
                     fontSize: 22,
                     fontFamily: "MonseraBold"),
               ),
             ),
             SizedBox(height: longueurPerCent(20, context),),
             product_grid_view()
           ]),
         ));
    } else {
     return  Container(
       height: 100,
       width: 100,
       child: CircularProgressIndicator(),
     );
    }
   }
  String key = "email_user";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String liste = sharedPreferences.getString(key);
    if (liste != null) {
      setState(() {
        Renseignements.emailUser = liste;
      });
    }
  }
  /* Fin de la fonction */

  /* Cette fonction permet d'ajouter les informations*/

  Future<void> ajouter(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.emailUser=str;
    await sharedPreferences.setString(key, Renseignements.emailUser);
    obtenir();
  }
  }

