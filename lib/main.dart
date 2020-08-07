import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Design/Article.dart';
import 'package:premierchoixapp/Design/Dropdowntest.dart';
import 'package:premierchoixapp/Design/FirstPage.dart';
import 'package:premierchoixapp/test.dart';
import 'Authentification/Decision.dart';
import 'Authentification/connexion.dart';
import 'Authentification/renisialisation_passwd.dart';
import 'Authentification/renseignements.dart';
import 'Composants/hexadecimal.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: HexColor("#001C36"),
        brightness: Brightness.light,
        accentColor: HexColor("#001C36"),
        splashColor: HexColor("#001C36"),
        colorScheme: ColorScheme.light(primary: HexColor("#001C36")),
      ),

      initialRoute: FirstPage.id,
      routes: {
        Connexion.id: (context) => Connexion(),
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
        HomePage.id: (context) => HomePage(),
        DetailsCommandes.id: (context) => DetailsCommandes(),
      },
    );
  }
}
