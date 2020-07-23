import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/panier_classe.dart';



class Panier extends StatefulWidget {
  static String id='Panier';
  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  bool value;
  Firestore _db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#F5F5F5"),
        appBar: AppBar(
          backgroundColor: HexColor("#001c36"),
          title: Text("Panier", style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_basket),
              color: Colors.white,
              onPressed: (){
                setState(() {
                  // A toi de jouer
                });
              },
            ),
          ],
        ),
        body:ListView(
          children: <Widget>[
            StreamBuilder(
              stream: FirestoreService().getProduitPanier(Renseignements.emailUser),
                builder: (BuildContext context,AsyncSnapshot<List<PanierClasse>> snapshot){
                  if(snapshot.hasError || !snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i){
                          PanierClasse panier=PanierClasse();
                          return Container(
                            margin: EdgeInsets.only(
                              left: longueurPerCent(18.0, context),top: longueurPerCent(50, context),
                              right: longueurPerCent(15.0, context),),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.white,
                            ),
                            child: Card(
                              elevation: 5.0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: longueurPerCent(10.0, context),
                                      top: longueurPerCent(0.0, context),),
                                    height: longueurPerCent(100.0, context),
                                    width: largeurPerCent(85.5, context),
                                    child: Center(
                                      child: Container(
                                        height: longueurPerCent(70.0, context),
                                        width: largeurPerCent(100.0, context),
                                        child: Image.network(
                                          panier.image1,
                                          fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: longueurPerCent(50, context),
                                            left: longueurPerCent(50.0, context)),
                                        child: Text(
                                          "${panier.nomDuProduit}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: HexColor("#909090"),
                                              fontSize: 18,
                                              fontFamily: "Regular"),
                                        ),
                                      ),
                                      SizedBox(height: longueurPerCent(4.0, context),),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: longueurPerCent(93, context),
                                            left: longueurPerCent(50.0, context)),
                                        child: Text(
                                          "Rouge - 43",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: HexColor("#001C36"),
                                            fontSize: 12,
                                            fontFamily: "MontserratBold",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: longueurPerCent(4.0, context),),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: longueurPerCent(66, context),
                                            left: longueurPerCent(50.0, context)),
                                        child: Text(
                                          '${ panier.prix}',
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
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red, size: 20,),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }
            )
          ],
        )
    );
  }
}


/*Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: longueurPerCent(18.0, context),top: longueurPerCent(50, context),
                  right: longueurPerCent(15.0, context),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: longueurPerCent(0.0, context),
                        top: longueurPerCent(0.0, context),),
                      height: longueurPerCent(100.0, context),
                      width: largeurPerCent(85.5, context),
                      child: Center(
                        child: Container(
                          height: longueurPerCent(70.0, context),
                          width: largeurPerCent(65.0, context),
                          child: Image.asset(
                            "assets/images/gadgets-336635_1920.jpg",
                            fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              right: longueurPerCent(50, context),
                              left: longueurPerCent(4.0, context)),
                          child: Text(
                            "Sneekers ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 18,
                                fontFamily: "Regular"),
                          ),
                        ),
                        SizedBox(height: longueurPerCent(4.0, context),),
                        Container(
                          margin: EdgeInsets.only(
                              right: longueurPerCent(93, context),
                              left: longueurPerCent(4.0, context)),
                          child: Text(
                            "Rouge - 43",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 12,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: longueurPerCent(4.0, context),),
                        Container(
                          margin: EdgeInsets.only(
                              right: longueurPerCent(66, context),
                              left: longueurPerCent(4.0, context)),
                          child: Text(
                            "1.000 F CFA",
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
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red, size: 20,),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                top: longueurPerCent( MediaQuery.of(context).size.height,context),
                child:   button(HexColor("#001C36"), HexColor("#FFC30D"), context, "ACHETER", (){
                }),),
              SizedBox(height: longueurPerCent(50.0, context),),
              new Container(),
            ],
          ),*/


/*  Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: largeurPerCent(10, context), top: longueurPerCent(17, context)),
                    child: Text(
                      "Ajouts récents",
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontFamily: 'MontserratBold',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: largeurPerCent(90, context), top: longueurPerCent(17, context), right: largeurPerCent(10, context)),
                    child: Text(
                      "Tout sélectionner",
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontFamily: 'MontserratBold',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),*/