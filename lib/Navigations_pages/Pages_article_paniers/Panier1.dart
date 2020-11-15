import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Design/CustomDialog.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier2.dart';

import '../../checkConnexion.dart';


// ignore: must_be_immutable
class Panier1 extends StatefulWidget {
  static String id = 'Panier1';
  List<Map<String, dynamic>> produitsPanier;
  int total;

  Panier1({this.total, this.produitsPanier});

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
  List<String> quartiersDb = [];
  int stopSommeLivraisonRetour = 0;
  List<String> listMoyenPayement = ['Mobile Money ou Moov Money', 'Espèce'];
  List<Map<String, dynamic>> priceAndQuartiers=[];
  String locationMagasin;



  Future<void> fetchZonesTest()async{
    await _db.collection("ZonesTest").getDocuments().then((value) {
      value.documents.forEach((element) {
        priceAndQuartiers.add(element.data);
        List<String> listQuartiers = List<String>.from(element.data["quartiers"]);
        listQuartiers.forEach((quar) {
          if(this.mounted)
            setState(() {
              quartiersDb.add(quar);
            });
        });
      });
    });
  }


  Future<void> getLocalisationMagazin() async {
    await _db
        .collection("Informations_générales").document("78k1bDeNwVHCzMy8hMGh")
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
           locationMagasin = value.data["agence"];
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchZonesTest();
    getLocalisationMagazin();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: HexColor("#001c36"),
        title: Text(
          "Livraison",
          style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
        ),
      ),
      body: (quartiersDb != null)
          ? Test(displayContains: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: longueurPerCent(40, context),
              ),
              Center(
                child: Text(
                  "INFORMATION DE LA COMMANDE",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15.0,
                      fontFamily: "MonseraBold",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context)),

              Center(
                child: Text(
                  Renseignements.userData[2],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15.0,
                      fontFamily: "MonseraLight",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(longueurPerCent(10, context)),
                  child: Center(
                    child: Text(
                      Renseignements.userData[0],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: HexColor("#001C36"),
                          fontSize: 15.0,
                          fontFamily: "MonseraLight",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: longueurPerCent(50.0, context),
              ),
              Container(
                margin: EdgeInsets.only(left: longueurPerCent(30, context),
                    right: longueurPerCent(30, context)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: largeurPerCent(347.0, context),
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
                                  color: Colors.grey, width: 1)),
                          child: DropdownButton(
                            underline: Text(""),
                            hint: _dropDownValue == null
                                ? Text(
                              'Lieu de Livraison',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                                : Text(
                              _dropDownValue,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16),
                            items: ['En Agence', 'A domicile'].map(
                                  (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,),
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
                      ),

                      ///Ici on fait la récupération du lieu de livraison pour l'appariton des champs quartier et indication
                      (lieu == "A domicile")
                          ? Column(
                        children: <Widget>[
                          SizedBox(height: longueurPerCent(20, context)),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(left: 0, right: 0),
                              width: longueurPerCent(347, context),
                              height: 50,
                              child: DropdownSearch<String>(
                                mode: Mode.BOTTOM_SHEET,
                                maxHeight: 450,
                                hint: "Sélectionner une zone",
                                items: quartiersDb.toList(),
                                onChanged: (value) {
                                  setState(() {
                                    quartier = value;
                                  });
                                  priceAndQuartiers.forEach((element) {
                                    var variable = List<String>.from(element["quartiers"]);
                                    variable.forEach((value) {
                                      if(quartier==value) {
                                        setState(() {
                                          prixLivraison=element['prix'];
                                        });
                                        if(element["prix"]>1000)
                                          setState(() {
                                            listMoyenPayement=['Mobile Money ou Moov Money'];
                                          });
                                        else
                                          setState(() {
                                            listMoyenPayement = ['Mobile Money ou Moov Money', 'Espèce'];
                                          });
                                      }
                                    });
                                  });
                                },
                                selectedItem: quartier,
                                showClearButton: true,
                                showSearchBox: true,
                                searchBoxDecoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(left: longueurPerCent(50, context), right: longueurPerCent(50, context)),
                                  hintText: "Rechercher une zone",
                                  hintStyle: TextStyle(
                                      fontSize: 15.0,
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
                                      'Zone',
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
                          ),
                          SizedBox(
                            height: longueurPerCent(20.0, context),
                          ),
                          Center(
                            child: Container(
                              width: largeurPerCent(347, context),
                              child: TextFormField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Indication du lieu de livraison",
                                  hintStyle:  TextStyle(
                                    fontSize: 16.0,),
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
                                  setState(() {
                                    indication = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                          : Text(""),
                      ////////////////////////////////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: longueurPerCent(20.0, context),
                      ),
                      Center(
                        child: Container(
                          width: largeurPerCent(347.0, context),
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
                                  color: Colors.grey, width: 1)),
                          child: DropdownButton(
                            underline: Text(""),
                            hint: _dropDownValue2 == null
                                ? Text(
                              'Payement',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                                : Text(
                              _dropDownValue2,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            items:
                            listMoyenPayement.map(
                                  (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,),
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
                      ),
                    ],
                  ),
                ),
              ),
              //////////////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: longueurPerCent(100.0, context)),
              Center(
                child:
                Container(
                  child: button(Colors.white, HexColor("#001C36"), context,
                      'CONFIRMER', () {
                        checkInformationsComplete(context);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),)
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  checkInformationsComplete(context) {
    if (lieu == 'En Agence' && moyenDePayement != null ) {
      setState(() {
        prixLivraison = 0;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: "Localisation",
          description:
          "L'agence est située à $locationMagasin. Nous sommes ouvert du Lundi au Samedi de 09H à 20H.",
          cancelButton: FlatButton(
            onPressed: (
                ) {
              Navigator.of(context).pop(); // To close the dialog
            },
            child: Text("ANNULER",
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
              if(lieu=="En Agence" && locationMagasin!=null){
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Panier2(
                          prixLivraison: prixLivraison,
                          total: widget.total,
                          nomComplet:  Renseignements.userData[2],
                          telephone:  Renseignements.userData[0],
                          moyenDePayement: moyenDePayement,
                          lieuDeLivraison: lieu,
                          dateHeureDeLivraison: dateHeureDeLivraison,
                          produitsCommander: widget.produitsPanier,
                          localisationMagazin: locationMagasin,
                        )));
              }
              else{
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Panier2(
                          prixLivraison: prixLivraison,
                          total: widget.total,
                          nomComplet:  Renseignements.userData[2],
                          telephone:  Renseignements.userData[0],
                          lieuDeLivraison: lieu,
                          moyenDePayement: moyenDePayement,
                          dateHeureDeLivraison: dateHeureDeLivraison,
                          indication: indication,
                          quartier: quartier,
                          produitsCommander: widget.produitsPanier,
                          localisationMagazin: locationMagasin,
                        )));
              }
            },
            child: Text("CONTINUER",
              style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"
              ),),
          ),
          icon: Icon(Icons.location_on,size: 100,color: HexColor("#001C36")),
        ),
      );

    } else if (lieu == "A domicile" && indication != null && quartier != null &&
        moyenDePayement != null) {
      if (stopSommeLivraisonRetour == 0) {
        if (DateTime
            .now()
            .weekday == 7) {
          setState(() {
            prixLivraison = prixLivraison*2;
            stopSommeLivraisonRetour++;
          });
        } else {
          setState(() {
            stopSommeLivraisonRetour++;
          });
        }
      }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: "Livraison",
          description:
          "Le temps estimatif de la livraison est entre 60 et 90 minutes. Nos heures de livraison sont entre 10H - 18H",
          cancelButton: FlatButton(
            onPressed: () {
              Navigator.of(context).pop(); // To close the dialog
            },
            child: Text(
              "ANNULER",
              style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),
            ),
          ),
          nextButton: FlatButton(
            onPressed: () {
              if (lieu == "En Agence" && locationMagasin!=null) {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Panier2(
                          prixLivraison: prixLivraison,
                          total: widget.total,
                          nomComplet:  Renseignements.userData[2],
                          telephone:  Renseignements.userData[0],
                          moyenDePayement: moyenDePayement,
                          lieuDeLivraison: lieu,
                          dateHeureDeLivraison: dateHeureDeLivraison,
                          produitsCommander: widget.produitsPanier,
                          localisationMagazin: locationMagasin,
                        )));
              } else {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Panier2(
                          prixLivraison: prixLivraison,
                          total: widget.total,
                          nomComplet:  Renseignements.userData[2],
                          telephone:  Renseignements.userData[0],
                          lieuDeLivraison: lieu,
                          moyenDePayement: moyenDePayement,
                          dateHeureDeLivraison: dateHeureDeLivraison,
                          indication: indication,
                          quartier: quartier,
                          produitsCommander: widget.produitsPanier,
                          localisationMagazin: locationMagasin,
                        )));
              }
            },
            child: Text(
              "CONTINUER",
              style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),
            ),
          ),
          icon: Icon(
            Icons.local_shipping,
            size: 100,
            color: HexColor("#001C36"),
          ),
        ),
      );
    } else {
      displaySnackBarNom(
          context, "Veuillez remplir tous les champs ", Colors.white);
    }
  }
}