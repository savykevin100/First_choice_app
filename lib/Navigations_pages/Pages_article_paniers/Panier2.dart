import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Composants/databaseClient.dart';
import 'package:premierchoixapp/Design/CustomDialog.dart';
import 'package:premierchoixapp/Models/commandes.dart';
import 'package:premierchoixapp/Models/panier_classe.dart';
import 'package:premierchoixapp/Models/panier_classe_sqflite.dart';
import 'package:premierchoixapp/Models/produit.dart';

import '../../Drawer/Commande/commande_send.dart';


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
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
  String lieuAgence;


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
         if(widget.indication==null)
           widget.indication=value.data["agence"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.indication!=null) {
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
                      color: HexColor("#FFFFFF").withOpacity(1),
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
                                          fontFamily: "MonseraRegular"
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
                                          fontFamily: "MonseraRegular"
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

                                          fontFamily: "MonseraRegular"
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
                                      "$widget.indication",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: HexColor("#909090"),
                                        fontSize: 12,
                                        fontFamily: "MonseraRegular",
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
                                      top: longueurPerCent(0, context),
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
                                            fontSize: 13,
                                            fontFamily: "MonseraBold"),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                                top: longueurPerCent(
                                                    0, context),
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
                                                      "assets/images/icone moyen de paiement-01.png")),
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
                                              color: Colors.red,
                                              fontSize: 12.0,
                                              fontFamily: 'MonseraBold'),
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
                                        "Saisisssez un numéro Mobile Money",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              top: longueurPerCent(
                                                  0, context),
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
                                                    "assets/images/icone moyen de paiement-02.png")),
                                          ),
                                        ),

                                        hintStyle: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.0,
                                            fontFamily: 'MonseraBold'),

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
                                                  child: CachedNetworkImage(
                                                  imageUrl: widget
                                                          .produitsCommander[i]
                                                      ["image1"],
                                                  imageBuilder: (context, imageProvider) => Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder: (context, url) => LinearProgressIndicator(backgroundColor:HexColor("EFD807"),
                                                    ),
                                                  )
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
                                                              fontSize: 12,
                                                              fontFamily:
                                                              "Monserat_Regular"),
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
                                                            fontSize: 10,
                                                            fontFamily:
                                                            "MonseraBold",
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
                                                            size: 12,
                                                            couleur: HexColor(
                                                                "#00CC7b"),
                                                            police: "MonseraBold",
                                                          )
                                                      ),
                                                    ],
                                                  )),
                                            ),

                                          ],
                                        ));
                                  }),
                            ),
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
                                          police: "MonseraBold",
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
                                          police: "MonseraBold",
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
        appBar:  AppBar(
          backgroundColor: HexColor("#001c36"),
          title: Text(
            "Confirmation",
            style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
          ),
        ),
        body: Center(child: CircularProgressIndicator(),),
      );
    }
  }

  Future<void> checkSendCommand() async {
      if (widget.moyenDePayement ==
          "Mobile Money") {
        if (numeroDePayement.length == 8) {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              title: "Commande",
              description:
              "Une fois la commande lancée, vous ne pourrez plus l'annuler.",
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
                  Navigator.pop(context);
                  /*String username = 'QSUSR168';
                  String password = 'jf0Midq2LIdkAv4Ugi1B';
                  String transref = DateTime.now().toString().substring(10);


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
                        if(response.statusCode == 202) {
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
                                  if(response.statusCode == 200 ) {
                                    setState(() {
                                    });

                                    /*showLoadingDialog(context, _keyLoader);
                                    commandAction();
                                    Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                                        .pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CommandeSend()));*/
                                  }
                                  print("Reponse status pour le get status du payement: ${response.statusCode}");
                                  print("Response body : ${response.body}");
                                });
                        }
                         // commandAction();
                        print("Reponse status pour le request : ${response.statusCode}");
                        print("Response body : ${response.body}");
                      });*/

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  KKiaPay(
                      amount: totalPlusLivraison,
                      phone: '61000000',
                      data: 'hello world',
                      sandbox: true,
                      apikey: '5eff6ca0203711eba0637f280536fc17',
                      callback: sucessCallback,
                      name: widget.nomComplet,
                      theme: "#E30E25",
                    )),
                  );

                },
                child: Text("CONTINUER",
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 12.0,
                      fontFamily: "MonseraBold"
                  ),),
              ),
              icon: Icon(Icons.shopping_bag_rounded,size: 100,color: HexColor("#001C36")),
            ),
          );

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
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: "Commande",
            description:
            "Une fois la commande lancée, vous ne pourrez plus l'annuler.",
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
                commandAction();
                showLoadingDialog(context, _keyLoader);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommandeSend()));
              },
              child: Text("CONTINUER",
                style: TextStyle(
                    color: HexColor("#001C36"),
                    fontSize: 12.0,
                    fontFamily: "MonseraBold"
                ),),
            ),
            icon: Icon(Icons.shopping_bag_rounded,size: 100,color: HexColor("#001C36")),
          ),
        );
      }
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
                        Column(
                          children: [
                            Text("CHARGEMENT", style: TextStyle(
                                color: Colors.black, fontFamily: "Bold"),),
                            SizedBox(height: longueurPerCent(10, context),),
                          ],
                        )
                      ]),
                    )
                  ]));
        });
  }



  Future<void> commandAction() async {


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
    } catch (e) {
      print(e);
    }
  }

    displaySnackBarNom(BuildContext context, String text, Color couleur) {
      final snackBar = SnackBar(
        content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
        duration: Duration(seconds: 1),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

  void sucessCallback(response, context) {
    print(response);
    commandAction();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CommandeSend()
      ),
    );
  }

}




