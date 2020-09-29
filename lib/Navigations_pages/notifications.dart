import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/notifications.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
 int nombreAjoutPanier;
 final controller = ScrollController();


 Future<bool> _onBackPressed() {
   return showDialog(
     context: context,
     builder: (context) => new AlertDialog(
       title: new Text("Fermer l'application",  style: TextStyle(fontFamily: "MonseraBold")),
       content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
       actions: <Widget>[
         new GestureDetector(
             onTap: () => Navigator.of(context).pop(false),
             child: Text("Non", style: TextStyle(fontFamily: "MonseraBold"),)
         ),
         SizedBox(width: largeurPerCent(50, context),),
         new GestureDetector(
             onTap: () => Navigator.of(context).pop(true),
             child: Text("Oui", style: TextStyle(fontFamily: "MonseraBold"),)
         ),
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
        titre: "Notifications", context: context, controller: controller, );
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar: _appBar.appBarFunctionStream(),
      drawer: ProfileSettings(
          userCurrent: Renseignements.userData[1],
          firstLetter:Renseignements.userData[2][0]
      ),
      body: WillPopScope(
        onWillPop:_onBackPressed,
        child:StreamBuilder(
            stream: FirestoreService().getNotifications(),
            builder: (BuildContext context,
                AsyncSnapshot<List<InformationNotification>> snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if(snapshot.data.isEmpty)
                return elementsVides(context, Icons.notifications_none, "PAS DE NOUVEAUX NOTIFICATIONS");
              else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i){
                      InformationNotification notification = snapshot.data[i];
                      return Column(
                        children: <Widget>[
                          SizedBox(height: longueurPerCent(20.0, context),),
                          Container(
                            margin: EdgeInsets.only(left: longueurPerCent(10, context),right: longueurPerCent(10, context)),
                            child: Material(
                              borderRadius: BorderRadius.circular(7.0),
                              color: Colors.white,
                              elevation: 7.0,
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8),
                                        child: Text(
                                          notification.titre,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: HexColor("#001C36"),
                                            fontSize: 15,
                                            fontFamily: "MonseraBold",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:EdgeInsets.only(bottom: longueurPerCent(5, context),left: longueurPerCent(8, context)),
                                        width: largeurPerCent(340.0, context),
                                        child: Text(
                                         notification.description,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: HexColor("#001C36"),
                                            fontSize: 13,
                                            fontFamily: "MonseraBold",
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 10,left: 8),
                                          child: Text(
                                            notification.created,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: HexColor("#909090"),
                                              fontSize: 12,
                                              fontFamily: "MontserratBold",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: longueurPerCent(10.0, context),),
                        ],
                      );
                    }

                );
              }
            }),
      ),
    );

  }
}
