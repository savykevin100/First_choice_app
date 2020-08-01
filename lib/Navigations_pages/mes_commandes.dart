import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

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
      body:Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 150,
                child: Image.asset("assets/images/businessman-3213659_1920.jpg", fit: BoxFit.cover,),
              ),
            ),
            Center(
              child: Container(
                height: 150,
                width: 200,
                child:  Column(
                  children: <Widget>[
                   SizedBox(height: longueurPerCent(30, context),),
                    Text(
                      "Ordinateur apple ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: HexColor(
                              "#909090"),
                          fontSize: 18,
                          fontFamily: "Regular"),
                    ),
                    SizedBox(
                      height: longueurPerCent(
                          10.0, context),
                    ),
                    Text(
                      "Rouge - 43",
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
                          10.0, context),
                    ),
                    Text(
                      '10000 FCFA',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 16,
                        fontFamily: "MontserratBold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 150,
                child:  Column(
                  children: <Widget>[
                    SizedBox(height: longueurPerCent(40, context),),
                    Text(
                      "100000 FCFA",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: HexColor(
                              "#909090"),
                          fontSize: 18,
                          fontFamily: "Regular"),
                    ),
                    SizedBox(
                      height: longueurPerCent(
                          10.0, context),
                    ),
                    Text(
                      " NON VALIDE",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontFamily: "MontserratBold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
