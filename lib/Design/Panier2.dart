import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


class Panier2 extends StatefulWidget {
  static String id='Panier2';
  @override
  _Panier2State createState() => _Panier2State();
}

class _Panier2State extends State<Panier2> {
  String payement;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        drawer: Drawer(

        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color:Colors.white,
                 child: Column(
                   children: <Widget>[
                      Container(
                       margin: EdgeInsets.only(
                         left: longueurPerCent(18.0, context),
                         top: longueurPerCent(24.0, context),
                         right: longueurPerCent(15.0, context),
                       ),
                       child: Material(
                         borderRadius: BorderRadius.circular(7.0),
                         color: Colors.white,
                         elevation: 7.0,
                         child: Row(
                           children: <Widget>[
                             Container(
                               margin: EdgeInsets.only(
                                 left: longueurPerCent(19.0, context),
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
                                   child: Text(
                                     "Sneekers",
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
                                     right: longueurPerCent(95, context),
                                   ),
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
                               ],
                             ),
                             Container(
                               margin: EdgeInsets.only(
                                   right: longueurPerCent(9, context),
                                   left: longueurPerCent(0.0, context)),
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
                       ),
                     ),
                     SizedBox(height: longueurPerCent(160.0, context),),
                     new Container(),
                   ],
                 ),
              ),
              SizedBox(height: longueurPerCent(20.5, context),),
              Container(
                child: Container(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(36.0, context)),
                            child: Text(
                              "SOUS TOTAL",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: HexColor("#909090"),
                                  fontSize: 18,
                                  fontFamily: "Montserrat_Light"),
                            ),
                          ),
                          Container(
                            width: largeurPerCent(190.0, context),
                            margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right:longueurPerCent(25.0, context),left: longueurPerCent(35.0, context) ),
                            child: Text(
                              "1.000" +"‬ F CFA",
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
                            margin: EdgeInsets.only(top: longueurPerCent(47.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(36.0, context)),
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
                            margin: EdgeInsets.only(top: longueurPerCent(47.0, context),right:longueurPerCent(25.0, context),left: longueurPerCent(35.0, context) ),
                            child: Text(
                              "500" +"‬ F CFA",
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
                            margin: EdgeInsets.only(top: longueurPerCent(47.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(36.0, context)),
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
                            margin: EdgeInsets.only(top: longueurPerCent(47.0, context),right:longueurPerCent(25.0, context),left: longueurPerCent(85.0, context) ),
                            child: Text(
                              "1.500" +"‬ F CFA",
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
                      SizedBox(height: longueurPerCent(51.38, context),),
                      Container(
                        child:Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(30.0, context)),
                              child: Text(
                                "Moyen de payement",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#909090"),
                                    fontSize: 16,
                                    fontFamily: "MontserratBold",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: longueurPerCent(175.0, context),
                              height: largeurPerCent(70, context),
                              margin: EdgeInsets.only(left: longueurPerCent(10.0, context),right: longueurPerCent(10.0, context)),
                              color: HexColor("#FFFFFF"),
                              child: DropDownFormField(
                                titleText: null,
                                errorText: 'Choisissez un moyen de payement',
                                hintText: 'Mobile Money',
                                value: payement,
                                dataSource: [
                                  {
                                    "display": "Mobile Money",
                                    "value": "Mobile Money",
                                  },
                                  {
                                    "display": "Moov Money",
                                    "value": "Moov Money",
                                  },
                                  {
                                    "display": "Espece",
                                    "value": "Espece",
                                  },
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    payement = value;

                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return ("Veuillez selectionner un moyen de payement");
                                  }
                                  return null;
                                },
                                textField: 'display',
                                valueField: 'value',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: longueurPerCent(47.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(95.0, context)),
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
                            margin: EdgeInsets.only(top: longueurPerCent(47.0, context),right:longueurPerCent(0.0, context),left: longueurPerCent(20.0, context) ),
                            child: Text(
                              "96 18 46 55",
                              textAlign: TextAlign.left,
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
                      SizedBox(height:longueurPerCent(30.62, context)),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(right: longueurPerCent(18.0, context),left: longueurPerCent(18.0, context),),
                          height: longueurPerCent(50.0, context),
                          width: largeurPerCent(339.0, context),
                          child: Material(
                            borderRadius: BorderRadius.circular(7.0),
                            //shadowColor: Colors.greenAccent,
                            color: HexColor("#001C36"),
                            child: GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  'COMMANDER',
                                  style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: longueurPerCent(30.62, context),),
                      new Container(),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

}
