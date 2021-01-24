import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


Widget elementsVides(BuildContext context, IconData icon, String text) {
  return Column(
      children: <Widget>[
        SizedBox(
          height: longueurPerCent(20, context),
        ),
        SizedBox(height: MediaQuery.of(context).size.height /5),
        Center(
          child: CircleAvatar(
            radius: 75.0,
            backgroundColor: HexColor("#001C36"),
            //margin: EdgeInsets.only(right: longueurPerCent(148.0, context),left: longueurPerCent(148.0, context)),
            child: Icon(
            icon,
              color: Colors.white,
              size: 79.0,
            ),
          ),
        ),
        SizedBox(height: longueurPerCent(20.0, context),),
        Center(
          child: Text(
           text,
            //style: TextStyle(color: HexColor("#909090"), fontFamily: 'Regular', fontSize: 16.0, ),
            style: TextStyle(fontSize: 16, color:HexColor("#909090"),),
          ),
        ),
      ],
    );
}