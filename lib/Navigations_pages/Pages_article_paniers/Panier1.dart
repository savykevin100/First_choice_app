import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier2.dart';
import 'package:intl/intl.dart';


class Panier1 extends StatefulWidget {
  static String id='Panier1';
  int total;
  Panier1({this.total});
  @override
  _Panier1State createState() => _Panier1State();
}

class _Panier1State extends State<Panier1> {
  String lieu;
  String quartier;
  String _dropDownValue;
  Firestore _db=Firestore.instance;
  String name;
  String numUser;
  int prixLivraison;
  String date;
  String heure;
  String indication;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();




  Future<void> fetchNameNumUser() async {
   await _db.collection("Utilisateurs").document(Renseignements.emailUser).get().then((value){
        setState(() {
          name=value.data["nomComplet"];
          numUser=value.data["numeroDePayement"];
        });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNameNumUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: HexColor("#001c36"),
        title: Text("Panier", style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),),
      ),
        body: (numUser!=null && name!=null)? SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: longueurPerCent(37.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(0.0, context)),
                  child: Center(
                    child: Text(
                      "INFORMATIONS DE LA COMMANDE",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: HexColor("#001C36"),
                          fontSize: 20.0,
                          fontFamily: "MonseraBold",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(30, context)),
                Center(
                  child: Text(
                  name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 20.0,
                        fontFamily: "MonseraLight",
                        fontWeight: FontWeight.bold),
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
                          numUser,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 20.0,
                              fontFamily: "MonseraLight",
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
                 //////////////////////////////////////////////////////////////////////////////////////////////

                ///Ici on fait la récupération du lieu de livraison pour l'appariton des champs quartier et indication
                (lieu=="A domicile")?Column(
                  children: <Widget>[
                    Container(
                      child:Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(60.0, context)),
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
                              hint: quartier == null
                                  ? Text(
                                'Quartier',
                                style: TextStyle(
                                    color: HexColor('#919191'),
                                    fontSize: 17.0,
                                    fontFamily: 'MonseraLight'),
                              )
                                  : Text(
                                quartier,
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
                                "Houeyiho",
                                "Calavi",
                                "Godomey",
                                "Bidossessi",
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
                                    quartier=val;
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
                        SizedBox(height: longueurPerCent(50.0, context),),
                        Padding(
                          padding:EdgeInsets.only(top: longueurPerCent(0.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(33.0, context)),
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
                                indication=value;
                              },

                          ),
                        )
                      ],
                    ),
                  ],
                ):Text(""),
                ////////////////////////////////////////////////////////////////////////////////////////////////
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(height: longueurPerCent(70.0, context),),

                      Container(
                        height: longueurPerCent(40, context),
                        width: largeurPerCent(300.0, context),
                        margin: EdgeInsets.only(top: longueurPerCent(0.0, context),left: longueurPerCent(50.0, context)),
                        child: DateTimeField(
                          format: DateFormat("dd-MM-yyyy"),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  top: longueurPerCent(5, context),
                                  bottom: longueurPerCent(5, context),
                                  right: largeurPerCent(10, context),
                                  left: largeurPerCent(10, context)),
                              child: Icon(
                                Icons.calendar_today,
                                color: HexColor('#001C36'),
                                size: 30.0,
                              ),
                            ),
                            labelText: "Date de livraison",
                            labelStyle: TextStyle(
                                color: HexColor('#919191'),
                                fontSize: 17.0,
                                fontFamily: 'MonseraLight'),
                            hintText: "10/06/2000",
                            hintStyle: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 17.0,
                                fontFamily: 'MonseraLight'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0)),
                                borderSide: BorderSide(
                                    width: 1, style: BorderStyle.none)),
                          ),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                          onChanged: (value){
                           setState(() {
                             if(value.day.toString().length==1 && value.month.toString().length==1){
                               date = "0${value.day}"+ "-0${value.month}"+"-${value.year}";
                             } else if(value.day.toString().length!=1 && value.month.toString().length==1){
                               date = "${value.day}"+ "-0${value.month}"+"-${value.year}";
                             } else if(value.day.toString().length==1 && value.month.toString().length!=1){
                               date = "0${value.day}"+ "-${value.month}"+"-${value.year}";
                             } else  date = "${value.day}"+ "-${value.month}"+"-${value.year}";
                           });
                           },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                      height: longueurPerCent(40, context),
                      width: largeurPerCent(300.0, context),
                      margin: EdgeInsets.only(top: longueurPerCent(20.0, context),right: longueurPerCent(0.0, context),left: longueurPerCent(10.0, context)),
                      child: DateTimeField(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                top: longueurPerCent(5, context),
                                bottom: longueurPerCent(5, context),
                                right: largeurPerCent(10, context),
                                left: largeurPerCent(10, context)),
                            child: Icon(
                              Icons.access_time,
                              color: HexColor('#001C36'),
                              size: 30.0,
                            ),
                          ),
                          labelText: "Heure de livraison",
                          labelStyle: TextStyle(
                              color: HexColor('#919191'),
                              fontSize: 17.0,
                              fontFamily: 'MonseraLight'),
                          hintText: "10/06/2000",
                          hintStyle: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 17.0,
                              fontFamily: 'MonseraLight'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0)),
                              borderSide: BorderSide(
                                  width: 1, style: BorderStyle.none)),
                        ),
                        format:  DateFormat("HH:mm"),
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                        onChanged: (value){
                          if(value.hour.toString().length==1 && value.minute.toString().length==1){
                            heure = "0${value.hour}"+ ":0${value.minute}";
                          } else if(value.hour.toString().length!=1 && value.minute.toString().length==1){
                            heure = "${value.hour}"+ ":0${value.minute}";
                          } else if(value.hour.toString().length==1 && value.minute.toString().length!=1){
                            heure = "0${value.hour}"+ ":${value.minute}";
                          } else  date = "${value.hour}"+ ":${value.minute}";
                        },
                      ),
                    ),

                SizedBox(height:longueurPerCent(40.0, context)),
                Center(
                  child: button(Colors.white, HexColor("#001C36"), context, 'CONFIRMER', (){
                   checkInformationsComplete(context);
                  }),
                ),
                SizedBox(height: longueurPerCent(30, context),)
              ],
            ),
          ),
        ):Center(child: CircularProgressIndicator(),)
    );
  }
  displaySnackBarNom(BuildContext context, String text, Color couleur ) {
    final snackBar = SnackBar(content: Text(text,   style: TextStyle(color: couleur, fontSize: 15)),);
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  void checkInformationsComplete(context){
    if(lieu=='En Agence' && heure!=null && date!=null ) {
     print("Reusssie");
      _db.collection("Zones").getDocuments().then((value){
        for(int i=0; i<value.documents.length;i++){
          if(value.documents[i].data.containsValue("Houeyiho")){
            setState(() {
              prixLivraison=value.documents[i].data["prix"];
              print(value.documents[i].data["prix"]);
            });
          }
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Panier2(prixLivraison: prixLivraison, total: widget.total, nomComplet: name, telephone: numUser, lieuDeLivraison: lieu,dateDeLivraison: date, heureDeLivraison: heure,indication: indication, quartier: quartier,)));
        print(widget.total);
      });
    } else if(lieu=="A domicile" && date!=null && heure!=null && indication!=null && quartier!=null) {
      _db.collection("Zones").getDocuments().then((value){
        for(int i=0; i<value.documents.length;i++){
          if(value.documents[i].data.containsValue(quartier)){
            setState(() {
              prixLivraison=value.documents[i].data["prix"];
              print(value.documents[i].data["prix"]);
            });
          }
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Panier2(prixLivraison: prixLivraison, total: widget.total, nomComplet: name, telephone: numUser, lieuDeLivraison: lieu,dateDeLivraison: date, heureDeLivraison: heure,indication: indication, quartier: quartier,)));
        print(widget.total);
      });
    } else {
      print(date);
      print(heure);
      displaySnackBarNom(context, "Veuillez remplir tous les champs ", Colors.red);
    }

}}