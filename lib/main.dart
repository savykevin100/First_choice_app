import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Design/Article.dart';
import 'package:premierchoixapp/Design/Page1.dart';
import 'package:premierchoixapp/Navigations_pages/panier.dart';
import 'package:premierchoixapp/test.dart';
import 'Design/Panier2.dart';
import 'Design/Panier3.dart';
import 'package:premierchoixapp/Authentification/renisialisation_passwd.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Pages/page_chargement.dart';
import 'Navigations_pages/all_navigation_page.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override


  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: HexColor("EFD807"),
      ),
      color: HexColor("#001C36"),
      debugShowCheckedModeBanner: false,
      initialRoute: Connexion.id,
      routes: {
        Connexion.id:(context) => Connexion(),
        Inscription.id: (context) => Inscription(),
        Page1.id: (context) => Page1(),
        Article.id:(context) => Article(),
        Panier.id:(context) => Panier(),
        Panier2.id:(context) => Panier2(),
        Panier3.id:(context) => Panier3(),
        ResetPasswd.id:(context)=>ResetPasswd(),
        Renseignements.id:(context)=>Renseignements(),
        AllNavigationPage.id:(context)=>AllNavigationPage(),
        PageChargement.id:(context)=>PageChargement(),
        HomePage.id:(context)=>HomePage()
      },
    );
  }
}

