import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Authentification/renisialisation_passwd.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import '../checkConnexion.dart';
import 'components/decoration_text_field_container.dart';
import 'components/firebase_auth_services.dart';

class Connexion extends StatefulWidget {
  static String id="connexion";

  final BaseAuth auth;
  Connexion({this.auth});
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final _formKey = GlobalKey<FormState>();
  final _auth= FirebaseAuth.instance;
  String emailAdresse='';
  String motDePasse='';
  bool chargement = false;
  bool r=false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool visibilityPassword=true;
  @override
  Widget build(BuildContext context) {







    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text("Fermer l'application",  style: TextStyle( color: HexColor("#001C36"),
              fontSize: 15.0,
              fontFamily: "MonseraBold")),
          content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
          actions: <Widget>[
            new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NON", style: TextStyle( color: HexColor("#001C36"),
                    fontSize: 12.0,
                    fontFamily: "MonseraBold"),)
            ),
            SizedBox(height: longueurPerCent(10, context),),

            SizedBox(width: largeurPerCent(50, context),),
            new GestureDetector(
                onTap: () => exit(0),
                child: Text("OUI", style: TextStyle( color: HexColor("#001C36"),
                    fontSize: 12.0,
                    fontFamily: "MonseraBold"),)
            ),
            SizedBox(height: longueurPerCent(10, context),),
            SizedBox(width: largeurPerCent(20, context),),
          ],
        ),
      ) ??
          false;
    }

    return (chargement==false)?Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("#F5F5F5"),
        body: Test(displayContains: WillPopScope(
          onWillPop: _onBackPressed,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  FadeInDown(
                    child:  Padding(
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
                  ),
                  SizedBox(height: longueurPerCent(70, context),),
                  FadeInLeft(
                    child: Container(
                        child:Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                textField("Email", context, email()),
                                SizedBox(height: longueurPerCent(20, context),),
                                textField("Mot de passe", context,password()),
                              ],
                            )
                        )
                    ),
                  ),
                  SizedBox(height: longueurPerCent(50, context),),
                  FadeInRight(
                    child:  InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, ResetPasswd.id);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: largeurPerCent(190, context)),
                        child:Column(
                          children: <Widget>[
                            Text("Mot de passe oublié",style:TextStyle(
                              color: HexColor('#9B9B9B'),
                              fontSize: 15.0,
                              fontFamily: 'MonseraLight',  decoration: TextDecoration.underline,),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(50, context),),
                  FadeInRight(
                    child: button(HexColor("#001C36"), HexColor('#FFC30D'), context, "SE CONNECTER",  () async{
                      if(EmailValidator.validate(emailAdresse) == false)
                        displaySnackBarNom(context, "Entrer un email valide", Colors.white);
                      else if(motDePasse.isEmpty || motDePasse.length<6)
                        displaySnackBarNom(context, "Votre mot de passe doit contenir au moins 6 caractères", Colors.white);
                      else if(EmailValidator.validate(emailAdresse)==false && (motDePasse.isEmpty || motDePasse.length<6) )
                        displaySnackBarNom(context, "Email et mot de passe invalide. ", Colors.white);
                      else {
                        setState(() {
                          chargement=true;
                        });
                        try{
                          final user = await _auth.signInWithEmailAndPassword(email: emailAdresse , password: motDePasse);
                          if(user!=null){
                            setState(() {
                              chargement=false;
                            });
                            Navigator.pushNamed(context,AllNavigationPage.id);
                          }
                        } catch (e) {
                          setState(() {
                            chargement=false;
                          });
                          print(e);
                          if(e.toString()=="PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)")
                            showAlertDialog(context, "Mot de passe incorrect");
                          else if(e.toString()=="PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)")
                            showAlertDialog(context, "Veuillez vérifier votre connexion internet");
                          else  showAlertDialog(context, "Aucun email ne correspond à l'email entré");
                        }
                      } 
                    }),
                  ),
                  SizedBox(height: longueurPerCent(30, context),),
                  FadeInUpBig(
                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Pas de compte?", style: TextStyle(color: HexColor("#9B9B9B"), fontSize: 18),),
                        SizedBox(width: largeurPerCent(5, context),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Inscription.id);
                          },
                          child: Text("Inscrivez-vous",  style:TextStyle(
                              color: HexColor('#001C36'),
                              fontSize: 15.0,
                              fontFamily: 'MonseraBold')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),)
    ):Scaffold(

      backgroundColor: HexColor("#001C36"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
        child: Column(
          children: <Widget>[
            Image.asset("assets/images/1er choix-02.png",
              height: 197,
              width: 278,
            ),
            SizedBox(height: 50.0,),
            SpinKitThreeBounce(
              color:HexColor('#FFFFFF'),
              size: 60,
            )
          ],
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context, String text) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ALERT"),
      content: Text(text),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Widget email(){
    //if(Platform.isAndroid)
    return TextFormField(
      style: TextStyle(
          color: HexColor("#001C36"),
          fontSize: 18,
          fontFamily: "MonseraBold"
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
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
        emailAdresse = value;
      },
      // ignore: missing_return
    );
  }
  Widget password(){
    return  TextFormField(
      style: TextStyle(
          color: HexColor("#001C36"),
          fontSize: 18,
          fontFamily: "MonseraBold"
      ),
      obscureText: visibilityPassword,
      decoration: InputDecoration(
        hintText: "Mot de passe",
        hintStyle: TextStyle(
            color: HexColor('#9B9B9B'),
            fontSize: 18.0,
            fontFamily: 'MonseraLight'),
        fillColor: Colors.white,
        suffixIcon: IconButton(icon: Icon((visibilityPassword)?Icons.visibility:Icons.visibility_off), onPressed: (){
          if(visibilityPassword)
            setState(() {
              visibilityPassword=false;
            });
          else
            setState(() {
              visibilityPassword=true;
            });
        }),
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(7.0) ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
      onChanged: (value){
        motDePasse = value;
      },
      onFieldSubmitted: (value){
        motDePasse = value;
      },
      // ignore: missing_return
    );
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur ) {
    final snackBar = SnackBar(content: Text(text,   style: TextStyle(color: couleur, fontSize: 15)),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}