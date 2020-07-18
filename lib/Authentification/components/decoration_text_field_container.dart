import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
Card textField(String hintText, BuildContext context,  ){
  return  Card(
    margin: EdgeInsets.only(left: largeurPerCent(25, context), right: largeurPerCent(15, context)),
    elevation: 5.0,
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: HexColor('#9B9B9B'),
                fontSize: 17.0,
                fontFamily: 'MonseraLight'),
            fillColor: Colors.white,
            border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(20.0) ),
                borderSide: BorderSide(width: 0, style: BorderStyle.none)
            )
        ),
      ),
    ),
  );
}