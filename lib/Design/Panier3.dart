import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


class Panier3 extends StatefulWidget {
  static String id='Panier3';
  @override
  _Panier3State createState() => _Panier3State();
}

class _Panier3State extends State<Panier3> {
  String lieu;
  String quartier;
  String _dropDownValue;
  String _dropDownValue1;
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
          child: Center(
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
                        margin: EdgeInsets.only(top: longueurPerCent(67.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(129.0, context)),
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
                        margin: EdgeInsets.only(top: longueurPerCent(67.0, context),left: longueurPerCent(16.0, context)),
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
                        margin: EdgeInsets.only(top: longueurPerCent(14.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(100.0, context)),
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
                        margin: EdgeInsets.only(top: longueurPerCent(14.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(80, context)),
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
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(20.0, context)),
                        width: largeurPerCent(175.0, context),
                        height: longueurPerCent(50, context),
                        padding: EdgeInsets.only(
                            left: largeurPerCent(20, context),
                            right: largeurPerCent(20, context),
                            top: longueurPerCent(0, context)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            border: Border.all(
                                color: HexColor("#919191"), width: 1)),
                        child: DropdownButton(
                          hint: _dropDownValue == null
                              ? Text(
                            'Lieu',
                            style: TextStyle(
                                color: HexColor('#919191'),
                                fontSize: 17.0,
                                fontFamily: 'MonseraLight'),
                          )
                              : Text(
                            _dropDownValue,
                            style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 20),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: HexColor("#001C36")),
                          items: ['En Agence', 'A domicile'].map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                _dropDownValue = val;
                                lieu=_dropDownValue;
                              },
                            );
                          },
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
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(108.0, context)),
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
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(25.0, context)),
                        width: largeurPerCent(175.0, context),
                        height: largeurPerCent(50, context),
                        padding: EdgeInsets.only(
                            left: largeurPerCent(20, context),
                            right: largeurPerCent(20, context),
                            top: longueurPerCent(0, context)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            border: Border.all(
                                color: HexColor("#919191"), width: 1)),
                        child: DropdownButton(
                          hint: _dropDownValue1 == null
                              ? Text(
                            'Quartier',
                            style: TextStyle(
                                color: HexColor('#919191'),
                                fontSize: 17.0,
                                fontFamily: 'MonseraLight'),
                          )
                              : Text(
                            _dropDownValue1,
                            style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 17),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: HexColor("#001C36")),
                          items: [
                            "Vodjè",
                            "Gbegamey",
                            "Finagnon",
                            "Fidjrossè",
                            "Agla",
                            "Houeyiho",
                            "Houeyiho",
                            "Aïbatin",
                            "Vedoko",
                            "Zogbo",
                          ].map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                _dropDownValue1 = val;
                                quartier=_dropDownValue1;
                              },
                            );
                          },
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
                      child:  TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: null,
                            hintStyle: TextStyle(
                                color: HexColor('#919191'),
                                fontSize: 17.0,
                                fontFamily: 'MonseraLight'),
                            fillColor: Colors.white,
                            contentPadding:
                            EdgeInsets.only(top: 30, bottom: 5, left: 30),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                    width: 1, style: BorderStyle.none)),
                          ),
                          onChanged: (value){
                          }
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
                        height: longueurPerCent(40, context),
                        width: largeurPerCent(183.0, context),
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(16.0, context)),
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "10/06/2020",
                              hintStyle: TextStyle(
                                  color: HexColor('#919191'),
                                  fontSize: 17.0,
                                  fontFamily: 'MonseraLight'),
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.only(top: 10, bottom: 5, left: 30),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                      width: 1, style: BorderStyle.none)),
                            ),
                            onChanged: (value){
                            }
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
                        height: longueurPerCent(40, context),
                        width: largeurPerCent(183.0, context),
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(18.0, context)),
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "18h30",
                              hintStyle: TextStyle(
                                  color: HexColor('#919191'),
                                  fontSize: 17.0,
                                  fontFamily: 'MonseraLight'),
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.only(top: 10, bottom: 5, left: 30),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                      width: 1, style: BorderStyle.none)),
                            ),
                            onChanged: (value){
                              
                            }
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
          ),
        )

    );
  }
}