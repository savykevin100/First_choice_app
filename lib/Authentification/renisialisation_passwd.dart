import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import '../checkConnexion.dart';
import 'components/decoration_text_field_container.dart';

class ResetPasswd extends StatefulWidget {
  static String id="ResetPasswd";
  @override
  _ResetPasswdState createState() => _ResetPasswdState();
}

class _ResetPasswdState extends State<ResetPasswd> {
  final _formKey = GlobalKey<FormState>();
  final _auth= FirebaseAuth.instance;
  String emailAdresse='';
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("#F5F5F5"),
        body: Test(
          displayContains: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: longueurPerCent(90, context),
                    ),
                    child: Text(
                      "Mot de passe oublié ",
                      style: TextStyle(
                          color: HexColor("#001C36"),
                          fontFamily: "MonseraBold",
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(150, context),),
                  Container(
                      child:Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              textField("Email", context, email()),
                              SizedBox(height: longueurPerCent(20, context),),
                            ],
                          )
                      )
                  ),
                  SizedBox(height: longueurPerCent(50, context),),

                  button(HexColor("#001C36"), HexColor('#FFC30D'), context, "RENITIALISER",  () async{
                    if(_formKey.currentState.validate()) {
                      try{
                        displaySnackBarNom(context, "Veuillez consulter votre boîter pour rénitialiser votre mot de passe", Colors.green);
                        await _auth.sendPasswordResetEmail(email: emailAdresse);
                        Navigator.pushNamed(context,Connexion.id);
                        setState(() {
                          /// Renseignement1.infos_utilisateur_connnecte=emailAdresse;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  }),
                ],
              ),
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
      // ignore: missing_return
      validator: (String value) {
        if (EmailValidator.validate(emailAdresse) == false) {
          return ("Entrer un email valide");
        }
      },
    );
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur ) {
    final snackBar = SnackBar(content: Text(text,   style: TextStyle(color: couleur, fontSize: 15)),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}