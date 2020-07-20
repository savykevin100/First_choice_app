import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/composants/calcul.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


class Panier3 extends StatefulWidget {
  static String id='Panier3';
  @override
  _Panier3State createState() => _Panier3State();
}

class _Panier3State extends State<Panier3> {
  String lieu;
  String quartier;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#001c36"),
        title: Text("Panier", style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),),
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
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: longueurPerCent(37.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(0.0, context)),
                child: Center(
                  child: Text(
                    "Informations de la  commande",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 20.0,
                        fontFamily: "MontserratBold",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(height: longueurPerCent(0.0, context),),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(67.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(140.0, context)),
                      child: Text(
                        "Nom",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 20.0,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(67.0, context),right: longueurPerCent(168.0, context),left: longueurPerCent(14.0, context)),
                      child: Text(
                        "Savy",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 20.0,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(height: longueurPerCent(0.0, context),),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(14.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(110.0, context)),
                      child: Text(
                        "Prénom",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 20.0,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(14.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(16.0, context)),
                      child: Text(
                        "Hermann",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 20.0,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(height: longueurPerCent(0.0, context),),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(14.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(86.0, context)),
                      child: Text(
                        "Teléphone",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 20.0,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(14.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(16.0, context)),
                      child: Text(
                        "69 06 38 00",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 20.0,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: longueurPerCent(46.0, context),),
              Container(
                child:Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(35.0, context)),
                      child: Text(
                        "Lieu de livraison",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 20,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Container(
                      width: longueurPerCent(175.0, context),
                      height: largeurPerCent(70, context),
                      margin: EdgeInsets.only(left: longueurPerCent(23.0, context),right: longueurPerCent(26.0, context)),
                      color: HexColor("#FFFFFF"),
                      child: DropDownFormField(
                        titleText: null,
                        errorText: 'Choisissez un lieu',
                        hintText: 'domicile',
                        value: lieu,
                        dataSource: [
                          {
                            "display": "A domicile",
                            "value": "A domicile",
                          },
                          {
                            "display": "En Agence",
                            "value": "En Agence",
                          },
                        ],
                        onChanged: (value) {
                          setState(() {
                            lieu = value;

                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return ("Veuillez choisir un lieu de livraison");
                          }
                          return null;
                        },
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: longueurPerCent(46.0, context),),
              Container(
                child:Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(35.0, context)),
                      child: Text(
                        "Quartier",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 20,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Container(
                      width: longueurPerCent(175.0, context),
                      height: largeurPerCent(70, context),
                      margin: EdgeInsets.only(left: longueurPerCent(23.0, context),right: longueurPerCent(26.0, context)),
                      color: HexColor("#FFFFFF"),
                      child: DropDownFormField(
                        titleText: null,
                        errorText: 'Choisissez un lieu',
                        hintText: 'Quartier',
                        value: quartier,
                        dataSource: [
                          {
                            "display": "Vodjè",
                            "value": "Vodjè",
                          },
                          {
                            "display": "Gbegamey",
                            "value": "Gbegamey",
                          },
                          {
                            "display": "Finagnon",
                            "value": "Finagnon",
                          },
                          {
                            "display": "Fidjrossè",
                            "value": "Fidjrossè",
                          },
                          {
                            "display": "Agla",
                            "value": "Agla",
                          },
                          {
                            "display": "Houeyiho",
                            "value": "Houeyiho",
                          },
                          {
                            "display": "Aïbatin",
                            "value": "Aïbatin",
                          },
                          {
                            "display": "Vedoko",
                            "value": "Vedoko",
                          },
                          {
                            "display": "Zogbo",
                            "value": "Zogbo",
                          },
                        ],
                        onChanged: (value) {
                          setState(() {
                            quartier = value;

                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return ("Veuillez choisir un lieu de livraison");
                          }
                          return null;
                        },
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),

                  ],
                ),
              ),


              Row(
                children: <Widget>[
                  SizedBox(height: longueurPerCent(70.0, context),),
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(33.0, context)),
                    child: Text(
                      "Indication",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: HexColor("#909090"),
                        fontSize: 20,
                        fontFamily: "Regular",
                      ),
                    ),
                  ),

                  //Ajouter le textField ici
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(14.0, context),left: longueurPerCent(30.0, context)),
                    height: longueurPerCent(76.0, context),
                    width: largeurPerCent(229, context),
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: null,
                          labelStyle: TextStyle(fontSize: 13)
                      ),
                    ),
                  )


                ],
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(height: longueurPerCent(70.0, context),),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(33.0, context)),
                      child: Text(
                        "Date de livraison",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 20,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(16.0, context)),
                      child: Text(
                        "15-07-2020",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 20.0,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(height: longueurPerCent(22.0, context),),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(20.0, context)),
                      child: Text(
                        "Heure de livraison",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 20,
                          fontFamily: "Regular",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(16.0, context)),
                      child: Text(
                        "15h 30",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 20.0,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height:longueurPerCent(40.0, context)),
              Center(
                child: Container(
                  margin: EdgeInsets.only(right: longueurPerCent(18.0, context),left: longueurPerCent(18.0, context),),
                  height: longueurPerCent(50.0, context),
                  width: largeurPerCent(339.0, context),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    //shadowColor: Colors.greenAccent,
                    color: HexColor("#001C36"),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'CONFIRMER',
                          style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: CupertinoColors.white,
                height: 68,
              ),

            ],
          ),
        )

    );
  }
}