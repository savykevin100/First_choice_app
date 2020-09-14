import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

// ignore: must_be_immutable
class DetailsCommandes extends StatefulWidget {
  static String id="DetailsCommande";
  Map<String, dynamic> commande;
  int longueur;
  DetailsCommandes({this.commande, this.longueur});
  @override
  _DetailsCommandesState createState() => _DetailsCommandesState();
}

class _DetailsCommandesState extends State<DetailsCommandes> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.commande);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commande n°1"),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: longueurPerCent(20, context)),
            Container(
              width: largeurPerCent(360.0, context),
              child: Material(
                borderRadius: BorderRadius.circular(7.0),
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
                            "Info Client",
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
                            "Nom Complet:",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 12,
                                fontFamily: "MonseraBold"),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            child: Padding(
                              padding:
                              EdgeInsets.only(right: largeurPerCent(10, context),left: largeurPerCent(20, context)),
                              child: Text(
                                widget.commande["nomComplet"],
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
                            "Adresse de Livraison:",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 12,
                                fontFamily: "MonseraBold"),
                          ),
                        ),
                       Expanded(
                          flex: 8,
                          child: Container(
                            child: Padding(
                              padding:
                              EdgeInsets.only(right: largeurPerCent(10, context),left: largeurPerCent(20, context)),
                              child:  (widget.commande["lieuDeLivraison"]=="En Agence")? Text(
                                "Jonquet en face pharmacie. Immeuble blanc, 2ème étage.",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 12,
                                  fontFamily: "MontserratBold",
                                  fontWeight: FontWeight.bold,
                                ),
                              ):Text(
                                widget.commande["quartier"] +
                                    ", " +
                                    widget.commande["indication"],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 12,
                                  fontFamily: "MontserratBold",
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
                              bottom: longueurPerCent(10.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(10.0, context)),
                          child: Text(
                            "Contacts:",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 12,
                                fontFamily: "MonseraBold"),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: longueurPerCent(10, context),bottom:longueurPerCent(10,context) ),
                          child: Text(
                            widget.commande["telephone"],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 12,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(20, context)),
            Container(
              width: largeurPerCent(360.0, context),
              child: Material(
                borderRadius: BorderRadius.circular(7.0),
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
                            "Produits",
                            style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 19.0, fontWeight: FontWeight.bold ),
                          ),
                        ),
                      ),
                    ),
                   ListView.builder(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: widget.longueur,
                       itemBuilder: (context, i){
                         return Column(
                           children: [
                             Row(
                               children: [
                                 Container(
                                   margin: EdgeInsets.only(
                                     top: longueurPerCent(10, context),
                                     bottom: longueurPerCent(10, context),
                                     left:longueurPerCent(10,context),
                                   ),
                                   height: longueurPerCent(
                                       60, context),
                                   width: largeurPerCent(80, context),
                                   child: Image.network(
                                     widget.commande["produitsCommander"][i]["image1"],
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                                 Expanded(
                                   child: Container(
                                       margin:EdgeInsets.only(top: longueurPerCent(8, context),
                                           left: longueurPerCent(10, context)),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: <Widget>[
                                           SizedBox(height: longueurPerCent(0, context),),
                                           Text(
                                             widget.commande["produitsCommander"][i]["nomDuProduit"],
                                             textAlign: TextAlign.left,
                                             style: TextStyle(
                                                 color: HexColor(
                                                     "#909090"),
                                                 fontSize: 15,
                                                 fontFamily: "Regular"),
                                           ),
                                           SizedBox(
                                             height: longueurPerCent(
                                                 4.0, context),
                                           ),
                                           Text(
                                             "${widget.commande["produitsCommander"][i]["taille"]}",
                                             textAlign: TextAlign.left,
                                             style: TextStyle(
                                               color: HexColor("#001C36"),
                                               fontSize: 12,
                                               fontFamily: "MontserratBold",
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                           SizedBox(
                                             height: longueurPerCent(
                                                 8.0, context),
                                           ),
                                           Text(
                                             "${widget.commande["produitsCommander"][i]["prix"]}",
                                             textAlign: TextAlign.right,
                                             style: TextStyle(
                                               color: HexColor("#00CC7b"),
                                               fontSize: 15,
                                               fontFamily: "MontserratBold",
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                         ],
                                       )
                                   ),
                                 ),
                                 (widget.commande["produitsCommander"][i]["etatSurMesure"]==true)?
                                 Expanded(
                                   child: Container(
                                     child: Column(
                                       children: <Widget>[
                                         SizedBox(height: longueurPerCent(5, context),),
                                         Container(
                                           height: longueurPerCent(20, context),
                                           width: largeurPerCent(100, context),
                                           margin: EdgeInsets.only(left: longueurPerCent(20, context)),
                                           color: HexColor("#001C36"),
                                           child: Center(
                                             child: Text(
                                               "SUR MESURE",
                                               textAlign: TextAlign.right,
                                               style: TextStyle(
                                                   color: HexColor("#FFFFFF"),
                                                   fontSize: 9.0,
                                                   fontFamily: "MontserratBold",
                                                   fontWeight: FontWeight.bold

                                               ),
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ):Text("")
                               ],
                             ),
                             Divider(
                               color: Colors.grey,
                               height: 1,
                             ),
                           ],
                         );
                       }),
                    Container(height: longueurPerCent(10, context),)
                  ],
                ),
              ),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            Container(height: longueurPerCent(20, context),),
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
                            "Moyen de Paiement",
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
                            child: (widget.commande["moyenDePayement"]=="Mobile Money")?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mobile Money: ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: HexColor("#001C36"),
                                      fontSize: 15,
                                      fontFamily: "MonseraBold"),
                                ),
                                Text(
                                  widget.commande["numeroDePayement"],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: HexColor("#909090"),
                                      fontSize: 12,
                                      fontFamily: "MonseraBold"),
                                ),
                              ],
                            ):Text(
                              "Espèce",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: HexColor("#909090"),
                                  fontSize: 12,
                                  fontFamily: "MonseraBold"),
                            )
                        ),
                      ],
                    ),
                    Container(height: longueurPerCent(10, context),),
                  ],
                ),
              ),
            ),
            Container(height: longueurPerCent(20, context),),
            Container(
              width: largeurPerCent(360.0, context),
              child: Material(
                borderRadius: BorderRadius.circular(7.0),
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
                            "Total",
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
                            "Sous total      ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 12,
                                fontFamily: "MonseraBold"),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: longueurPerCent(0, context)),
                              child: Text(
                                "${widget.commande["total"]} ",
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
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Padding(
                              padding:  EdgeInsets.only(right: longueurPerCent(0, context)),
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
                            "Frais de Livraison   ",
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
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: longueurPerCent(0, context)),
                              child: Text(
                                "${widget.commande["prixLivraison"]} ",
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
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(right: longueurPerCent(10, context)),
                            child: Padding(
                              padding:  EdgeInsets.only(right: longueurPerCent(0, context)),
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
                        ),
                      ],
                    ),
                    SizedBox(height: longueurPerCent(10, context),),

                    SizedBox(height: longueurPerCent(10, context),),
                    Divider(
                      color: Colors.grey,
                      height: 1,
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
                            "Total",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 12,
                                fontFamily: "MonseraBold"),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: longueurPerCent(0, context)),
                              child: Text(
                                "${widget.commande["sousTotal"]} ",
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
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Padding(
                              padding:  EdgeInsets.only(right: longueurPerCent(0, context)),
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
                        ),
                      ],
                    ),
                    Container(height: longueurPerCent(10, context),),

                  ],
                ),
              ),
            ),
            Container(height: longueurPerCent(20, context),)
          ],
        ),
      ),
    );
  }
}
