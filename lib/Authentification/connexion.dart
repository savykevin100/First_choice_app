import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/inscription.dart';
import 'package:premierchoixapp/Authentification/renisialisation_passwd.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import 'components/decoration_text_field_container.dart';

class Connexion extends StatefulWidget {
  static String id="connexion";
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final _formKey = GlobalKey<FormState>();
  final _auth= FirebaseAuth.instance;
  String emailAdresse='';
  String motDePasse='';
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


    return (chargement==true)?Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Image.asset('assets/images/marketeur.png',
                height: 197,
                width: 278,
              ),
            ),
            SizedBox(height: 50.0,),
            SpinKitThreeBounce(
              color:HexColor('#001C36'),
              size: 60,
            )
          ],
        ),
      ),
    ) :Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("#F5F5F5"),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(90, context),
                      left: largeurPerCent(5, context),
                      right: largeurPerCent(150, context)
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
                SizedBox(height: longueurPerCent(50, context),),
                InkWell(
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
                SizedBox(height: longueurPerCent(50, context),),
                button(HexColor("#001C36"), HexColor('#FFC30D'), context, "SE CONNECTER",  () async{
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      chargement = true;
                    });
                    try{
                      final user = await _auth.signInWithEmailAndPassword(email: emailAdresse , password: motDePasse);
                      if(user!=null) {

                        setState(() {
                          Renseignements.emailUser = emailAdresse;
                          Navigator.pushNamed(context,AllNavigationPage.id);
                        });
                      }

                      setState(() {
                        chargement = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }
                }),
                SizedBox(height: longueurPerCent(30, context),),
                Row(
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
                )
              ],
            ),
          ),
        )
    );
  }
  Widget email(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
            color: HexColor('#9B9B9B'),
            fontSize: 17.0,
            fontFamily: 'MonseraLight'),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20.0) ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
      onChanged: (value){
       emailAdresse = value;
      },
      validator: (String value) {
        if (EmailValidator.validate(emailAdresse) == false) {
          return ("Entrer un email valide");
        }
      },
    );
  }
  Widget password(){
    return  TextFormField(
      decoration: InputDecoration(
        hintText: "Mot de passe",
        hintStyle: TextStyle(
            color: HexColor('#9B9B9B'),
            fontSize: 17.0,
            fontFamily: 'MonseraLight'),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20.0) ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
      onChanged: (value){
        motDePasse = value;
      },
      validator: (String value) {
        if(value.isEmpty) {
          return ("Entrer un mot de passe valide");
        } else if (value.length<6) {
          return ("Le nombre de caractères doit être supérieur à 5");
        }
      },
    );
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur ) {
    final snackBar = SnackBar(content: Text(text,   style: TextStyle(color: couleur, fontSize: 15)),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}
