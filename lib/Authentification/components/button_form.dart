import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';


FlatButton button (Color colorText, Color colorButton, BuildContext context, String text){
  return FlatButton(onPressed: null, child: Center(
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: colorButton,
        ),
        width: largeurPerCent(340, context),
        height: longueurPerCent(40, context),
        child: Center(child: Text(text, style:TextStyle(
            color: colorText,
            fontSize: 20.0,
            fontFamily: 'MonseraBold'),),)
    ),
  ));
}