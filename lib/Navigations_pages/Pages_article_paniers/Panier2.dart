import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Composants/databaseClient.dart';
import 'package:premierchoixapp/Models/commandes.dart';
import 'package:premierchoixapp/Models/panier_classe.dart';
import 'package:premierchoixapp/Models/panier_classe_sqflite.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:http_auth/http_auth.dart';

import 'commande_send.dart';


// ignore: must_be_immutable
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
  String moyenDePayement;

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
        this.moyenDePayement,
        this.produitsCommander});

  @override
  _Panier2State createState() => _Panier2State();
}

class _Panier2State extends State<Panier2> {
  TextEditingController _textFieldControllerNumero = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  bool _isEnabledPayement = true;
  bool _isEnabled = true;

  Firestore _db = Firestore.instance;
  List<String> idProduitsPanier = [];
  int numberOrder=0;
  String idCommandeUser;
  int totalPlusLivraison;
  String numeroDePayement = "0";
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Table qui contient les éléments du panier
  List<PanierClasseSqflite> panierItems = [];

  void getDataPanier() {
    DatabaseClient().readPanierData().then((value) {
      setState(() {
        panierItems = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.moyenDePayement == "Mobile Money") {
      setState(() {
        _isEnabledPayement = false;
      });
    }
    setState(() {
      totalPlusLivraison = widget.total + widget.prixLivraison;
    });
    getNumberOrder();
    getDataPanier();
  }


  Future<void> getNumberOrder() async {
    await _db
        .collection("Informations_générales").document("78k1bDeNwVHCzMy8hMGh")
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
          numberOrder = value.data["nombreCommande"]+1;
          print(numberOrder);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chargement == false && idProduitsPanier != null) {
      return Scaffold(
          backgroundColor: HexColor("#F5F5F5"),
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: HexColor("#001c36"),
            title: Text(
              "Confirmation",
              style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: longueurPerCent(420, context),
                      color: HexColor("#F5F5F5"),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: longueurPerCent(20, context),

                            ),
                            Container(
                              width: longueurPerCent(330, context),
                              margin: EdgeInsets.only(
                                  top: longueurPerCent(0.0, context),
                                  right: longueurPerCent(0.0, context),
                                  left: longueurPerCent(30.0, context),
                                  bottom: longueurPerCent(5, context)),
                              child: Text(
                                "Info Client",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 15,
                                    fontFamily: "MonseraBold"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: longueurPerCent(20, context),
                                  right: longueurPerCent(20, context),
                                  bottom: longueurPerCent(10.0, context)),
                              width: longueurPerCent(330, context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: longueurPerCent(10, context),
                                        bottom:
                                        longueurPerCent(3.0, context),
                                        top: longueurPerCent(6, context)),
                                    child: Text(
                                      widget.nomComplet,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: HexColor("#909090"),
                                          fontSize: 12,
                                          fontFamily: "MonseraBold"
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: longueurPerCent(10, context),
                                      bottom: longueurPerCent(0.0, context),
                                    ),
                                    child: Text(
                                      widget.telephone,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: HexColor("#909090"),
                                          fontSize: 12,
                                          fontFamily: "MonseraBold"
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.grey,
                              margin: EdgeInsets.only(
                                  left: longueurPerCent(10, context),
                                  right: longueurPerCent(10, context)),
                              height: longueurPerCent(0.5, context),
                            ),
                            SizedBox(height: longueurPerCent(10, context),),
                            (widget.lieuDeLivraison == "A domicile")
                                ? Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: longueurPerCent(0.0, context),
                                      right:
                                      longueurPerCent(0.0, context),
                                      left:
                                      longueurPerCent(30.0, context),
                                      bottom:
                                      longueurPerCent(5.0, context)),

                                  child: Text(
                                    "Adresse de Livraison",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: HexColor("#001C36"),
                                        fontSize: 15,
                                        fontFamily: "MonseraBold"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: longueurPerCent(20, context),
                                      right: longueurPerCent(20, context),
                                      bottom:
                                      longueurPerCent(10.0, context)),
                                  width: largeurPerCent(370, context),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: longueurPerCent(
                                            10, context),
                                        bottom: longueurPerCent(
                                            10.0, context),
                                        top: longueurPerCent(
                                            6, context)),
                                    child: Text(
                                      widget.quartier +
                                          ", " +
                                          widget.indication,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: HexColor("#909090"),
                                          fontSize: 12,

                                          fontFamily: "MonseraBold"
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: longueurPerCent(0.0, context),
                                      right:
                                      longueurPerCent(0.0, context),
                                      left:
                                      longueurPerCent(30.0, context),
                                      bottom:
                                      longueurPerCent(5.0, context)),
                                  child: Text(
                                    "Adresse de Livraison",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: HexColor("#001C36"),
                                        fontSize: 15,
                                        fontFamily: "MonseraBold"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: longueurPerCent(20, context),
                                      right: longueurPerCent(20, context),
                                      bottom:
                                      longueurPerCent(10.0, context)),
                                  width: largeurPerCent(370, context),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: longueurPerCent(
                                            10, context),
                                        bottom: longueurPerCent(
                                            0.0, context),
                                        top: longueurPerCent(
                                            6, context)),
                                    child: Text(
                                      "Jonquet en face pharmacie. Immeuble blanc, 2ème étage.",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: HexColor("#909090"),
                                        fontSize: 12,
                                        fontFamily: "MonseraBold",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.grey,
                              margin: EdgeInsets.only(
                                  left: longueurPerCent(10, context),
                                  right: longueurPerCent(10, context)),
                              height: longueurPerCent(0.5, context),
                            ),
                            SizedBox(height: longueurPerCent(10, context),),
                            Container(
                              margin: EdgeInsets.only(
                                top: longueurPerCent(0.0, context),
                                right: longueurPerCent(0.0, context),
                                left: longueurPerCent(30.0, context),
                                bottom: longueurPerCent(5.0, context),
                              ),
                              child: Text(
                                "Moyen de payement",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 15,
                                    fontFamily: "MonseraBold"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: longueurPerCent(20, context),
                                  right: longueurPerCent(20, context),
                                  bottom: longueurPerCent(0.0, context)),
                              width: longueurPerCent(330, context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  (widget.moyenDePayement != "Mobile Money")
                                      ? Container(
                                    margin: EdgeInsets.only(
                                      left: longueurPerCent(5, context),
                                      right:
                                      longueurPerCent(5, context),
                                      top: longueurPerCent(5, context),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7.0),
                                      ),
                                    ),
                                    child: TextField(
                                        controller:
                                        _textFieldController,
                                        //Set this field to enable or disable (true or flase)
                                        enabled: !_isEnabled,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "MonseraBold"),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                                top: longueurPerCent(
                                                    5, context),
                                                bottom: longueurPerCent(
                                                    5, context),
                                                right: largeurPerCent(
                                                    10, context),
                                                left: largeurPerCent(
                                                    10, context)),
                                            child: Card(
                                              child: Container(
                                                  height:
                                                  longueurPerCent(
                                                      40, context),
                                                  child: Image.asset(
                                                      "assets/images/images-03.png")),
                                            ),
                                          ),
                                          suffixIcon:
                                          (widget.moyenDePayement !=
                                              "Mobile Money")
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                top: longueurPerCent(
                                                    5,
                                                    context),
                                                bottom:
                                                longueurPerCent(
                                                    5,
                                                    context),
                                                right: largeurPerCent(
                                                    10,
                                                    context),
                                                left: largeurPerCent(
                                                    10,
                                                    context)),

                                          )
                                              : Text(""),
                                          hintText: "Espèce",
                                          hintStyle: TextStyle(
                                              color:
                                              HexColor("#909090"),
                                              fontSize: 15.0,
                                              fontFamily:
                                              'MonseraBold'),
                                          fillColor: Colors.white,
                                          contentPadding:
                                          EdgeInsets.only(
                                              top: 30,
                                              bottom: 5,
                                              left: 30),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      7.0)),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle
                                                      .none)),
                                        ),
                                        onChanged: (value) {}),
                                  )
                                      : Container(
                                    margin: EdgeInsets.only(
                                      left: longueurPerCent(0, context),
                                      right:
                                      longueurPerCent(5, context),
                                      bottom:
                                      longueurPerCent(5, context),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7.0),
                                      ),
                                    ),
                                    child: TextFormField(
                                      keyboardType:
                                      TextInputType.number,
                                      controller:
                                      _textFieldControllerNumero,
                                      //Set this field to enable or disable (true or flase)
                                      enabled: !_isEnabledPayement,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: HexColor("#909090"),
                                          fontFamily: "Montserrat_Light"),
                                      decoration: InputDecoration(
                                        hintText:
                                        "Saisir numéro Mobile Money",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              top: longueurPerCent(
                                                  5, context),
                                              bottom: longueurPerCent(
                                                  5, context),
                                              right: largeurPerCent(
                                                  10, context),
                                              left: largeurPerCent(
                                                  17, context)),
                                          child: Card(
                                            child: Container(
                                                height: longueurPerCent(
                                                    40, context),
                                                child: Image.asset(
                                                    "assets/images/new_logo_mtn_momo1.jpg")),
                                          ),
                                        ),

                                        hintStyle: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.0,
                                            fontFamily: 'MonseraLight'),

                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.only(
                                            top: 30,
                                            bottom: 5,
                                            left: 30),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    7.0)),
                                            borderSide: BorderSide(
                                                width: 0,
                                                style:
                                                BorderStyle.none)),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          numeroDePayement = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.grey,
                              margin: EdgeInsets.only(
                                  left: longueurPerCent(10, context),
                                  right: longueurPerCent(10, context)),
                              height: longueurPerCent(0.5, context),
                            ),
                            SizedBox(height: longueurPerCent(10, context),),
                            Container(
                              margin: EdgeInsets.only(
                                top: longueurPerCent(0.0, context),
                                right: longueurPerCent(0.0, context),
                                left: longueurPerCent(30.0, context),
                                bottom: longueurPerCent(5.0, context),
                              ),
                              child: Text(
                                "Produits",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 15,
                                    fontFamily: "MonseraBold"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: longueurPerCent(20, context),
                                  right: longueurPerCent(20, context),
                                  bottom: longueurPerCent(10.0, context)),
                              width: longueurPerCent(330, context),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                  widget.produitsCommander.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                        margin: EdgeInsets.only(
                                          top: longueurPerCent(0, context),
                                          left: longueurPerCent(5, context),
                                          right:
                                          longueurPerCent(5, context),
                                          bottom:
                                          longueurPerCent(5, context),
                                        ),
                                        height:
                                        longueurPerCent(80, context),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.only(
                                                  top: longueurPerCent(
                                                      5, context),
                                                  bottom: longueurPerCent(
                                                      10, context),
                                                  left: longueurPerCent(
                                                      0, context),
                                                ),
                                                height: longueurPerCent(
                                                    100, context),
                                                width: largeurPerCent(
                                                    80, context),
                                                child: Card(
                                                  child: Image.network(widget
                                                      .produitsCommander[
                                                  i]["image1"],
                                                    fit: BoxFit.cover,),
                                                )),
                                            Expanded(
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      top:
                                                      longueurPerCent(
                                                          0, context),
                                                      left:
                                                      longueurPerCent(
                                                          0,
                                                          context)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height:
                                                        longueurPerCent(
                                                            2,
                                                            context),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 10, top: 12),
                                                        child: Text(
                                                          widget
                                                              .produitsCommander[
                                                          i][
                                                          "nomDuProduit"],
                                                          textAlign:
                                                          TextAlign
                                                              .left,
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  "#909090"),
                                                              fontSize: 16,
                                                              fontFamily:
                                                              "Regular"),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        longueurPerCent(
                                                            2.0,
                                                            context),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(left: 10),
                                                        child: Text(
                                                          "${widget
                                                              .produitsCommander[i]["taille"]}",
                                                          textAlign:
                                                          TextAlign
                                                              .left,
                                                          style: TextStyle(
                                                            color: HexColor(
                                                                "#001C36"),
                                                            fontSize: 12,
                                                            fontFamily:
                                                            "MontserratBold",
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        longueurPerCent(
                                                            4.0,
                                                            context),
                                                      ),
                                                      Padding(
                                                          padding: const EdgeInsets
                                                              .only(left: 10),
                                                          child: PriceWithDot(
                                                            price: widget
                                                                .produitsCommander[i]["prix"],
                                                            size: 14,
                                                            couleur: HexColor(
                                                                "#00CC7b"),
                                                            police: "MontserratBold",
                                                          )
                                                      ),
                                                    ],
                                                  )),
                                            ),

                                          ],
                                        ));
                                  }),
                            ),
                            //Mettre un singlescrollview ici
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Material(
                          elevation: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: longueurPerCent(20, context),
                                    right: longueurPerCent(20, context),
                                    bottom: longueurPerCent(10.0, context)),
                                width: longueurPerCent(400, context),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: longueurPerCent(20, context),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: longueurPerCent(
                                                  0.0, context),
                                              right:
                                              longueurPerCent(0.0, context),
                                              left:
                                              longueurPerCent(10.0, context)),
                                          child: Text(
                                            "Sous-Total",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: HexColor("#909090"),
                                                fontSize: 12,
                                                fontFamily: "MonseraBold"),
                                          ),
                                        ),
                                        PriceWithDot(price: widget.total,
                                          size: 12,
                                          couleur: HexColor("#909090"),
                                          police: "MontserratBold",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: longueurPerCent(10, context),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: longueurPerCent(
                                                  0.0, context),
                                              right:
                                              longueurPerCent(0.0, context),
                                              left:
                                              longueurPerCent(10.0, context)),
                                          child: Text(
                                            "Livraison  ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: HexColor("#909090"),
                                                fontSize: 12,
                                                fontFamily: "MonseraBold"),
                                          ),
                                        ),
                                        PriceWithDot(
                                          price: widget.prixLivraison,
                                          size: 12,
                                          couleur: HexColor("#909090"),
                                          police: "MontserratBold",
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: longueurPerCent(10, context),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: longueurPerCent(
                                                  0.0, context),
                                              right:
                                              longueurPerCent(0.0, context),
                                              left:
                                              longueurPerCent(10.0, context)),
                                          child: Text(
                                            "Total",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: HexColor("#001C36"),
                                              fontSize: 15,
                                              fontFamily: "MonseraBold",
                                            ),
                                          ),
                                        ),
                                        PriceWithDot(price: totalPlusLivraison,
                                          size: 15,
                                          couleur: HexColor("#001C36"),
                                          police: "MonseraBold",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: longueurPerCent(20, context)),
                              button(HexColor("#FFFFFF"), HexColor("#001C36"),
                                  context, 'COMMANDER', () =>checkSendCommand())
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

  Future<void> checkSendCommand() async {
      if (widget.moyenDePayement ==
          "Mobile Money") {
        if (numeroDePayement.length == 8) {

          String username = 'QSUSR168';
          String password = 'jf0Midq2LIdkAv4Ugi1B';
          String transref = numberOrder.toString();


          var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));

          final ioc = new HttpClient();
          ioc.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          final http = new IOClient(ioc);

          //RequestPayment Request

          http.post('https://qosic.net:8443/QosicBridge/user/requestpayment',
              headers: {HttpHeaders.authorizationHeader: auth,
                "Content-Type": "application/json"
              },
              body:  jsonEncode({
                "msisdn": "229$numeroDePayement",
                "amount": totalPlusLivraison,
                "nameUser": widget.nomComplet,
                "transref": transref,
                "clientid": "1erChoix8S"
              })
          ).then(
                  (response) {
                    if(response.statusCode == 202)
                     // commandAction();
                print("Reponse status : ${response.statusCode}");
                print("Response body : ${response.body}");
              });


          // Get RequestPayement status

          http.post('https://qosic.net:8443/QosicBridge/user/gettransactionstatus',
              headers: {HttpHeaders.authorizationHeader: auth,
                "Content-Type": "application/json"
              },
              body:  jsonEncode({                                                                                                                                                                                                   
                "transref": transref,
                "clientid": "1erChoix8S"
              })
          ).then(
                  (response) {
                    if(response.statusCode == 200 )
                      //commandAction();
                print("Reponse status : ${response.statusCode}");
                print("Response body : ${response.body}");
              });



        } else if (numeroDePayement == "0") {
          displaySnackBarNom(
              context,
              "Veuillez entrer votre numéro de payement",
              Colors.white);
        } else if (numeroDePayement.length != 8)
          displaySnackBarNom(
              context,
              "Veuillez entrer un numéro de téléphone valide",
              Colors.white);
      } else {
        commandAction();
      }
  }


  Future<void> commandAction() async {

    setState(() {
      chargement=true;
    });
    for(int i=0; i<panierItems.length; i++){
      setState(() {
        DatabaseClient().deleteItemPanier(panierItems[i].id , "panier");
      });
    }

    for(int i=0; i<widget.produitsCommander.length; i++){
      _db .collection("ProduitsIndisponibles").where("image1", isEqualTo:widget.produitsCommander[i]["image1"])
          .getDocuments().then((QuerySnapshot snapshot){
        if(snapshot.documents.isEmpty){
          setState(() {
            FirestoreService().produitsIndisponibles(PanierClasse(
              nomDuProduit:widget.produitsCommander[i]["nomDuProduit"],
              image1:widget.produitsCommander[i]["image1"],
              prix:widget.produitsCommander[i]["prix"],
              idProduitCategorie: widget.produitsCommander[i]["idProduitCategorie"],
              description:widget.produitsCommander[i]["description"],
            ));
          });
        }
      });
    }


    _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .updateData({"nbAjoutPanier": 0});

    _db
        .collection("Informations_générales")
        .document("78k1bDeNwVHCzMy8hMGh")
        .updateData({"nombreCommande": numberOrder});



    try {
      await _db
          .collection("Utilisateurs")
          .document(Renseignements.emailUser)
          .collection("Commandes")
          .add({
        "nomComplet": widget.nomComplet,
        "telephone": widget.telephone,
        "quartier": widget.quartier,
        "indication": widget.indication,
        "dateHeureDeLivraison": widget.dateHeureDeLivraison,
        "total": widget.total,
        "sousTotal": totalPlusLivraison,
        "moyenDePayement": widget.moyenDePayement,
        "numeroDePayement": numeroDePayement,
        "produitsCommander": widget.produitsCommander,
        "prixLivraison": widget.prixLivraison,
        "lieuDeLivraison": widget.lieuDeLivraison,
        "numberOrder": numberOrder,
        "livrer": "En cours",
        "created": DateTime.now().toString(),
      }).then((value) {
        setState(() {
          idCommandeUser = value.documentID;
        });
        this
            ._db
            .collection("Utilisateurs")
            .document(Renseignements.emailUser)
            .collection("Commandes")
            .document(value.documentID)
            .updateData({"id": value.documentID});
      });


      FirestoreService().addCommandeToAdmin(
        Commandes(
            nomComplet: widget.nomComplet,
            telephone: widget.telephone,
            quartier: widget.quartier,
            indication: widget.indication,
            total: widget.total,
            sousTotal: totalPlusLivraison,
            moyenDePayement: widget.moyenDePayement,
            numeroDePayement: numeroDePayement,
            produitsCommander: widget.produitsCommander,
            prixLivraison: widget.prixLivraison,
            lieuDeLivraison: widget.lieuDeLivraison,
            created: DateTime.now().toString(),
            numberOrder: numberOrder,
            idCommandeUser: idCommandeUser,
            livrer: "En cours"),
      );
      setState(() {
        chargement=false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CommandeSend()));
    } catch (e) {
      print(e);
    }
  }

    displaySnackBarNom(BuildContext context, String text, Color couleur) {
      final snackBar = SnackBar(
        content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
