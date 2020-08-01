import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Design/Article.dart';
import 'package:premierchoixapp/Design/Decision.dart';
import 'package:premierchoixapp/Design/Favoris1.dart';
import 'package:premierchoixapp/Design/Notification2.dart';
import 'package:premierchoixapp/Design/Page1.dart';
import 'package:premierchoixapp/test.dart';
import 'Authentification/connexion.dart';
import 'Design/Notification1.dart';
import 'Design/Panier.dart';
import 'Design/Panier2.dart';
import 'Design/Panier3.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: Panier3.id,
      routes: {
        Connexion.id:(context) => Connexion(),
        Inscription.id: (context) => Inscription(),
        Page1.id: (context) => Page1(),
        Article.id:(context) => Article(),
        Panier.id:(context) => Panier(),
        Panier2.id:(context) => Panier2(),
        Panier3.id:(context) => Panier3(),
        Favoris1.id:(context) => Favoris1(),
        Notification2.id:(context) => Notification2(),
        Notification1.id:(context) => Notification1(),
        Decision.id:(context) => Decision(),

      },
    );
  }
}

