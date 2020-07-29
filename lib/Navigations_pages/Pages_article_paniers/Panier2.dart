import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/commande_send.dart';


class Panier2 extends StatefulWidget {
  static String id='Panier2';
  String nomComplet;
  String telephone;
  String lieuDeLivraison;
  String quartier;
  String indication;
  String dateDeLivraison;
  String heureDeLivraison;
  int total;
  int prixLivraison;
  Panier2({this.prixLivraison, this.nomComplet, this.total, this.telephone, this.lieuDeLivraison, this.quartier, this.indication, this.dateDeLivraison, this.heureDeLivraison});
  @override
  _Panier2State createState() => _Panier2State();
}

class _Panier2State extends State<Panier2> {
  String payement;
  String _dropDownValue2;
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

        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(30.0, context)),
                      child: Text(
                        "SOUS TOTAL",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#909090"),
                            fontSize: 18,
                            fontFamily: "Montserrat_Light"),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: largeurPerCent(90, context)),
                      child: Text(
                        "${widget.total} FCFA",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 16,
                          fontFamily: "MontserratBold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(20.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(30.0, context)),
                      child: Text(
                        "LIVRAISON",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#909090"),
                            fontSize: 18,
                            fontFamily: "Montserrat_Light"),
                      ),
                    ),
                    Container(
                      width: largeurPerCent(190.0, context),
                      margin: EdgeInsets.only(top: longueurPerCent(20.0, context),left: longueurPerCent(0.0, context) ),
                      child: Text(
                        "${widget.prixLivraison}  FCFA",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#909090"),
                          fontSize: 16,
                          fontFamily: "MontserratBold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(20.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(40.0, context)),
                      child: Text(
                        "TOTAL",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#909090"),
                            fontSize: 18,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: largeurPerCent(190.0, context),
                      margin: EdgeInsets.only(top: longueurPerCent(20.0, context),right:longueurPerCent(25.0, context),left: longueurPerCent(20.0, context) ),
                      child: Text(
                        "${widget.total+widget.prixLivraison} FCFA",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: HexColor("#001C36"),
                          fontSize: 16,
                          fontFamily: "MontserratBold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: longueurPerCent(25, context),),
                Container(
                  child:Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(30.0, context)),
                        child: Text(
                          "Moyen de payement",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 16,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(20.0, context)),
                        width: largeurPerCent(180.0, context),
                        height: longueurPerCent(40, context),
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
                          hint: _dropDownValue2 == null
                              ? Text(
                            'Payement',
                            style: TextStyle(
                                color: HexColor('#919191'),
                                fontSize: 17.0,
                                fontFamily: 'MonseraLight'),
                          )
                              : Text(
                            _dropDownValue2,
                            style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 16),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: HexColor("#001C36")),
                          items: ['Mobile Money', 'Moov Money', 'En espèce'].map(
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
                                _dropDownValue2 = val;
                                payement=_dropDownValue2;
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
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(30.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(95.0, context)),
                      child: Text(
                        "Numéro:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#909090"),
                            fontSize: 18,
                            fontFamily: "MontserratBold",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: largeurPerCent(190.0, context),
                      margin: EdgeInsets.only(top: longueurPerCent(30.0, context),right:longueurPerCent(0.0, context),left: longueurPerCent(20.0, context) ),                  child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "61831183",
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
                          setState(() {

                          });
                        }
                    ),
                    ),
                  ],
                ),
                SizedBox(height:longueurPerCent(100.62, context)),
                button( HexColor("#FFFFFF"), HexColor("#001C36"), context,  'COMMANDER', (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CommandeSend()));
                }),
              ],
            ),
          ),
        )
    );
  }

}