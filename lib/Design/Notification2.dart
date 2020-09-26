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
      ),
      drawer: ProfileSettings(userCurrent: Renseignements.emailUser),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: longueurPerCent(20.0, context),),
            Container(
              margin: EdgeInsets.only(left: longueurPerCent(10, context),right: longueurPerCent(10, context)),
              child: Material(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.white,
                elevation: 7.0,
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8),
                          child: Text(
                            "Réduction Black Friday ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 15,
                                fontFamily: "MonseraBold",
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.only(bottom: longueurPerCent(5, context),left: longueurPerCent(8, context)),
                          width: largeurPerCent(340.0, context),
                          child: Text(
                            "Nous venons d'ajouter de nouveaux produits veillez jeter un cout d'oeil solde très important ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 13,
                                fontFamily: "MonseraBold",
                                ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10,left: 8),
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