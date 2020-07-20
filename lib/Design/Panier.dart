import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/composants/calcul.dart';


class Panier extends StatefulWidget {
  static String id='Panier';
  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
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


        drawer: Drawer(

        ),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(height: longueurPerCent(17.0, context),),
                  Container(
                    height: longueurPerCent(28.0, context),
                    width: largeurPerCent(160.0, context),
                    margin: EdgeInsets.only(
                        left: longueurPerCent(13.0, context),
                        top: longueurPerCent(17.0, context)),
                    child: Center(
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
                  ),
                  Container(
                    height: longueurPerCent(13.0, context),
                    width: largeurPerCent(115.0, context),
                    margin: EdgeInsets.only(
                        left: longueurPerCent(111.0, context),
                        top: longueurPerCent(17.0, context)),
                    child: Center(
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
                  ),
                ],
              ),
              SizedBox(height: longueurPerCent(43.0, context),),
              Container(
                margin: EdgeInsets.only(
                  left: longueurPerCent(18.0, context),
                  right: longueurPerCent(15.0, context),),
                child: Material(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Colors.white,
                  elevation: 7.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: longueurPerCent(0.0, context),
                          top: longueurPerCent(0.0, context),),
                        child: Checkbox(value: false,
                          activeColor: HexColor("001C36"),
                          onChanged: (bool newValue) {
                            setState(() {

                            });
                          },
                        ),
                      ),
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
                      Container(
                        margin: EdgeInsets.only(
                            left: longueurPerCent(30.0, context)),
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 20,),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),


// Deuxieme article
              SizedBox(height: longueurPerCent(43.0, context),),
              Container(
                margin: EdgeInsets.only(
                  left: longueurPerCent(18.0, context),
                  right: longueurPerCent(15.0, context),),
                child: Material(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Colors.white,
                  elevation: 7.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: longueurPerCent(0.0, context),
                          top: longueurPerCent(0.0, context),),
                        child: Checkbox(value: false,
                          activeColor: HexColor("001C36"),
                          onChanged: (bool newValue) {
                            setState(() {

                            });
                          },
                        ),
                      ),
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
                      Container(
                        margin: EdgeInsets.only(
                            left: longueurPerCent(30.0, context)),
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 20,),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height:longueurPerCent(50.4, context)),
              Center(
                child: Container(
                  margin: EdgeInsets.only(right: longueurPerCent(18.0, context),left: longueurPerCent(18.0, context),),
                  height: longueurPerCent(50.0, context),
                  width: largeurPerCent(339.0, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: HexColor("#FFC30D")),
                  ),
                  child: Material(
                    //shadowColor: Colors.greenAccent,
                    color: HexColor("#FFC30D"),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'ACHETER',
                          style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(50.0, context),),
              new Container(),
            ],
          ),
        )
    );
  }
}