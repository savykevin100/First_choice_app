import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier2.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';

class Panier1 extends StatefulWidget {
  static String id = 'Panier1';
  List<Map<String, dynamic>> produitsPanier;
  int total;
  Produit unSeulProduit;

  Panier1({this.total, this.produitsPanier, this.unSeulProduit});

  @override
  _Panier1State createState() => _Panier1State();
}

class _Panier1State extends State<Panier1> {
  String lieu;
  String moyenDePayement;
  String _dropDownValue2;
  String quartier;
  String _dropDownValue;
  Firestore _db = Firestore.instance;
  String name;
  String numUser;
  int prixLivraison;
  String dateHeureDeLivraison;
  String indication;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String selectedValueSingleDialog;
  Map<String, Widget> widgets;
  List<Map<String, dynamic>> quartiersDb = [];
  final format = DateFormat("yyyy-MM-dd HH:mm");

  Future<void> fetchNameNumUser() async {
    await _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
          name = value.data["nomComplet"];
          numUser = value.data["numero"];
        });
      }
    });
  }

  Future<void> fetchZones() async {
    await _db.collection("Zones").document("Zone").get().then((value) {
      quartiersDb.add(value.data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNameNumUser();
    fetchZones();
    print(widget.produitsPanier);
  }

  @override
  Widget build(BuildContext context) {
    /// Ce wiget est utilisé pour la selection des quartiers
    widgets = {
      "Single dialog": SearchChoices.single(
        items: [
          "Vodjè",
          "Gbegamey",
          "Houeyiho",
          "Calavi",
          "Godomey",
          "Bidossessi",
        ].map(
          (val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          },
        ).toList(),
        value: quartier,
        underline: Text(""),
        hint: Center(
          child: Container(
            color: Colors.blue,
            child: Text(
              "Selectionnez un quartier",
              style: TextStyle(
                  color: HexColor("#909090"), fontSize: 18, fontFamily: "Regular"),
            ),
          ),
        ),
        searchHint: "Quartiers",
        onChanged: (value) {
          setState(() {
            quartier = value;
          });
        },
        isExpanded: true,
      ),
    };
    ///////////////////////////////////////////////////////

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: HexColor("#001c36"),
          title: Text(
            "Panier",
            style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
          ),
        ),
        body: (numUser != null && name != null)
            ? SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: longueurPerCent(40, context),
                      ),
                      Center(
                        child: Text(
                          "INFORMATIONS DE LA COMMANDE",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 19.0,
                              fontFamily: "MonseraBold",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: longueurPerCent(30, context)),

                      Center(
                        child: Text(
                          name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 19.0,
                              fontFamily: "MonseraLight",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              height: longueurPerCent(0.0, context),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: longueurPerCent(14.0, context),
                                  right: longueurPerCent(0.0, context),
                                  left: longueurPerCent(80, context)),
                              child: Text(
                                "Teléphone",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: HexColor("#909090"),
                                  fontSize: 19.0,
                                  fontFamily: "Regular",
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: longueurPerCent(14.0, context),
                                  right: longueurPerCent(0.0, context),
                                  left: longueurPerCent(16.0, context)),
                              child: Text(
                                numUser,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 19.0,
                                    fontFamily: "MonseraLight",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: longueurPerCent(66.0, context),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: longueurPerCent(0.0, context),
                                  right: longueurPerCent(0.0, context),
                                  left: longueurPerCent(35.0, context)),
                              width: largeurPerCent(330.0, context),
                              height: longueurPerCent(40, context),
                              padding: EdgeInsets.only(
                                  left: largeurPerCent(10, context),
                                  right: largeurPerCent(20, context),
                                  top: longueurPerCent(0, context)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7.0),
                                  ),
                                  border: Border.all(
                                      color: HexColor("#919191"), width: 1)),
                              child: DropdownButton(
                                underline: Text(""),
                                hint: _dropDownValue == null
                                    ? Text(
                                        'Lieu de Livraison',
                                        style: TextStyle(
                                            color: HexColor('#919191'),
                                            fontSize: 18.0,
                                            fontFamily: 'MonseraLight'),
                                      )
                                    : Text(
                                        _dropDownValue,
                                        style: TextStyle(
                                            color: HexColor("#001C36"),
                                            fontSize: 18),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: HexColor("#919191")),
                                items: ['En Agence', 'A domicile'].map(
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
                                      lieu = _dropDownValue;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: longueurPerCent(20.0, context),
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////

                      ///Ici on fait la récupération du lieu de livraison pour l'appariton des champs quartier et indication
                      (lieu == "A domicile")
                          ? Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 45,right: 50),
                                  height: 50,
                                  child: DropdownSearch<String>(
                                    mode: Mode.BOTTOM_SHEET,
                                    maxHeight: 300,
                                    items: ["Vodjè", "Gbegamey", "Houeyiho", 'Calavi',"Godomey","Bidossessi"],
                                    onChanged:  (value) {
                                        quartier= value;
                                    },
                                    hint: "Sélectionner un quartier",
                                    showClearButton: true,
                                    showSearchBox: true,
                                    searchBoxDecoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.only(left: 100),
                                      hintText:"Rechercher un quartier",
                                      hintStyle: TextStyle(
                                          color: HexColor('#919191'),
                                          fontSize: 18.0,
                                          fontFamily: 'MonseraLight'),
                                    ),
                                    popupTitle: Container(
                                      height: longueurPerCent(50, context),
                                      decoration: BoxDecoration(
                                        color: HexColor("#001C36"),

                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Quartier',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    popupShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: longueurPerCent(20.0, context),
                                ),
                                //Ajouter le textField ici
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: longueurPerCent(0.0, context),
                                      right: longueurPerCent(0.0, context)),
                                  width: largeurPerCent(330, context),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Indication",
                                      hintStyle: TextStyle(
                                          color: HexColor('#919191'),
                                          fontSize: 18.0,
                                          fontFamily: 'MonseraLight'),
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.only(
                                          top: 30, bottom: 5, left: 15),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.0)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              style: BorderStyle.none)),
                                    ),
                                    onChanged: (value) {
                                      indication = value;
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Text(""),
                      ////////////////////////////////////////////////////////////////////////////////////////////////
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              height: longueurPerCent(70.0, context),
                            ),
                            Container(
                              height: longueurPerCent(40, context),
                              width: largeurPerCent(330.0, context),
                              margin: EdgeInsets.only(
                                  top: longueurPerCent(0.0, context),
                                  left: longueurPerCent(38.0, context)),
                              child: DateTimeField(
                                format: format,
                                onChanged: (value) {
                                  setState(() {
                                    dateHeureDeLivraison = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                        top: longueurPerCent(5, context),
                                        bottom: longueurPerCent(5, context),
                                        right: largeurPerCent(10, context),
                                        left: largeurPerCent(10, context)),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: HexColor('#001C36'),
                                      size: 30.0,
                                    ),
                                  ),
                                  labelText: "Date et heure de livraison",
                                  labelStyle: TextStyle(
                                      color: HexColor('#919191'),
                                      fontSize: 18.0,
                                      fontFamily: 'MonseraLight'),
                                  hintText: "10/06/2000",
                                  hintStyle: TextStyle(
                                      color: HexColor("#001C36"),
                                      fontSize: 18.0,
                                      fontFamily: 'MonseraLight'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
                                      borderSide: BorderSide(
                                          width: 1, style: BorderStyle.none)),
                                ),
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.combine(date, time);
                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: longueurPerCent(0.0, context),
                            right: longueurPerCent(0.0, context),
                            left: longueurPerCent(0.0, context)),
                        width: largeurPerCent(330.0, context),
                        height: longueurPerCent(40, context),
                        padding: EdgeInsets.only(
                            left: largeurPerCent(10, context),
                            right: largeurPerCent(20, context),
                            top: longueurPerCent(0, context)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7.0),
                            ),
                            border: Border.all(
                                color: HexColor("#919191"), width: 1)),
                        child: DropdownButton(
                          underline: Text(""),
                          hint: _dropDownValue2 == null
                              ? Text(
                            'Payement',
                            style: TextStyle(
                                color: HexColor('#919191'),
                                fontSize: 17.0,
                                fontFamily: 'MonseraLight'),
                          )
                              : Text(
                            _dropDownValue2,
                            style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 16),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: HexColor("#001C36")),
                          items:
                          ['Mobile Money', 'Moov Money', 'En espèce'].map(
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
                                _dropDownValue2 = val;
                                moyenDePayement = _dropDownValue2;
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: longueurPerCent(60.0, context)),
                      Center(
                        child: button(Colors.white, HexColor("#001C36"),
                            context, 'CONFIRMER', () {
                          checkInformationsComplete(context);
                        }),
                      ),
                      SizedBox(
                        height: longueurPerCent(30, context),
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void checkInformationsComplete(context) {
    if (lieu == 'En Agence' && dateHeureDeLivraison != null) {
      print("Reusssie");
      setState(() {
        prixLivraison = 0;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Panier2(
                    prixLivraison: prixLivraison,
                    total: widget.total,
                    nomComplet: name,
                    telephone: numUser,
                    lieuDeLivraison: lieu,
                    dateHeureDeLivraison: dateHeureDeLivraison,
                    produitsCommander: widget.produitsPanier,
                    unSeulProduit: widget.unSeulProduit,
                  )));
    } else if (lieu == "A domicile" &&
        CupertinoDatePickerMode.date != null &&
        indication != null &&
        quartier != null) {
      _db.collection("Zones").getDocuments().then((value) {
        for (int i = 0; i < value.documents.length; i++) {
          if (value.documents[i].data.containsValue(quartier)) {
            setState(() {
              prixLivraison = value.documents[i].data["prix"];
              widget.total = widget.total + prixLivraison;
            });
          }
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Panier2(
                      prixLivraison: prixLivraison,
                      total: widget.total,
                      nomComplet: name,
                      telephone: numUser,
                      lieuDeLivraison: lieu,
                      dateHeureDeLivraison: dateHeureDeLivraison,
                      indication: indication,
                      quartier: quartier,
                      produitsCommander: widget.produitsPanier,
                      unSeulProduit: widget.unSeulProduit,
                    )));
        print(widget.total);
        print(prixLivraison);
      });
    } else {
      print(dateHeureDeLivraison);
      displaySnackBarNom(
          context, "Veuillez remplir tous les champs ", Colors.red);
    }
  }
}
