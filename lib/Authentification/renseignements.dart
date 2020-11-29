import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../checkConnexion.dart';

class Renseignements extends StatefulWidget {
  static final String id = "Renseignement";
  static String emailUser;
  static List<String> userData=[];
  static int nombreAjoutPanier = 0;
  final String emailAdress;

  Renseignements({this.emailAdress});

  @override
  _RenseignementsState createState() => _RenseignementsState();
}

class _RenseignementsState extends State<Renseignements> {

  String _dropDownValue;
  String image;
  String nomComplet;
  String numeroPayement;
  String sexe = '';
  String age = "Date d'anniversaire";
  String ville;
  String tokenUser;
  int i = 0;
  final _formKey = GlobalKey<FormState>();
  Utilisateur utilisateur;
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> produits=[];
  String verificationId;
  String smsCode;
  FirebaseMessaging  _firebaseMessaging = FirebaseMessaging();





  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle( color: HexColor("#001C36"),
            fontSize: 15.0,
            fontFamily: "MonseraBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NON", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),

          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("OUI", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }



  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token){
      if(this.mounted)
        setState(() {
          tokenUser=token;
          print(token);
        });
    });
    print(widget.emailAdress);
  }



  @override
  Widget build(BuildContext context) {
    return   (chargement==true)?Scaffold(
      backgroundColor: HexColor("#001C36"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
        child: Column(
          children: <Widget>[
            Image.asset("assets/images/1er choix-02.png",
              height: 197,
              width: 278,
            ),
            SpinKitThreeBounce(
              color:HexColor('#FFFFFF'),
              size: 60,
            )
          ],
        ),
      ),
    ) : Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("#F5F5F5"),
        body: (produits!=null)?Test(displayContains: WillPopScope(
          onWillPop: _onBackPressed,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(
                  top: longueurPerCent(80, context),
                  left: largeurPerCent(10, context),
                  right: largeurPerCent(10, context)),
              height: longueurPerCent(600, context),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: longueurPerCent(20, context),
                        left: largeurPerCent(17, context),
                        bottom: longueurPerCent(40, context)),
                    child: Text(
                      "Paramètres du compte",
                      style: TextStyle(
                          color: HexColor("#001C36"),
                          fontSize: 25,
                          fontFamily: "MonseraBold"),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: largeurPerCent(17, context)),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                      color: HexColor("#001C36"),
                                      fontSize: 18,
                                      fontFamily: "MonseraBold"
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Nom Complet",
                                    hintStyle: TextStyle(
                                        color: HexColor('#919191'),
                                        fontSize: 18.0,
                                        fontFamily: 'MonseraLight'),
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.only(
                                        top: 30, bottom: 5, left: 20),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0)),
                                        borderSide: BorderSide(
                                            width: 1, style: BorderStyle.none)),
                                  ),
                                  onChanged: (value) {
                                    nomComplet = value;
                                  }),
                              SizedBox(
                                height: longueurPerCent(20, context),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: largeurPerCent(20, context),
                                    right: largeurPerCent(20, context),
                                    top: longueurPerCent(05, context),
                                    bottom:longueurPerCent(05, context) ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7.0),
                                    ),
                                    border: Border.all(
                                        color: HexColor("#919191"), width: 1)),
                                child: DropdownButton(

                                  hint: _dropDownValue == null
                                      ? Text(
                                    'Genre',
                                    style: TextStyle(
                                        color: HexColor('#919191'),
                                        fontSize: 18.0,
                                        fontFamily: 'MonseraLight'),
                                  )
                                      : Text(
                                    _dropDownValue,
                                    style: TextStyle(
                                        color: HexColor("#001C36"),
                                        fontSize: 18,
                                        fontFamily: 'MonseraBold'),
                                  ),
                                  isExpanded: true,
                                  underline: Text(
                                      ""
                                  ),
                                  iconSize: 30.0,
                                  style: TextStyle(color: HexColor("#919191")),
                                  items: ['Masculin', 'Féminin'].map(
                                        (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val, style:TextStyle(
                                            color: HexColor('#919191'),
                                            fontSize: 18,
                                            fontFamily: 'MonseraLight'),),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                          () {
                                        _dropDownValue = val;
                                        sexe = _dropDownValue;
                                      },
                                    );
                                  },
                                ),
                              ),
                              /*Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: longueurPerCent(50, context),
                                  padding: EdgeInsets.only(
                                      left: largeurPerCent(20, context),
                                      right: largeurPerCent(20, context),
                                      top: longueurPerCent(15, context),
                                      bottom:longueurPerCent(05, context) ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7.0),
                                      ),
                                      border: Border.all(
                                          color: HexColor("#919191"), width: 1)),
                                  child:  GestureDetector(
                                    onTap: (){
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1900, 1, 1),
                                          maxTime: DateTime(2003, 12, 1), onChanged: (date) {
                                            setState(() {
                                              age = date.toString().substring(0, 10);
                                            });
                                          }, onConfirm: (date) {
                                            setState(() {
                                              age = date.toString().substring(0, 10);
                                            });
                                          }, currentTime: DateTime.now(), locale: LocaleType.fr);
                                    },
                                    child: (age == "Date d'anniversaire")?Text(age, style: TextStyle(
                                        color: HexColor('#919191'),
                                        fontSize: 18.0,
                                        fontFamily: 'MonseraLight')): Text(
                                      age.substring(0, 10),
                                      style: TextStyle(
                                          color: HexColor("#001C36"),
                                          fontSize: 18,
                                          fontFamily: 'MonseraBold'),
                                    ),
                                    /**/
                                  )
                              ),*/
                              SizedBox(
                                height: longueurPerCent(20, context),
                              ),
                              TextFormField(
                                style: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 18,
                                    fontFamily: "MonseraBold"
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Numero de Téléphone",
                                  hintStyle: TextStyle(
                                      color: HexColor('#919191'),
                                      fontSize: 18.0,
                                      fontFamily: 'MonseraLight'),
                                  contentPadding: EdgeInsets.only(
                                      top: 30, bottom: 5, left: 24),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
                                      borderSide: BorderSide(
                                          width: 1, style: BorderStyle.none)),
                                ),
                                onChanged: (value) {
                                  numeroPayement = value;
                                },
                                // ignore: missing_return
                                validator: (value){
                                  // ignore: missing_return
                                  if(value.length!=8 ){
                                    return ( "Entrer un numéro valide");
                                  }
                                },
                              ),
                              SizedBox(
                                height: longueurPerCent(20, context),
                              ),
                              /*TextFormField(
                                  style: TextStyle(
                                      color: HexColor("#001C36"),
                                      fontSize: 18,
                                      fontFamily: "MonseraBold"
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Ville",
                                    hintStyle: TextStyle(
                                        color: HexColor('#919191'),
                                        fontSize: 18.0,
                                        fontFamily: 'MonseraLight'),
                                    contentPadding: EdgeInsets.only(
                                        top: 30, bottom: 5, left: 24),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0)),
                                        borderSide: BorderSide(
                                            width: 1, style: BorderStyle.none)),
                                  ),
                                  onChanged: (value) {
                                    ville = value;
                                  }),*/
                            ],
                          ))),
                  SizedBox(
                    height: longueurPerCent(60, context),
                  ),
                  button(
                      Colors.white, HexColor("#001C36"), context, "CONFIRMATION ",
                          () async {
                        if (_formKey.currentState.validate() &&
                            _dropDownValue != null) {
                          sendDataUserDb();
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed(AllNavigationPage.id);
                          // verifyPhone();
                          setState(() {
                            chargement = true;
                          });
                        } else {
                          displaySnackBarNom(context,
                              "Veuillez remplir tous les champs", Colors.red);
                        }
                      })
                ],
              ),
            ),
          ),
        ),):CircularProgressIndicator()
    );
  }

  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Un sms de vérification a été envoyé sur votre numéro", style: TextStyle(
                            color: Colors.black, fontFamily: "Bold"),)
                      ]),
                    )
                  ]));
        });
  }

  Future<void> sendDataUserDb() async{
    setState(() {
      chargement = true;
    });
    try {
      await FirestoreService().addUtilisateur(
          Utilisateur(
              nomComplet: nomComplet,
              sexe: sexe,
              age:   age.substring(0, 10),
              numero: numeroPayement,
              email: widget.emailAdress,
              nbAjoutPanier: 0,
              orderNumber: 0,
          ),
          widget.emailAdress);
      ajouter([
        numeroPayement,
        widget.emailAdress,
        nomComplet,
        age.substring(0, 10),
       sexe,
      ]);
      if(tokenUser!=null)
        Firestore.instance.collection("TokensUsers").where("token", isEqualTo: tokenUser).getDocuments().then((value) {
          if(value.documents.isEmpty){
            Firestore.instance.collection("TokensUsers").add({
              "token": tokenUser
            });
          }
        });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AllNavigationPage()));
      setState(() {
        chargement = false;
      });
    } catch (e) {
      print(e);
    }
  }

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



  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar, );
  }


}