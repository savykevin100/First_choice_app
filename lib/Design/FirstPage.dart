import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/slider.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class FirstPage extends StatefulWidget {
  static String id="FirstPage";
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();

  }


  bool currentUser=false;
  bool ajoue=false;
  List<Map<String, dynamic>> produits=[];
  List<Map<String, dynamic>> produitsFavorisUsers=[];
  String utilisateurConnecte;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value){
      if(value!=null){
       setState(() {
         currentUser=true;
         utilisateurConnecte=value.email;
       });
      }
    });
    StarTimer();
  }

  // ignore: non_constant_identifier_names
  StarTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }
  
  route (){
    if(currentUser ){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => AllNavigationPage()
      ));
    } else{
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => IntroScreen()
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#001C37"),
      body: new Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(175.0, context),),
                  height: longueurPerCent(227.5, context),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/logo.png",
                    fit: BoxFit.cover,),
                ),
                SizedBox(height: longueurPerCent(50, context),),
                Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),),
                SizedBox(height: longueurPerCent(50, context),),
                Container(
                  margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(46.0, context),),
                  child: Center(
                    child: Text(
                      "S'habiller n'a jamais été aussi simple",
                      style: TextStyle(color: HexColor("##FFFFFF"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

  }
}