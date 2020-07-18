import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

import 'components/decoration_text_field_container.dart';

class Connexion extends StatefulWidget {
  static String id="connexion";
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: HexColor("#F5F5F5"),
        body: Container(
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
                        /* textField("Email", context, (){

                         }, (){

                         }),
                          SizedBox(height: longueurPerCent(20, context),),
                          textField("Mot de passe", context, (){

                          }, (){

                          }),*/
                        ],
                      )
                  )
              ),
              SizedBox(height: longueurPerCent(50, context),),
              Container(
                margin: EdgeInsets.only(left: largeurPerCent(190, context)),
                child:Column(
                  children: <Widget>[
                    Text("Mot de passe oublié",style:TextStyle(
                        color: HexColor('#9B9B9B'),
                        fontSize: 15.0,
                        fontFamily: 'MonseraLight')),
                   Padding(
                     padding:  EdgeInsets.only(left: largeurPerCent(40, context), right: largeurPerCent(40, context)),
                     child: Divider(height: 1, color: HexColor('#9B9B9B'),),
                   )
                  ],
                ),
              ),
              SizedBox(height: longueurPerCent(50, context),),
              button(HexColor("#001C36"), HexColor('#FFC30D'), context, "SE CONNECTER"),
              SizedBox(height: longueurPerCent(30, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Pas de compte?", style: TextStyle(color: HexColor("#9B9B9B"), fontSize: 18),),
                  SizedBox(width: largeurPerCent(5, context),),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Text("Inscrivez-vous",  style:TextStyle(
                        color: HexColor('#001C36'),
                        fontSize: 18.0,
                        fontFamily: 'MonseraBold')),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
