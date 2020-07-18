import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/components/decoration_text_field_container.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';

class Inscription extends StatefulWidget {
  static String id = "inscription";

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _auth = FirebaseAuth.instance;
   String emailAdress = '';
  String motDePass = '';
  String confirmation = '';
  bool chargement = false;
  Utilisateur utilisateur;
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
        body: Container(
         child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: longueurPerCent(90, context),
                  left: largeurPerCent(5, context),
                  right: largeurPerCent(200, context)
              ),
              child: Text(
                "S'inscrire",
                style: TextStyle(
                    color: HexColor("#001C36"),
                    fontFamily: "MonseraBold",
                    fontSize: 30),
              ),
            ),
            SizedBox(height: longueurPerCent(70, context),),
            Container(
              child:Form(
                key: _formKey,
                  child: Column(
                    children: <Widget>[
                      textField("Email", context, ),
                      SizedBox(height: longueurPerCent(20, context),),
                      textField("Mot de passe", context,),
                      SizedBox(height: longueurPerCent(20, context),),
                      textField("Confirmation mot de passe", context),
                    ],
                  )
              )
            ),
            SizedBox(height: longueurPerCent(50, context),),
            button(HexColor("#001C36"), HexColor('#FFC30D'), context, "S'INSCRIRE"),
            SizedBox(height: longueurPerCent(30, context),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Vous avez un compte?", style: TextStyle(color: HexColor("#9B9B9B"), fontSize: 18),),
                SizedBox(width: largeurPerCent(5, context),),
                GestureDetector(
                  onTap: (){
                    
                  },
                  child: Text("Connectez-vous",  style:TextStyle(
                      color: HexColor('#001C36'),
                      fontSize: 18.0,
                      fontFamily: 'MonseraBold')),
                )
              ],
            )
        ],
      ),
    ));
  }
}
