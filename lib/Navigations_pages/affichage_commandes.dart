import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Models/commandes.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';

import 'Widgets/DetailsCommandes.dart';

class AffichageCommandes extends StatefulWidget {
  @override
  _AffichageCommandesState createState() => _AffichageCommandesState();
}

class _AffichageCommandesState extends State<AffichageCommandes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StreamBuilder(
          stream: FirestoreService().getUserOrder(Renseignements.emailUser),
            builder:
                (BuildContext context, AsyncSnapshot<List<Commandes>> snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data.isEmpty) {
                return elementsVides(context, Icons.local_grocery_store, "Pas de commandes effectuées");
              } else {
                    return  Container(
                            margin: EdgeInsets.only(top: longueurPerCent(30, context), left: largeurPerCent(20, context), right: largeurPerCent(20, context), ),
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i){
                                  Commandes commande = snapshot.data[i];
                                  return  Container(
                                    margin: EdgeInsets.only(bottom: longueurPerCent(20, context)),
                                    width: largeurPerCent(360.0, context),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
                                      elevation: 7.0,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            child: Material(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                                              color: HexColor("#FFC30D"),
                                              child: Padding(
                                                padding: EdgeInsets.all(longueurPerCent(10, context)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(commande.created,   style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 12.0, fontWeight: FontWeight.bold ),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: longueurPerCent(10, context),),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: longueurPerCent(0.0, context),
                                                    right: longueurPerCent(0.0, context),
                                                    left: longueurPerCent(10.0, context)),
                                                child: Text(
                                                  "Nbre de produits",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: HexColor("#909090"),
                                                      fontSize: 12,
                                                      fontFamily: "MonseraBold"),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 7,
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.only(right: largeurPerCent(12, context)),
                                                  child: Text(
                                                    "${commande.produitsCommander.length}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: HexColor("#001C36"),
                                                      fontSize: 12,
                                                      fontFamily: "MontserratBold",
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: longueurPerCent(10, context),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: longueurPerCent(0.0, context),
                                                    right: longueurPerCent(0.0, context),
                                                    left: longueurPerCent(10.0, context)),
                                                child: Text(
                                                  "Total        ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: HexColor("#909090"),
                                                      fontSize: 12,
                                                      fontFamily: "MonseraBold"),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.only(right: longueurPerCent(12, context)),
                                                child: PriceWithDot(price: commande.sousTotal, size:12 ,
                                                  couleur: HexColor("#001C36"), police:  "MontserratBold",
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: longueurPerCent(10, context),),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: longueurPerCent(0.0, context),
                                                    right: longueurPerCent(0.0, context),
                                                    left: longueurPerCent(10.0, context)),
                                                child: Text(
                                                  "Statut",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: HexColor("#909090"),
                                                      fontSize: 12,
                                                      fontFamily: "MonseraBold"),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 7,
                                                child: Padding(
                                                    padding:
                                                    EdgeInsets.only(right: longueurPerCent(12, context)),
                                                    child:statutCommande((commande.livrer))
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height:longueurPerCent(20.0, context)),
                                          Container(
                                            margin: EdgeInsets.only(bottom: longueurPerCent(10, context), ),
                                            height: longueurPerCent(30.0, context),
                                            width: largeurPerCent(100.0, context),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                                  return DetailsCommandes(commande: commande.toMap(), longueur: commande.produitsCommander.length);
                                                }));
                                              },
                                              child: Material(
                                                borderRadius: BorderRadius.circular(3.0),
                                                color: HexColor("#001C36"),
                                                elevation: 7.0,
                                                child: Center(
                                                  child: Text(
                                                    'VOIR',
                                                    style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 12.0, fontWeight: FontWeight.bold ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            )
                        );
              }
            }

            ),
      ),
    );
  }
  Widget statutCommande(String statut){
    if(statut=="En cours"){
      return Text(
          "En cours",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontFamily: "MontserratBold",
            fontWeight: FontWeight.bold,
          ));
    } else if(statut=="Livrer"){
      return Text(
          "Livrer",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontFamily: "MontserratBold",
            fontWeight: FontWeight.bold,
          ));
    } else {
      return Text(
          "Annuler",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontFamily: "MontserratBold",
            fontWeight: FontWeight.bold,
          ));
    }
  }
}
