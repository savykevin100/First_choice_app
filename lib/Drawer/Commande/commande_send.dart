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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop:  () async => false,
          child: SingleChildScrollView(
           child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: longueurPerCent(0, context),),
                Container(
                  child: GestureDetector(
                      child: Image.asset(
                        "assets/images/images-07.png",
                        height: 350.0,
                        fit: BoxFit.fitHeight,
                      )),
                ),
                SizedBox(height: longueurPerCent(5, context),),
                Padding(
                    padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Votre commande a bien été envoyée",
                      style: TextStyle(
                       fontFamily: "MonseraBold",
                        color: HexColor('#001C36'),
                        fontSize: 15
                      ),
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
