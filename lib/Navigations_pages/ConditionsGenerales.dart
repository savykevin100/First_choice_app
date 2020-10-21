import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/Decision.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';


class ConditionGenerales extends StatefulWidget {
  static String id="ConditionGenerales";
  @override
  _ConditionGeneralesState createState() => _ConditionGeneralesState();
}

class _ConditionGeneralesState extends State<ConditionGenerales> {
  ScrollController controller=ScrollController();
  int ajoutPanier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Conditions Générales",
          style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
        ),
      ),
      backgroundColor: HexColor("#F5F5F5"),

      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: longueurPerCent(20.0, context),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Lorem Ipsum"),
            ),
            Center(
              child:
              Container(
                child: button(HexColor("#001C36"), HexColor("#FFC30D"), context,
                    'CONFIRMER', () {
                      Navigator.pushNamed(context, Decision.id);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}