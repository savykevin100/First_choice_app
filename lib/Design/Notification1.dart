import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class Notification1 extends StatefulWidget {
  static String id="Notification1";
  @override
  _Notification1State createState() => _Notification1State();
}

class _Notification1State extends State<Notification1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#001c36"),
        title: Text("Notification", style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),),
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
      backgroundColor: HexColor("#F5F5F5"),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: longueurPerCent(20, context),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: largeurPerCent(20, context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: HexColor("#DDDDDD"),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding:  EdgeInsets.only(left: largeurPerCent(20, context)),
                    child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                  ),
                  labelText: "Rechercher un produit",
                  labelStyle: TextStyle(
                      color: HexColor('#9B9B9B'),
                      fontSize: 17.0,
                      fontFamily: 'MonseraLight'),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 5, left:100),

                ),
              )),
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
                Icons.notifications_none,
                color: Colors.white,
                size: 79.0,
              ),
            ),
          ),
          SizedBox(height: longueurPerCent(20.0, context),),
          Center(
            child: Text(
              'AUCUNE NOTIFICATION',
              style: TextStyle(color: HexColor("#909090"), fontFamily: 'Regular', fontSize: 16.0, ),
            ),
          ),
        ],
      ),
    );
  }
}