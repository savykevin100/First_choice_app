import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Authentification/slider.dart';
import 'package:premierchoixapp/Composants/databaseClient.dart';
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
      setState(() {
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
        if(this.mounted){
          Firestore.instance.collection("Utilisateurs").document(value.email).get().then((value) {
            print(value.data);
            ajouter([
              value.data["numero"],
              value.data["email"],
              value.data["nomComplet"],
              value.data["age"],
              value.data["sexe"],
            ]);

          });
          setState(()  {
            currentUser=true;
            utilisateurConnecte=value.email;
          });
        }
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
      Firestore.instance
          .collection("Utilisateurs")
          .document(utilisateurConnecte)
          .updateData({"nbAjoutPanier": 0});

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => AllNavigationPage()
      ));
    } else{
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => IntroScreen()
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#001C37"),
      body: new Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(175.0, context),),
                  height: longueurPerCent(227.5, context),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/logo.png",
                    fit: BoxFit.cover,),
                ),
                SizedBox(height: longueurPerCent(50, context),),
                Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),),
                SizedBox(height: longueurPerCent(50, context),),
                Container(
                  margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(46.0, context),),
                  child: Center(
                    child: Text(
                      "S'habiller n'a jamais été aussi simple",
                      style: TextStyle(color: HexColor("##FFFFFF"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

  }
}