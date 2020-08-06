import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';


FlatButton button (Color colorText, Color colorButton, BuildContext context, String text, Function onPressed){
  return FlatButton(onPressed: onPressed, child: Center(
    child: Container(
      margin: EdgeInsets.only(left: longueurPerCent(0.0, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: colorButton,
        ),
        width: largeurPerCent(380, context),
        height: longueurPerCent(50, context),
        child: Center(child: Text(text, style:TextStyle(
            color: colorText,
            fontSize: 15.0,
            fontFamily: 'MonseraBold'),),)
    ),
  ));
}