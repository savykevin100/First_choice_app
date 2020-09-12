import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/components/decoration_text_field_container.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Authentification/renisialisation_passwd.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';

class ConnexionAdmin extends StatefulWidget {
  static String id="connexionAdmin";

  @override
  _ConnexionAdminState createState() => _ConnexionAdminState();
}

class _ConnexionAdminState extends State<ConnexionAdmin> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("#F5F5F5"),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(90, context),
                      left: largeurPerCent(0, context),
                      right: largeurPerCent(152, context)
                  ),
                  child: Text(
                    "Se connecter ",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontFamily: "MonseraBold",
                        fontSize: 30),
                  ),
                ),
                SizedBox(height: longueurPerCent(70, context),),
                Container(
                    child:Form(
                        child: Column(
                          children: <Widget>[
                            textField("Email", context, email()),
                            SizedBox(height: longueurPerCent(20, context),),
                            textField("Mot de passe", context,password()),
                          ],
                        )
                    )
                ),
                SizedBox(height: longueurPerCent(50, context),),
                button(HexColor("#001C36"), HexColor('#FFC30D'), context, "SE CONNECTER",  () async{
                }),

              ],
            ),
          ),
        )
    );
  }


  Widget email(){
    return TextFormField(
      style: TextStyle(
          color: HexColor("#001C36"),
          fontSize: 18,
          fontFamily: "MonseraBold"
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Nom",
        hintStyle: TextStyle(
            color: HexColor('#9B9B9B'),
            fontSize: 18.0,
            fontFamily: 'MonseraLight'),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(7.0) ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
      onChanged: (value){
      },

    );
  }
  Widget password(){
    return  TextFormField(
      style: TextStyle(
          color: HexColor("#001C36"),
          fontSize: 18,
          fontFamily: "MonseraBold"
      ),
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Mot de passe",
        hintStyle: TextStyle(
            color: HexColor('#9B9B9B'),
            fontSize: 18.0,
            fontFamily: 'MonseraLight'),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(7.0) ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
      onChanged: (value){
      },
    );
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur ) {
    final snackBar = SnackBar(content: Text(text,   style: TextStyle(color: couleur, fontSize: 15)),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}
