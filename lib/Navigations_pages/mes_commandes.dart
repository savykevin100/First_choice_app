import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/DetailsCommandes.dart';

class MesCommandes extends StatefulWidget {
  @override
  _MesCommandesState createState() => _MesCommandesState();
}

class _MesCommandesState extends State<MesCommandes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des commandes"),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: longueurPerCent(20, context)),
                Container(
                  width: largeurPerCent(360.0, context),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                    elevation: 7.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: largeurPerCent(360.0, context),
                          child: Material(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                            color: HexColor("#FFC30D"),
                            child: Padding(
                              padding: EdgeInsets.all(longueurPerCent(10, context)),
                              child: Text(
                                "Commande n°1",
                                style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 19.0, fontWeight: FontWeight.bold ),
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
                              "2",
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
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(10.0, context)),
                          child: Text(
                            "Prix total         ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 12,
                                fontFamily: "MonseraBold"),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Text(
                              "32.500",
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
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:  EdgeInsets.only(right: longueurPerCent(12, context)),
                            child: Text(
                              " FCFA",
                              textAlign: TextAlign.left,
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
                            child: Text(
                              "En cours",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontFamily: "MontserratBold",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:longueurPerCent(10.0, context)),
                    Container(
                      margin: EdgeInsets.only(bottom: longueurPerCent(10, context)),
                      height: longueurPerCent(30.0, context),
                      width: largeurPerCent(100.0, context),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, DetailsCommandes.id);
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
            ),
            Container(height: longueurPerCent(30, context),)
          ],
        ),
      ),
    );
  }
}
