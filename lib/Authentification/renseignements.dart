import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/tokens_utilisateurs.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import 'package:intl/intl.dart';

class Renseignements extends StatefulWidget {
  static final String id = "Renseignement";
  static String emailUser;

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
  String age;
  String ville;
  String tokenUser;
  int i = 0;
  final _formKey = GlobalKey<FormState>();
  Utilisateur utilisateur;
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> produits=[];
  final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();





  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token){
     setState(() {
       tokenUser=token;
       print(tokenUser);
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return   (chargement==true)?Scaffold(
      backgroundColor: HexColor("#001C36"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/logo.png',
              height: 197,
              width: 278,
            ),
            SizedBox(height: 50.0,),
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
        body: (produits!=null)?SingleChildScrollView(
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
                                      child: Text(val),
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
                            SizedBox(
                              height: longueurPerCent(20, context),
                            ),
                            DateTimeField(
                              style: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 18,
                                  fontFamily: "MonseraBold"
                              ),
                              format: DateFormat("dd-MM-yyyy"),
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      top: longueurPerCent(5, context),
                                      bottom: longueurPerCent(5, context),
                                      right: largeurPerCent(10, context),
                                      left: largeurPerCent(18, context)),
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: HexColor('#001C36'),
                                    size: 30.0,
                                  ),
                                ),
                                labelText: "Date d'anniversaire",
                                labelStyle: TextStyle(
                                    color: HexColor('#919191'),
                                    fontSize: 18.0,
                                    fontFamily: 'MonseraLight'),
                                hintText: "10/06/2000",
                                hintStyle: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 17.0,
                                    fontFamily: 'MonseraLight'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(7.0)),
                                    borderSide: BorderSide(
                                        width: 1, style: BorderStyle.none)),
                              ),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                              onChanged: (value){
                                if(value.day.toString().length==1 && value.month.toString().length==1){
                                  age = "0${value.day}"+ "-0${value.month}"+"-${value.year}";
                                } else if(value.day.toString().length!=1 && value.month.toString().length==1){
                                  age = "${value.day}"+ "-0${value.month}"+"-${value.year}";
                                } else if(value.day.toString().length==1 && value.month.toString().length!=1){
                                  age = "0${value.day}"+ "-${value.month}"+"-${value.year}";
                                } else  age = "${value.day}"+ "-${value.month}"+"-${value.year}";
                              },
                            ),

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
                                }),
                            SizedBox(
                              height: longueurPerCent(20, context),
                            ),
                            TextFormField(
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
                                }),
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
                        setState(() {
                          chargement = true;
                        });
                        try {
                          await FirestoreService().addUtilisateur(
                              Utilisateur(
                                  nomComplet: nomComplet,
                                  sexe: sexe,
                                  age: age,
                                  numero: numeroPayement,
                                  email: widget.emailAdress,
                                  nbAjoutPanier: 0,
                              ),
                              widget.emailAdress);
                              await FirestoreService().addToken(Tokens(
                               token: tokenUser
                              ));
                          print(Renseignements.emailUser);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllNavigationPage()));
                          setState(() {
                            chargement = true;
                          });
                        } catch (e) {
                          print(e);
                        }
                      } else {

                        displaySnackBarNom(context,
                            "Veuillez remplir tous les champs", Colors.red);
                      }
                    })
              ],
            ),
          ),
        ):CircularProgressIndicator()
    );
  }



  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
