import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier2.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:search_choices/search_choices.dart';

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
  List<Map<String, dynamic>> quartiersDb = [];
  int stopSommeLivraisonRetour=0;

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
          ? ConnexionState(body: SingleChildScrollView(
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
                      fontSize: 19.0,
                      fontFamily: "MonseraBold",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context)),

              Center(
                child: Text(
                  name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 17.0,
                      fontFamily: "MonseraLight",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Container(
                  padding:EdgeInsets.all(longueurPerCent(10, context)),
                  child: Center(
                    child: Text(
                      numUser,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: HexColor("#001C36"),
                          fontSize: 17.0,
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
                margin: EdgeInsets.only(left: longueurPerCent(30, context),right: longueurPerCent(30, context)),
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
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'MonseraLight'),
                            )
                                : Text(
                              _dropDownValue,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: HexColor("#919191")),
                            items: ['En Agence', 'A domicile'].map(
                                  (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,  ),
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
                              padding: EdgeInsets.only(left: 0,right: 0),
                              width: longueurPerCent(347, context),
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
                          ),
                          SizedBox(
                            height: longueurPerCent(20.0, context),
                          ),
                          Center(
                            child: 	Container(
                              width: largeurPerCent(347, context),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Indication",
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                  ),
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
                                  fontSize: 16),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            items:
                            ['Mobile Money' ,'Mooov Money', 'Espèce'].map(
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
                  child: button(Colors.white, HexColor("#001C36"), context, 'CONFIRMER', () {
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




  showAlertDialog(BuildContext context, Widget text,) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("RETOUR",style: TextStyle(
          color: HexColor("#001C36"),
          fontSize: 15.0,
          fontFamily: "MonseraBold",
          fontWeight: FontWeight.bold)),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget nextButton = FlatButton(
      child: Text("CONTINUER",   style: TextStyle(
          color: HexColor("#001C36"),
          fontSize: 15.0,
          fontFamily: "MonseraBold",
          fontWeight: FontWeight.bold)),
      onPressed:  () {

      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text("AVIS",    style: TextStyle(
            color: Colors.red,
            fontSize: 30.0,
            fontFamily: "MonseraBold",
            fontWeight: FontWeight.bold)),
      ),
      content: text,
      actions: [
        cancelButton,
        nextButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  confirmationPopup(BuildContext dialogContext, Widget text) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
      descStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: "AVIS",
        content: text,
        buttons: [
          DialogButton(
            child: Text(
              "RETOUR",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontFamily: "MonseraBold",
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: HexColor("#001C36"),
          ),
          DialogButton(
            child: Text(
              "CONTINUER",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontFamily: "MonseraBold",
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if(lieu=="En Agence")
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Panier2(
                          prixLivraison: prixLivraison,
                          total: widget.total,
                          nomComplet: name,
                          telephone: numUser,
                          moyenDePayement: moyenDePayement,
                          lieuDeLivraison: lieu,
                          dateHeureDeLivraison: dateHeureDeLivraison,
                          produitsCommander: widget.produitsPanier,
                        )));
              else
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Panier2(
                          prixLivraison: prixLivraison,
                          total: widget.total,
                          nomComplet: name,
                          telephone: numUser,
                          lieuDeLivraison: lieu,
                          moyenDePayement: moyenDePayement,
                          dateHeureDeLivraison: dateHeureDeLivraison,
                          indication: indication,
                          quartier: quartier,
                          produitsCommander: widget.produitsPanier,
                        )));
            },
            color: HexColor("#001C36"),
          ),
        ]).show();
  }


  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void checkInformationsComplete(context) {
    if (lieu == 'En Agence'  && moyenDePayement!=null) {
      setState(() {
        prixLivraison = 0;
      });
      confirmationPopup(context, Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          Text("Heure d'ouverture: 9H - 20H", textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 15.0,
                fontFamily: "MonseraRegular",
                fontWeight: FontWeight.bold
            ),),
          SizedBox(height: longueurPerCent(15, context),),
          Text("L'agence est située à Joncquet  en face pharmacie. Immeuble blanc, 2ème étage.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 15.0,
                fontFamily: "MonseraRegular",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),);

    } else if (lieu == "A domicile" && indication != null && quartier != null && moyenDePayement!=null ) {
      _db.collection("Zones").getDocuments().then((value) {
        /// Ici on parcourt les zones écrites dans le Zones et on fait une comparaison en vue de retrouver le prix du quariter sélectionnné
        for (int i = 0; i < value.documents.length; i++) {
          if (value.documents[i].data.containsValue(quartier)) {
            if(stopSommeLivraisonRetour==0){
              if(DateTime.now().weekday==7){
                setState(() {
                  prixLivraison = value.documents[i].data["prix"]*2;
                  stopSommeLivraisonRetour++;
                });
              } else {
                setState(() {
                  prixLivraison = value.documents[i].data["prix"];
                  stopSommeLivraisonRetour++;
                });
              }
            }
          }
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        confirmationPopup(context,  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: longueurPerCent(15, context),),
            Text(
              "Le temps d'estimation de la livraison est entre 80 et 120 minutes",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:HexColor("#001C36"),
                  fontSize: 15.0,
                  fontFamily: "MonseraRegular",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: longueurPerCent(15, context),),
            Text("Nos heures de livraison sont entre 9H - 20H", textAlign: TextAlign.center,
              style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 15.0,
                  fontFamily: "MonseraRegular",
                  fontWeight: FontWeight.bold),),
            SizedBox(height: longueurPerCent(20, context),),

          ],
        ),);
      });
    } else {
      displaySnackBarNom(
          context, "Veuillez remplir tous les champs ", Colors.white);
    }
  }
}