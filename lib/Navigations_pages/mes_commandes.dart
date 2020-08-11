import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/commandes.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/DetailsCommandes.dart';

class MesCommandes extends StatefulWidget {
  @override
  _MesCommandesState createState() => _MesCommandesState();
}

class _MesCommandesState extends State<MesCommandes> {

List<Map<String, dynamic>> commandes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Renseignements.emailUser);
     Firestore.instance
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .collection("Commandes")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (int i = 0; i < snapshot.documents.length; i++) {
        print(snapshot.documents.length);
         setState(() {
           commandes.add(snapshot.documents[i].data);
         });
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des commandes"),
      ),
      body: (commandes!=null)?Center(
          child: Container(
              margin: EdgeInsets.only(top: longueurPerCent(30, context), left: largeurPerCent(20, context), right: largeurPerCent(20, context), ),
              child: ListView.builder(
                  itemCount:commandes.length,
                  itemBuilder: (context, i){
                    return  Container(
                      margin: EdgeInsets.only(bottom: longueurPerCent(20, context)),
                      height: longueurPerCent(160, context),
                      width: largeurPerCent(360.0, context),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        elevation: 7.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: largeurPerCent(360.0, context),
                              child: Material(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                                color: HexColor("#FFC30D"),
                                child: Padding(
                                  padding: EdgeInsets.all(longueurPerCent(10, context)),
                                  child: Text(
                                    "Commande n°1",
                                    style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 19.0, fontWeight: FontWeight.bold ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: longueurPerCent(10, context),),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: longueurPerCent(0.0, context),
                                      right: longueurPerCent(0.0, context),
                                      left: longueurPerCent(10.0, context)),
                                  child: Text(
                                    "Nbre de produits",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: HexColor("#909090"),
                                        fontSize: 12,
                                        fontFamily: "MonseraBold"),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(right: largeurPerCent(12, context)),
                                    child: Text(
                                      "${commandes[i]["produitsCommander"].length}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: HexColor("#001C36"),
                                        fontSize: 12,
                                        fontFamily: "MontserratBold",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: longueurPerCent(10, context),),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: longueurPerCent(0.0, context),
                                      right: longueurPerCent(0.0, context),
                                      left: longueurPerCent(10.0, context)),
                                  child: Text(
                                    "Total",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: HexColor("#909090"),
                                        fontSize: 12,
                                        fontFamily: "MonseraBold"),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    child: Text(
                                      "${commandes[i]["sousTotal"]}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: HexColor("#001C36"),
                                        fontSize: 12,
                                        fontFamily: "MontserratBold",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:  EdgeInsets.only(right: longueurPerCent(12, context)),
                                    child: Text(
                                      " FCFA",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: HexColor("#001C36"),
                                        fontSize: 12,
                                        fontFamily: "MontserratBold",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: longueurPerCent(10, context),),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: longueurPerCent(0.0, context),
                                      right: longueurPerCent(0.0, context),
                                      left: longueurPerCent(10.0, context)),
                                  child: Text(
                                    "Statut",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: HexColor("#909090"),
                                        fontSize: 12,
                                        fontFamily: "MonseraBold"),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(right: longueurPerCent(12, context)),
                                    child: (commandes[i]["livrer"]==false)?Text(
                                      "En cours",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontFamily: "MontserratBold",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ):Text(
                                      "Livrer",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                        fontFamily: "MontserratBold",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height:longueurPerCent(20.0, context)),
                            Container(
                              margin: EdgeInsets.only(bottom: longueurPerCent(10, context), ),
                              height: longueurPerCent(20.0, context),
                              width: largeurPerCent(70.0, context),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                    return DetailsCommandes(commande:commandes[i], longueur: commandes[i]["produitsCommander"].length);
                                  }));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: HexColor("#001C36"),
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text(
                                      'VOIR',
                                      style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 12.0, fontWeight: FontWeight.bold ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              )
          )
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
/*     */