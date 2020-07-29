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
          child: Container(
            //margin: EdgeInsets.only(right: longueurPerCent(148.0, context),left: longueurPerCent(148.0, context)),
            width: largeurPerCent(130.0, context),
            height: longueurPerCent(130.0, context),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(130.0)),
                gradient: LinearGradient(
                    colors: [HexColor("#001C36").withOpacity(0.4), HexColor("#001C36").withOpacity(0.1)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight
                )
            ),
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
            style: TextStyle(color: HexColor("#909090"), fontFamily: 'Regular', fontSize: 16.0, ),
          ),
        ),
      ],
    );
}