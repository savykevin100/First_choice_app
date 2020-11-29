import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Design/CustomDialog.dart';
import 'package:premierchoixapp/IntroPages/PageAcceuil.dart';
import 'package:premierchoixapp/Models/panier_classe_sqflite.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
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


  bool maj=false;
  bool currentUser=false;
  List<Map<String, dynamic>> produits=[];
  List<Map<String, dynamic>> produitsFavorisUsers=[];
  String utilisateurConnecte;
  bool validateInscription=true;
  // Table qui contient les éléments du panier
  List<PanierClasseSqflite> panierItems = [];
  int taille;
    String versionActuelle;





  AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
      print(_updateInfo.updateAvailable);
    }).catchError((e) => _showError(e));
  }

  void _showError(dynamic exception) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(exception.toString())));
  }


  String key = "email_user";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> liste = sharedPreferences.getStringList(key);
    if (liste != null) {
      if(this.mounted)
        Renseignements.userData = liste;
    }
  }

  Future<void> ajouter(List<String> str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.userData = str;
    await sharedPreferences.setStringList(key, Renseignements.userData);
    obtenir();
  }

  /*void getDataPanier(){
    DatabaseClient().readPanierData().then((value) {
      if(this.mounted)
        setState(() {
          panierItems=value;
        });
    });
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getDataPanier();
    checkForUpdate();
    getUser().then((emailUser){
     /* Firestore.instance.collection("Informations_générales").document("78k1bDeNwVHCzMy8hMGh").get().then((value) {
        setState(() {
          versionActuelle=value.data["version"];
        });
        print(versionActuelle);
      });*/
      if(emailUser!=null){
          Firestore.instance.collection("Utilisateurs").document(emailUser.email).get().then((value) {
            /*try {
              if(versionActuelle!=null)
                if(!value.data.containsKey("version")){
                  setState(() {
                    maj=true;
                  });
                } else if(value.data["version"]!=versionActuelle)
                  setState(() {
                    maj=true;
                  });
            } catch (e){
              print("Erreur");
              setState(() {
                validateInscription=false;
              });
              print(validateInscription);
            }*/
            try {
              ajouter([
                value.data["numero"],
                value.data["email"],
                value.data["nomComplet"],
                value.data["age"],
                value.data["sexe"],
              ]);
            } catch (e){
              print("Erreur");
              setState(() {
                validateInscription=false;
              });
              print(validateInscription);
            }
          });

        setState(() {
          currentUser=true;
          utilisateurConnecte=emailUser.email;
          Renseignements.emailUser=emailUser.email;
        });
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
    if(currentUser && validateInscription){
      if(_updateInfo.updateAvailable==false){
           showUpdateDialog();
      } else
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AllNavigationPage()));

    } else if(currentUser && validateInscription==false){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>Renseignements(emailAdress: utilisateurConnecte,)));
    } else if(currentUser==false){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>PageAcceuil()));
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
                    duration: Duration(seconds: 5),
                    child: Container(
                      margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(175.0, context),),
                      height: longueurPerCent(227.5, context),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/1er choix-01.png",
                        fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(100, context),),
                  Container(
                    margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(46.0, context),),
                    child: Center(
                      child: Text("S'habiller n'a jamais été aussi simple", style: TextStyle(
                          fontSize: 16,
                          fontFamily: "MonseraBold",
                          color: Colors.white
                      ),)/*FadeAnimatedTextKit(
                        onTap: (){

                        },
                        text: [
                          "",
                          "S'habiller",
                          "n'a jamais été",
                          "aussi simple",
                        ],
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: "MonseraBold",
                          color: Colors.white
                        ),
                        textAlign: TextAlign.start,
                          alignment: AlignmentDirectional.topStart,
                        isRepeatingAnimation: false,
                        duration: Duration(milliseconds: 1000),
                        pause: Duration(milliseconds: 1200),
                      ),*/
                    ),
                  ),
                  SizedBox(height: longueurPerCent(40, context),),
                  Container(
                    margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(46.0, context),),
                    child: Center(
                      child: Text(
                        "Version 1.0.2",
                        style: TextStyle(color: HexColor("##FFFFFF"), fontFamily: 'MontserratBold', fontSize: 12.0, fontWeight: FontWeight.bold ),
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


  void showUpdateDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Mise à jour",
        description:
        "Une nouvelle mise à jour est disponilble, voulez-vous la télécharger maintenant?",
        cancelButton: FlatButton(
          onPressed: (
              ) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AllNavigationPage()));
          },
          child: Text("Plus tard",
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 12.0,
                fontFamily: "MonseraBold"
            ),
          ),
        ),
        nextButton: FlatButton(
          onPressed: (
              ) {
            Navigator.pop(context);
            launchPlayStore();
           //InAppUpdate.performImmediateUpdate().catchError((e) => _showError(e));
          },
          child: Text("Oui",
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 12.0,
                fontFamily: "MonseraBold"
            ),),
        ),
        icon: Icon(Icons.system_update,size: 100,color: HexColor("#001C36")),
      ),
    );
  }

  launchPlayStore() async {
    String url ="https://play.google.com/store/apps/details?id=com.followme.premierchoix";

    if (await canLaunch(url)) {
      await launch(url);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllNavigationPage()));
    } else {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllNavigationPage()));
      throw 'Could not launch $url';
    }
  }

  /*String validateInscriptionKey = "validation_inscription";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenirValidateInscription() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool valeur = sharedPreferences.getBool(validateInscriptionKey);
    if (valeur != null) {
      if(this.mounted)
        setState(() {
          validateInscription = valeur;
        });
    }
  }

  /* Fin de la fonction */

  /* Cette fonction permet d'ajouter les informations*/

  Future<void> ajouterValidateInscription(bool str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      validateInscription = str;
    });
    await sharedPreferences.setBool(validateInscriptionKey, validateInscription);
    obtenirValidateInscription();
  }*/
}