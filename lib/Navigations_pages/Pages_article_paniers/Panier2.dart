import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Models/commandes.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/commande_send.dart';

class Panier2 extends StatefulWidget {
  static String id = 'Panier2';
  String nomComplet;
  String telephone;
  String lieuDeLivraison;
  String quartier;
  String indication;
  String dateHeureDeLivraison;
  int total;
  int prixLivraison;
  Produit unSeulProduit;
  List<Map<String, dynamic>> produitsCommander;

  Panier2(
      {this.unSeulProduit,
      this.prixLivraison,
      this.nomComplet,
      this.total,
      this.telephone,
      this.lieuDeLivraison,
      this.quartier,
      this.indication,
      this.dateHeureDeLivraison,
      this.produitsCommander});

  @override
  _Panier2State createState() => _Panier2State();
}

class _Panier2State extends State<Panier2> {
  String moyenDePayement;
  String _dropDownValue2;
  String numeroDePayement;
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.total = widget.total + widget.prixLivraison;
  }

  @override
  Widget build(BuildContext context) {
    if (chargement == false) {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: HexColor("#001c36"),
            title: Text(
              "Panier",
              style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
            ),
          ),
          body: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: longueurPerCent(0.0, context),
                            right: longueurPerCent(0.0, context),
                            left: longueurPerCent(30.0, context)),
                        child: Text(
                          "SOUS TOTAL",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 18,
                              fontFamily: "Montserrat_Light"),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: largeurPerCent(90, context)),
                        child: Text(
                          "${widget.total} FCFA",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: HexColor("#909090"),
                            fontSize: 16,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: longueurPerCent(20.0, context),
                            right: longueurPerCent(0.0, context),
                            left: longueurPerCent(30.0, context)),
                        child: Text(
                          "LIVRAISON",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 18,
                              fontFamily: "Montserrat_Light"),
                        ),
                      ),
                      Container(
                        width: largeurPerCent(190.0, context),
                        margin: EdgeInsets.only(
                            top: longueurPerCent(20.0, context),
                            left: longueurPerCent(0.0, context)),
                        child: Text(
                          "${widget.prixLivraison}  FCFA",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: HexColor("#909090"),
                            fontSize: 16,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: longueurPerCent(20.0, context),
                            right: longueurPerCent(0.0, context),
                            left: longueurPerCent(40.0, context)),
                        child: Text(
                          "TOTAL",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 18,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: largeurPerCent(190.0, context),
                        margin: EdgeInsets.only(
                            top: longueurPerCent(20.0, context),
                            right: longueurPerCent(25.0, context),
                            left: longueurPerCent(20.0, context)),
                        child: Text(
                          "${widget.total} FCFA",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 16,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: longueurPerCent(25, context),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(30.0, context)),
                          child: Text(
                            "Moyen DePayement",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 16,
                                fontFamily: "MontserratBold",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(20.0, context)),
                          width: largeurPerCent(180.0, context),
                          height: longueurPerCent(40, context),
                          padding: EdgeInsets.only(
                              left: largeurPerCent(20, context),
                              right: largeurPerCent(20, context),
                              top: longueurPerCent(0, context)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
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
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: longueurPerCent(30.0, context),
                            right: longueurPerCent(0.0, context),
                            left: longueurPerCent(50.0, context)),
                        child: Text(
                          "Numéro:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 18,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: largeurPerCent(190.0, context),
                        margin: EdgeInsets.only(
                            top: longueurPerCent(30.0, context),
                            right: longueurPerCent(0.0, context),
                            left: longueurPerCent(30.0, context)),
                        child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "61831183",
                              hintStyle: TextStyle(
                                  color: HexColor('#919191'),
                                  fontSize: 17.0,
                                  fontFamily: 'MonseraLight'),
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.only(top: 10, bottom: 5, left: 30),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                      width: 1, style: BorderStyle.none)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                numeroDePayement = value;
                              });
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: longueurPerCent(100.62, context)),
                  button(HexColor("#FFFFFF"), HexColor("#001C36"), context,
                      'COMMANDER', () {
                    if (numeroDePayement != null && moyenDePayement != null) {
                      setState(() {
                        chargement = true;
                      });
                      try {
                        FirestoreService().addCommande(
                            Commandes(
                                nomComplet: widget.nomComplet,
                                telephone: widget.telephone,
                                quartier: widget.quartier,
                                indication: widget.indication,
                                dateHeureDeLivraison:
                                    widget.dateHeureDeLivraison,
                                total: widget.total,
                                moyenDePayement: moyenDePayement,
                                numeroDePayement: numeroDePayement,
                                produitsCommander: widget.produitsCommander,
                                prixLivraison: widget.prixLivraison,
                                lieuDeLivraison: widget.lieuDeLivraison,
                                livrer: false,
                                unSeulProduit: widget.unSeulProduit,
                                created: DateTime.now().toString()),
                            Renseignements.emailUser);
                        FirestoreService().addCommandeToAdmin(
                            Commandes(
                                nomComplet: widget.nomComplet,
                                telephone: widget.telephone,
                                quartier: widget.quartier,
                                indication: widget.indication,
                                dateHeureDeLivraison:
                                    widget.dateHeureDeLivraison,
                                total: widget.total,
                                unSeulProduit: widget.unSeulProduit,
                                moyenDePayement: moyenDePayement,
                                numeroDePayement: numeroDePayement,
                                produitsCommander: widget.produitsCommander,
                                prixLivraison: widget.prixLivraison,
                                lieuDeLivraison: widget.lieuDeLivraison,
                                created: DateTime.now().toString(),
                                livrer: false),
                            Renseignements.emailUser);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommandeSend()));
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        chargement = true;
                      });
                    } else {
                      displaySnackBarNom(context,
                          "Veuillez remplir tous les champs", Colors.red);
                    }
                  }),
                ],
              ),
            ),
          ));
    } else {
      return Scaffold(
        backgroundColor: HexColor("#001C36"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 197,
                width: 278,
              ),
              SizedBox(
                height: 50.0,
              ),
              SpinKitThreeBounce(
                color: HexColor('#FFFFFF'),
                size: 60,
              )
            ],
          ),
        ),
      );
    }
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
