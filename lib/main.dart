 import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Design/Article.dart';
import 'package:premierchoixapp/Pages/FirstPage.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/DetailsCommandes.dart';
import 'package:premierchoixapp/test.dart';
import 'Authentification/Decision.dart';
import 'Authentification/connexion.dart';
import 'Authentification/renisialisation_passwd.dart';
import 'Authentification/renseignements.dart';
import 'Composants/hexadecimal.dart';
import 'Design/MensurationHomme.dart';
import 'Navigations_pages/Pages_article_paniers/Panier1.dart';
import 'Navigations_pages/Widgets/DetailsCommandes.dart';
import 'Navigations_pages/all_navigation_page.dart';
import 'Navigations_pages/panier.dart';
import 'Pages/page_chargement.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: HexColor("#001C36"),
        brightness: Brightness.light,
        accentColor: HexColor("#001C36"),
        colorScheme: ColorScheme.light(primary: HexColor("#001C36")),
      ),
      initialRoute:   FirstPage.id,
      routes: {
        Connexion.id: (context) => Connexion(),
        DetailsCommandes.id: (context) => DetailsCommandes(),
        Inscription.id: (context) => Inscription(),
        Article.id: (context) => Article(),
        Panier.id: (context) => Panier(),
        Panier1.id: (context) => Panier1(),
        ResetPasswd.id: (context) => ResetPasswd(),
        Renseignements.id: (context) => Renseignements(),
        AllNavigationPage.id: (context) => AllNavigationPage(),
        PageChargement.id: (context) => PageChargement(),
        Decision.id: (context) => Decision(),
        FirstPage.id: (context) => FirstPage(),
        Test.id: (context) => Test(),
        MensurationHomme.id: (context) => MensurationHomme(),
        DetailsCommandes.id: (context) => DetailsCommandes(),
      },
    );
  }
}
