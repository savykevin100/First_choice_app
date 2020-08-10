import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
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
      drawer: ProfileSettings(userCurrent: Renseignements.emailUser),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: longueurPerCent(20.0, context),),
            Container(
              child: Material(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.white,
                elevation: 7.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: longueurPerCent(0.0, context),
                          top: longueurPerCent(0, context),),
                        width: largeurPerCent(60.5, context),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(top: longueurPerCent(10, context),bottom:longueurPerCent(10, context),),
                            height: longueurPerCent(60.0, context),
                            width: largeurPerCent(65.0, context),
                            child: Image.asset(
                              "assets/images/gadgets-336635_1920.jpg",
                              fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin:EdgeInsets.only(bottom: longueurPerCent(5, context),right: longueurPerCent(20, context)),
                            width: largeurPerCent(300.0, context),
                            child: Text(
                              "Nous venons d'ajouter de nouveaux produits veillez jeter un cout d'oeil solde très important ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 13,
                                  fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
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
          ],
        ),
      ),
    );
  }
}