import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/accueil.dart';
import 'package:premierchoixapp/Navigations_pages/categories.dart';
import 'package:premierchoixapp/Navigations_pages/chat.dart';
import 'package:premierchoixapp/Navigations_pages/favoris.dart';
import 'package:premierchoixapp/Navigations_pages/notifications.dart';

import 'accueil.dart';


// ignore: must_be_immutable
class AllNavigationPage extends StatefulWidget {
  static String id = 'all_navigation_pages';


  @override
  _AllNavigationPageState createState() => _AllNavigationPageState();
}

class _AllNavigationPageState extends State<AllNavigationPage> {
  PageController pageController;
  String email;
  int page = 0;
  int bottomSelectedIndex = 0;
  int index = 0;
  FirebaseUser utilisateurConnecte;
  final _auth = FirebaseAuth.instance;


/*Obtention des élements de l'utilisateur connecté */
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        utilisateurConnecte = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void  pageChanged ( index  ) {
    setState (() {
      bottomSelectedIndex = index;
    });
  }

/*Fin de la fonction */


  @override
  void initState() {
    getCurrentUser();
    super.initState();
    pageController = PageController(initialPage: 0);
    getCurrentUser();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          Accueil(),
          Favoris(),
          Categories(),
          Chat(),
          Notifications(),
        ],
        onPageChanged: (int index) {
          pageChanged(index);
        },
      ),
      bottomNavigationBar: Container(
        child: CurvedNavigationBar(
            animationCurve:  Curves.decelerate,
            animationDuration: Duration(milliseconds: 10),
            backgroundColor: Colors.white.withOpacity(0.9),
            index: bottomSelectedIndex,
            items: <Widget>[
              /* */
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.favorite, size: 30, color: Colors.white),
              Icon(Icons.apps, size: 30, color: Colors.white),
              Icon(Icons.chat_bubble, size: 30, color: Colors.white),
              Icon(Icons.notifications, size: 30, color: Colors.white),
            ],
            onTap: (index) {
              setState(() {
                pageController.jumpToPage(index);
              });
            },
            buttonBackgroundColor: HexColor("#001C36"),
            color: HexColor("#001C36")),
      )
  );
}

@override
void dispose() {
  super.dispose();
  pageController.dispose();
}
}
