import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/components/decoration_text_field_container.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/test.dart';
import 'package:shared_preferences/shared_preferences.dart';





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
  String key = "email_user";
  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return (chargement==false)?Scaffold(
        backgroundColor: HexColor("#F5F5F5"),
        body:Test(displayContains: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                FadeInDown(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: longueurPerCent(90, context),
                        left: largeurPerCent(0, context),
                        right: largeurPerCent(230, context)
                    ),
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          color: HexColor("#001C36"),
                          fontFamily: "MonseraBold",
                          fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(70, context),),
                FadeInLeft(
                  child:  Container(
                      child:Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              textField("Email", context, email()),
                              SizedBox(height: longueurPerCent(20, context),),
                              textField("Mot de passe", context,password()),
                              SizedBox(height: longueurPerCent(20, context),),
                              textField("Confirmation mot de passe", context, confirmPassword()),
                            ],
                          )
                      )
                  ),
                ),
                SizedBox(height: longueurPerCent(50, context),),
                FadeInRight(
                  child: button(HexColor("#001C36"), HexColor('#FFC30D'), context, "S'INSCRIRE", () async{
                    if(_formKey.currentState.validate()) {
                      setState(() {
                        chargement=true;
                      });
                      try {
                        final user= await _auth.createUserWithEmailAndPassword(email: emailAdress, password: motDePass);
                        if(user!=null ) {
                           _auth.currentUser().then((value) {
                            value.sendEmailVerification();
                          });
                           setState(() {
                             chargement=false;
                           });
                          //confirmEmail(context, user.user);
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return Renseignements(emailAdress: emailAdress);
                          }));

                        }
                      } catch(e){
                        setState(() {
                          chargement = false;
                        });
                        print(e.toString());
                        showAlertDialog(context, "Votre email est déjà utilisé par un autre compte");
                      }
                    }
                  }),
                ),
                SizedBox(height: longueurPerCent(30, context),),
                FadeInUp(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Vous avez un compte?", style: TextStyle(color: HexColor("#9B9B9B"), fontSize: 18,fontFamily: 'MonseraLight'),),
                      SizedBox(width: largeurPerCent(5, context),),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Connexion.id);
                        },
                        child: Text("Connectez-vous",  style:TextStyle(
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
        ),)): Scaffold(
      backgroundColor: HexColor("#001C36"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/images/1er choix-02.png",
              height: 197,
              width: 278,
            ),
            SizedBox(
              height: 50.0,
            ),
            SpinKitThreeBounce(
              color: HexColor('#FFFFFF'),
              size: 60,
            )
          ],
        ),
      ),
    );
  }
  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  confirmEmail(BuildContext context, FirebaseUser user) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Continuer"),
      onPressed:  () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return Renseignements(emailAdress: emailAdress);
        }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Un email de vérification a été envoyé à votre address mail, veuillez confirmer votre email pour vous connecter"),
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


  // ignore: missing_return
  Widget popup() {
    showDialog(context: context, builder: (builder) {
      return AlertDialog(
        content:  Center(
          child: Column(
            children: [
              Text("Veuillez consulter votre mail pour vérification de votre email, sans la confirmation de votre mail vous ne pourrez pas vous connecter"),
              Padding(padding: EdgeInsets.only(top: longueurPerCent(20, context))),
              Container( child:  Center(child: CircularProgressIndicator()) ),
            ],
          ),
        ),
      );
    });
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
        emailAdress = value;
      },
      // ignore: missing_return
      validator: (String value) {
        if (EmailValidator.validate(emailAdress) == false) {
          return ("Entrer un email valide");
        }
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
            fontSize: 17.0,
            fontFamily: 'MonseraLight'),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
        border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20.0) ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)
        ),
      ),
      onChanged: (value){
        motDePass = value;
      },
      // ignore: missing_return
      validator: (String value) {
        if(value.isEmpty) {
          return ("Entrer un mot de passe valide");
        } else if (value.length<6) {
          return ("Le nombre de caractères doit être supérieur à 5");
        }
      },
    );
  }
  Widget confirmPassword() {
    return  TextFormField(
      style: TextStyle(
          color: HexColor("#001C36"),
          fontSize: 18,
          fontFamily: "MonseraBold"
      ),
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Confirmation mot de passe",
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
      onChanged:
          (value) => confirmation = value,
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty || motDePass != value) {
          return ("Veuillez confirmer votre mot de passe");
        }
      },
    );
  }

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String liste = sharedPreferences.getString(key);
    if (liste != null) {
      setState(() {
        Renseignements.emailUser = liste;
      });
    }
  }
  /* Fin de la fonction */

  /* Cette fonction permet d'ajouter les informations*/

  Future<void> ajouter(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.emailUser=str;
    await sharedPreferences.setString(key, Renseignements.emailUser);
    obtenir();
  }
}