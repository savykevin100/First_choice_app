import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class Favoris1 extends StatefulWidget {
  static String id="Favoris1";
  @override
  _Favoris1State createState() => _Favoris1State();
}

class _Favoris1State extends State<Favoris1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: AppBar(
        backgroundColor: HexColor("#001c36"),
        title: Text("Favoris", style: TextStyle(color: Colors.white, fontFamily: "MontserratBold"),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket),
            color: Colors.white,
            onPressed: (){
              setState(() {
                // A toi de jouer
              });
            },
          ),
        ],
      ),
      drawer: Drawer(

      ),
      body: Column(
        children: <Widget>[
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
                Icons.favorite_border,
                color: Colors.white,
                size: 79.0,
              ),
            ),
          ),
          SizedBox(height: longueurPerCent(20.0, context),),
          Center(
            child: Text(
              'AUCUN FAVORIS',
              style: TextStyle(color: HexColor("#909090"), fontFamily: 'Regular', fontSize: 16.0, ),
            ),
          ),
        ],
      ),
    );
  }
}