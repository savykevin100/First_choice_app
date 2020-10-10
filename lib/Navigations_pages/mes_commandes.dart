import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/DetailsCommandes.dart';

class MesCommandes extends StatefulWidget {
  @override
  _MesCommandesState createState() => _MesCommandesState();
}

class _MesCommandesState extends State<MesCommandes> {

List<Map<String, dynamic>> commandes=[];
int loading=0;
int taille;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Renseignements.emailUser);
    Firestore.instance
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .collection("Commandes")
        .orderBy("created")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
         if(snapshot.documents.isNotEmpty){
           setState(() {
             taille=snapshot.documents.length;
           });
           for (int i = 0; i < snapshot.documents.length; i++) {
             print(snapshot.documents.length);
             setState(() {
               commandes.add(snapshot.documents[i].data);
               loading++;
             });
           }
         } else {
           setState(() {
             taille=0;
           });
         }
    });

  }
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if(loading==taille){
      return Scaffold(
          appBar: AppBar(
            title: Text("Liste des commandes"),
          ),
          body: ConnexionState(body:
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: longueurPerCent(30, context), left: largeurPerCent(20, context), right: largeurPerCent(20, context), ),
                  child: ListView.builder(
                      reverse: true,
                      itemCount:commandes.length,
                      itemBuilder: (context, i){
                        return  Container(
                          margin: EdgeInsets.only(bottom: longueurPerCent(20, context)),
                          width: largeurPerCent(360.0, context),
                          child: Material(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            elevation: 7.0,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Material(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7),),
                                    color: HexColor("#FFC30D"),
                                    child: Padding(
                                      padding: EdgeInsets.all(longueurPerCent(10, context)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                         /* Text(
                                            "${commandes[i]["numberOrder"]}",
                                            style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 15.0, fontWeight: FontWeight.bold ),
                                          ),*/
                                         // Text(commandes[i]["created"].toString().substring(0, 19),   style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 12.0, fontWeight: FontWeight.bold ),)
                                          Text(commandes[i]["created"],   style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 12.0, fontWeight: FontWeight.bold ),)
                                        ],
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: longueurPerCent(0.0, context),
                                          right: longueurPerCent(0.0, context),
                                          left: longueurPerCent(10.0, context)),
                                      child: Text(
                                        "Total        ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: HexColor("#909090"),
                                            fontSize: 12,
                                            fontFamily: "MonseraBold"),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(right: longueurPerCent(12, context)),
                                      child: PriceWithDot(price: commandes[i]["sousTotal"], size:12 ,
                                        couleur: HexColor("#001C36"), police:  "MontserratBold",
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
                                          child:statutCommande((commandes[i]["livrer"]))
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height:longueurPerCent(20.0, context)),
                                Container(
                                  margin: EdgeInsets.only(bottom: longueurPerCent(10, context), ),
                                  height: longueurPerCent(30.0, context),
                                  width: largeurPerCent(100.0, context),
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
          ),)
      );
    } else if(loading!=taille && taille!=0){
      return Scaffold(
        appBar:AppBar(
          title: Text("Liste des commandes"),
        ),
        body:  Center(child: CircularProgressIndicator(),),
      );
    } else if(taille==0){
      return Scaffold(
        appBar: AppBar(
          title: Text("Liste des commandes"),
        ),
        body: Center(
          child: Text("Pas de commande"),
        ),
      );
    }
  }

      Widget statutCommande(String statut){
        if(statut=="En cours"){
         return Text(
              "En cours",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontFamily: "MontserratBold",
                fontWeight: FontWeight.bold,
              ));
        } else if(statut=="Livrer"){
          return Text(
              "Livrer",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontFamily: "MontserratBold",
                fontWeight: FontWeight.bold,
              ));
        } else {
          return Text(
              "Annuler",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontFamily: "MontserratBold",
                fontWeight: FontWeight.bold,
              ));
        }
      }

}
/*     */