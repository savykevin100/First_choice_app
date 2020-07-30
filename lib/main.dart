import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Authentification/slider.dart';
import 'package:premierchoixapp/Design/Article.dart';
import 'package:premierchoixapp/Design/FirstPage.dart';

import 'package:premierchoixapp/Design/Notification2.dart';
import 'package:premierchoixapp/Design/Page1.dart';
import 'package:premierchoixapp/test.dart';
import 'Authentification/Decision.dart';
import 'Authentification/connexion.dart';
import 'Authentification/renisialisation_passwd.dart';
import 'Authentification/renseignements.dart';
import 'Navigations_pages/Pages_article_paniers/Panier1.dart';
import 'Navigations_pages/Pages_article_paniers/Panier2.dart';
import 'Navigations_pages/all_navigation_page.dart';
import 'Navigations_pages/panier.dart';
import 'Pages/Favoris1.dart';
import 'Pages/page_chargement.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: Connexion.id,
      routes: {
        Connexion.id:(context) => Connexion(),
        Inscription.id: (context) => Inscription(),
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

