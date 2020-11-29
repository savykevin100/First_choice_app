import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Drawer/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/notifications.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';

import '../checkConnexion.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int nombreAjoutPanier=0;
  final controller = ScrollController();

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle( color: HexColor("#001C36"),
            fontSize: 15.0,
            fontFamily: "MonseraBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NON", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),

          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("OUI", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Notifications",
        context: context,
        controller: controller,
        nbAjoutPanier: nombreAjoutPanier);
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: _appBar.appBarFunctionStream(),
      drawer: (Renseignements.userData.length==5)?ProfileSettings(
          userCurrent: Renseignements.userData[1],
          firstLetter:Renseignements.userData[2][0]
      ):ProfileSettings(
          userCurrent: "",
          firstLetter: ""),
      body: Test(displayContains: WillPopScope(
        onWillPop:_onBackPressed,
        child:StreamBuilder(
            stream: FirestoreService().getNotifications(),
            builder: (BuildContext context,
                AsyncSnapshot<List<InformationNotification>> snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return  Center(child: SpinKitFadingCircle(
                  color: HexColor("#001c36"),
                  size: 30,));
              } else if(snapshot.data.isEmpty)
                return elementsVides(context, Icons.notifications_none, "Pas de nouvelle notification");
              else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i){
                      InformationNotification notification = snapshot.data[i];
                      return Container(
                        margin: EdgeInsets.only(left: longueurPerCent(10, context),right: longueurPerCent(10, context), bottom: longueurPerCent(10, context), top: longueurPerCent(10, context)),
                        child: Material(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.white,
                          elevation: 3.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, bottom: 5, left: 8),
                                    child: Text(
                                      notification.titre,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: HexColor("#001C36"),
                                        fontSize: 12,
                                        fontFamily: "MonseraBold",
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                      largeurPerCent(250, context),
                                    ),
                                    child:  Padding(
                                      padding: EdgeInsets.only(left: largeurPerCent(10, context), bottom: longueurPerCent(10, context)),
                                      child: Text(
                                        notification.description,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: HexColor("#001C36"),
                                          fontSize: 10,
                                          fontFamily: "MonseraRegular",
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: longueurPerCent(10, context), right: largeurPerCent(10, context)),
                                child: Text(
                                  notification.created,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: HexColor("#909090"),
                                    fontSize: 8,
                                    fontFamily: "MonseraRegular",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                );
              }
            }),
      ),)
    );

  }
}