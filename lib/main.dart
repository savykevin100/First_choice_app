import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
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
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: PageChargement.id,
      routes: {
        Connexion.id:(context) => Connexion(),
        Inscription.id: (context) => Inscription(),
        AllNavigationPage.id:(context)=>AllNavigationPage(),
        ResetPasswd.id:(context)=>ResetPasswd(),
        Renseignements.id:(context)=>Renseignements(),
        PageChargement.id:(context)=>PageChargement()
      },
    );
  }
}

