import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';

class CommandeSend extends StatefulWidget {
  @override
  _CommandeSendState createState() => _CommandeSendState();
}

class _CommandeSendState extends State<CommandeSend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: longueurPerCent(300, context),),
              Text("Commande envoyée", style: TextStyle(color: Colors.green, fontSize: 30),),
              SizedBox(height: longueurPerCent(10, context),),
              Icon(Icons.done_outline, color: Colors.green, size: 30,),
              SizedBox(height: longueurPerCent(100, context),),
              button(Colors.white, HexColor('#001C36'), context, "REVENIR À L'ACCUEIL", (){
                Navigator.pushNamed(context, AllNavigationPage.id);
              })
            ],
          ),
        ),
      ),
    );
  }
}
