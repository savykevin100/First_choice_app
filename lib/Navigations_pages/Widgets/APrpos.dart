import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';


class APrpos extends StatefulWidget {
  static String id="APrpos";
  @override
  _APrposState createState() => _APrposState();
}

class _APrposState extends State<APrpos> {
  ScrollController controller=ScrollController();
  int ajoutPanier;
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "A Propos",
        controller: controller,
        context: context,
        );
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: _appBar.appBarFunctionStream(),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: longueurPerCent(20.0, context),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Lorem Ipsum"),
            )
          ],
        ),
      ),
    );
  }
}