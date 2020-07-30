import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
Card textField(String hintText, BuildContext context, Widget contenu ){
  return  Card(
    margin: EdgeInsets.only(left: largeurPerCent(18, context), right: largeurPerCent(15, context)),
    elevation: 5.0,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7.0)),
        color: Colors.white,
      ),
      child: contenu
    ),
  );
}