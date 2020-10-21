import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Authentification/slider.dart';
import 'package:premierchoixapp/Composants/databaseClient.dart';
import 'package:premierchoixapp/Design/PageAcceuil.dart';
import 'package:premierchoixapp/Models/panier_classe_sqflite.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class FirstPage extends StatefulWidget {
  static String id="FirstPage";
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }


  bool currentUser=false;
  bool ajoue=false;
  List<Map<String, dynamic>> produits=[];
  List<Map<String, dynamic>> produitsFavorisUsers=[];
  String utilisateurConnecte;

  // Table qui contient les éléments du panier
  List<PanierClasseSqflite> panierItems = [];

  String key = "email_user";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> liste = sharedPreferences.getStringList(key);
    if (liste != null) {
      if(this.mounted)setState(() {
        Renseignements.userData = liste;
      });
    }
  }

  Future<void> ajouter(List<String> str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.userData = str;
    await sharedPreferences.setStringList(key, Renseignements.userData);
    obtenir();
  }


/*  String keyAjoutPanier="numberAjout";
  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenirNumberPanier() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int liste = sharedPreferences.getInt(keyAjoutPanier);
    if (liste != null) {
      setState(() {
        Renseignements.nombreAjoutPanier = liste;
      });
    }
  }
  Future<void> ajouterNumberPanier(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.nombreAjoutPanier = value;
    await sharedPreferences.setInt(key, Renseignements.nombreAjoutPanier);
    obtenirNumberPanier();
  }*/


  void getDataPanier(){
    DatabaseClient().readPanierData().then((value) {
      if(this.mounted)
        setState(() {
        panierItems=value;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPanier();
    getUser().then((value){
      if(value!=null){
          /*Firestore.instance.collection("Utilisateurs").document(value.email).get().then((value) {
            print(value.data);
            ajouter([
              value.data["numero"],
              value.data["email"],
              value.data["nomComplet"],
              value.data["age"],
              value.data["sexe"],
            ]);

          });*/
          print(value.email);
         setState(()  {
            currentUser=true;
            utilisateurConnecte=value.email;
          });
          Firestore.instance
              .collection("Utilisateurs")
              .document(value.email)
              .updateData({"nbAjoutPanier": 0});
      }
    });
    StarTimer();
  }

  // ignore: non_constant_identifier_names
  StarTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route (){
    if(currentUser ){
      for(int i=0; i<panierItems.length; i++){
        DatabaseClient().deleteItemPanier(panierItems[i].id , "panier");
      }


      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 750),child: AllNavigationPage(),
      ));
    } else{
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 750),child: PageAcceuil(),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#001C37"),
      body: SingleChildScrollView(
        child: new Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  FadeInDown(
                    duration: Duration(seconds: 2),
                    child: Container(
                      margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(175.0, context),),
                      height: longueurPerCent(227.5, context),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/1er choix-01.png",
                        fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(50, context),),
                 // Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),),
                  SizedBox(height: longueurPerCent(50, context),),
                  JelloIn(
                    duration: Duration(seconds: 1),
                    delay: Duration(seconds: 2),
                    child: Container(
                      margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(46.0, context),),
                      child: Center(
                        child: Text(
                          "S'habiller n'a jamais été aussi simple",
                          style: TextStyle(color: HexColor("##FFFFFF"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}