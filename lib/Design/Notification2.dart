import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class Notification2 extends StatefulWidget {
  static String id="Notification2";
  @override
  _Notification2State createState() => _Notification2State();
}

class _Notification2State extends State<Notification2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: AppBar(
        backgroundColor: HexColor("#001c36"),
        title: Text("Notification", style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),),
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
            SizedBox(
              height: longueurPerCent(20, context),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: largeurPerCent(20, context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: HexColor("#DDDDDD"),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding:  EdgeInsets.only(left: largeurPerCent(20, context)),
                      child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                    ),
                    labelText: "Rechercher un produit",
                    labelStyle: TextStyle(
                        color: HexColor('#9B9B9B'),
                        fontSize: 17.0,
                        fontFamily: 'MonseraLight'),
                    contentPadding: EdgeInsets.only(top: 10, bottom: 5, left:100),

                  ),
                )),
            SizedBox(height: longueurPerCent(30.0, context),),
            Container(
              child: Material(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.white,
                elevation: 7.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: longueurPerCent(19.0, context),
                        top: longueurPerCent(0, context),),
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
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              //right: longueurPerCent(95, context),
                              top: longueurPerCent(0.0, context)
                            ),
                            height: longueurPerCent(60.0, context),
                            width: largeurPerCent(300.0, context),
                            child: Text(
                              "Nous venons d'ajouter de nouveaux produits veillez jeter un cout d'oeil solde très important ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 16,
                                  fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: longueurPerCent(95, context),
                          ),
                          child: Text(
                            "3min ago",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: HexColor("#909090"),
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
            SizedBox(height: longueurPerCent(10.0, context),),
            new Container(),
            Container(
              child: Material(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.white,
                elevation: 7.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: longueurPerCent(19.0, context),
                        top: longueurPerCent(0, context),),
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
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              //right: longueurPerCent(95, context),
                                top: longueurPerCent(0.0, context)
                            ),
                            height: longueurPerCent(60.0, context),
                            width: largeurPerCent(300.0, context),
                            child: Text(
                              "Nous venons d'ajouter de nouveaux produits veillez jeter un cout d'oeil solde très important ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 16,
                                  fontFamily: "Montserrat_Light",
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: longueurPerCent(95, context),
                          ),
                          child: Text(
                            "3min ago",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: HexColor("#909090"),
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
            new Container(height: longueurPerCent(50.0, context),),
          ],
        ),
      ),
    );
  }
}