import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/Decision.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';

class PageChargement extends StatefulWidget {
  static String id="PageChargement";
  @override
  _PageChargementState createState() => _PageChargementState();
}

class _PageChargementState extends State<PageChargement> {
  final _auth = FirebaseAuth.instance;
  bool currentUser=false;
  bool chargement = true;

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
   /* if(chargement==true){
      return Scaffold(
        backgroundColor: HexColor("#001C36"),
        body: Container(
          margin: EdgeInsets.only(top: longueurPerCent(232, context), left: largeurPerCent(34, context), right: largeurPerCent(35, context)),
          child: Column(
            children: <Widget>[
              Container(
                height: longueurPerCent(230, context),
                width: largeurPerCent(310, context),
                child:  Image.asset("assets/images/inscription.jpg"),
              ),
              SizedBox(height: longueurPerCent(20, context),),
              Text("S’habiller n’a jamais été aussi simple", style: TextStyle(color: Colors.white, fontFamily: "MonseraBold", fontSize: 18),),
              SizedBox(height: longueurPerCent(160, context),),
              Text("Copyright by Followme 2020", style: TextStyle(fontFamily: "Thin", color: Colors.white ),)
            ],
          ),
        ),
      );
    } */
   if(currentUser){
      return AllNavigationPage();
    } else {
      return Decision();
    }
  }
}
