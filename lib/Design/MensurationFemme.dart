
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';

class MensurationFemme extends StatefulWidget {
  static String id="MensurationFemme";

  @override
  _MensurationFemmeState createState() => _MensurationFemmeState();
}

class _MensurationFemmeState extends State<MensurationFemme> {
  String _dropDownValue;
  String image;
  String staturePantatalon;
  String statureHaut;
  String tourDeTailePantalon;
  String tourDeTaileHaut;
  String tourDeTaileJeans;
  String entrejambe30;
  String entrejambe32;
  String entrejambe34;
  String tourPoitrine;
  String correspndance;

  int i = 0;
  final _formKey = GlobalKey<FormState>();
  Utilisateur utilisateur;
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> produits=[];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("#F5F5F5"),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(
                top: longueurPerCent(80, context),
                left: largeurPerCent(10, context),
                right: largeurPerCent(10, context)),
            height: longueurPerCent(980, context),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(20, context),
                      left: largeurPerCent(17, context),
                      bottom: longueurPerCent(0, context)),
                  child: Text(
                    "Mensurations",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 25,
                        fontFamily: "MonseraBold"),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(20, context),
                      left: largeurPerCent(17, context),
                      bottom: longueurPerCent(10, context)),
                  child: Text(
                    "Pantalons:",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 20,
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
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 18,
                                    fontFamily: "MonseraBold"
                                ),
                                decoration: InputDecoration(
                                  hintText: "Stature en cm",
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
                                  staturePantatalon = value;
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
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "Tour de taille en cm",
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
                                  tourDeTailePantalon = value;
                                }),
                          ],
                        )
                    )
                ),

                //////////////////////////////////////////////

                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(30, context),
                      left: largeurPerCent(17, context),
                      bottom: longueurPerCent(10, context)),
                  child: Text(
                    "Vestes/Blousons/Chemises/Pulls/Jacket/T-shirt:",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 20,
                        fontFamily: "MonseraBold"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: largeurPerCent(17, context)),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 18,
                              fontFamily: "MonseraBold"
                          ),
                          decoration: InputDecoration(
                            hintText: "Stature en cm",
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
                            statureHaut = value;
                          }),
                      SizedBox(height: longueurPerCent(20, context),),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 18,
                              fontFamily: "MonseraBold"
                          ),
                          decoration: InputDecoration(
                            hintText: "Tour de poitrine en cm",
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
                            tourPoitrine = value;
                          }),
                      SizedBox(
                        height: longueurPerCent(20, context),
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 18,
                              fontFamily: "MonseraBold"
                          ),
                          decoration: InputDecoration(
                            hintText: "Tour de taille en cm",
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
                            tourDeTaileHaut = value;
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
                            'Correspondance',
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
                          items: ['M petit','M grand','L petit','L grand','XL','XXL petit','XXL moyen', 'XXL grand'].map(
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
                                correspndance = _dropDownValue;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: longueurPerCent(20.0, context),),
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(30, context),
                      left: largeurPerCent(17, context),
                      bottom: longueurPerCent(10, context)),
                  child: Text(
                    "Jeans:",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 20,
                        fontFamily: "MonseraBold"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: largeurPerCent(17, context)),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 18,
                              fontFamily: "MonseraBold"
                          ),
                          decoration: InputDecoration(
                            hintText: "Taille de confection 30 en cm",
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
                            statureHaut = value;
                          }),
                      SizedBox(height: longueurPerCent(20, context),),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 18,
                              fontFamily: "MonseraBold"
                          ),
                          decoration: InputDecoration(
                            hintText: "Taille de confection 32 en cm",
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
                            tourPoitrine = value;
                          }),
                      SizedBox(
                        height: longueurPerCent(20, context),
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 18,
                              fontFamily: "MonseraBold"
                          ),
                          decoration: InputDecoration(
                            hintText: "Taille de confection 34 en cm",
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
                            tourDeTaileHaut = value;
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: longueurPerCent(60, context),
                ),
                button(
                    Colors.white, HexColor("#001C36"), context, "CONFIRMATION ",
                        () async {

                    })
              ],
            ),
          ),
        )
    );
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
