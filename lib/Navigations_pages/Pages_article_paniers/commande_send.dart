import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';

class CommandeSend extends StatefulWidget {
  static String id = 'CommandeSend';
  @override
  _CommandeSendState createState() => _CommandeSendState();
}

class _CommandeSendState extends State<CommandeSend> {


  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle(fontFamily: "MonseraBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("Non", style: TextStyle(fontFamily: "MonseraBold"),)
          ),
          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("Oui", style: TextStyle(fontFamily: "MonseraBold"),)
          ),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop:  _onBackPressed,
          child: SingleChildScrollView(
           child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: longueurPerCent(0, context),),
                Container(
                  child: GestureDetector(
                      child: Image.asset(
                        "assets/images/images-07.png",
                        height: 500.0,
                        fit: BoxFit.fitHeight,
                      )),
                ),
                SizedBox(height: longueurPerCent(5, context),),
                Padding(
                    padding: EdgeInsets.all(5),
                  child: Text(
                    "Votre commande bien été envoyer",
                    style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 15,
                      fontFamily: "MonseraBold",
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(70, context),),
                button(Colors.white, HexColor('#001C36'), context,
                    "REVENIR À L'ACCUEIL", () {
                      Navigator.pushNamed(context, AllNavigationPage.id);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
