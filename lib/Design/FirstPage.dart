import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class FirstPage extends StatefulWidget {
  static String id="FirstPage";
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#001C36"),
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
                  width: largeurPerCent(307.5, context),
                  child: Image.asset("assets/images/logo.png",
                    fit: BoxFit.cover,),
                ),
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