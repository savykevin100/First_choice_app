 import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/Decision.dart';
import 'package:premierchoixapp/Authentification/Test_login/root.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Design/Article.dart';
import 'package:premierchoixapp/Design/FirstPage.dart';
import 'package:premierchoixapp/Design/Page1.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier1.dart';
import 'package:premierchoixapp/Navigations_pages/panier.dart';
import 'package:premierchoixapp/test.dart';
import 'Authentification/Test_login/login.dart';
import 'Authentification/components/firebase_auth_services.dart';
import 'Composants/hexadecimal.dart';
import 'Navigations_pages/Pages_article_paniers/Panier1.dart';
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
        primaryColor:  HexColor("#001C36")
      ),
      debugShowCheckedModeBanner: false,
     /// home: RootPage(auth: Auth(),)
     initialRoute: FirstPage.id,
      routes: {
        Connexion.id:(context) => Connexion(),
        Inscription.id: (context) => Inscription(),
        Page1.id: (context) => Page1(),
        Article.id:(context) => Article(),
        Panier.id:(context) => Panier(),
        Panier1.id:(context) => Panier1(),
        ResetPasswd.id:(context)=>ResetPasswd(),
        Renseignements.id:(context)=>Renseignements(),
        AllNavigationPage.id:(context)=>AllNavigationPage(),
        PageChargement.id:(context)=>PageChargement(),
        HomePage.id:(context)=>HomePage(),
        Decision.id:(context)=>Decision(),
        FirstPage.id:(context)=>FirstPage()
      },
    );
  }
}