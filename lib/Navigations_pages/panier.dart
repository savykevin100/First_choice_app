import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier1.dart';
import 'package:premierchoixapp/Models/panier_classe.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Panier extends StatefulWidget {
  static String id = 'Panier';

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  Firestore _db = Firestore.instance;
  int total = 0;
  List<Map<String, dynamic>> produitsPaniers=[];
  List<Map<String, dynamic>> produitsIndisponibles=[];
  int ajoutPanier;
  int chargementProduitsIndisponible=0;
  int numberProductOrder=0;
  String prixWithDot="0";





  /// Cette fonction getIdProduit permet de recuperer l'id du produit en vue de pouvoir le supprimer. Donc je récupère tous les ID
  /// dans la variable idProduitsPanier et au moment de la suppression je supprimer le produit qui est à l'index i
  Future<void> getProduitPanier() async {
    await _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .collection("Panier")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (int i = 0; i < snapshot.documents.length; i++) {
        if (this.mounted) {
          setState(() {
            // Ici on parcourt les produits qui sont dans la table ProduitsIndisponibles et on vérifie si un des produits dans le panier
            // se trouve cette dernière table
            _db .collection("ProduitsIndisponibles").where("image1", isEqualTo:snapshot.documents[i].data["image1"])
                .getDocuments().then((QuerySnapshot snapshot){
              if(snapshot.documents.isNotEmpty){
               if(this.mounted){
                 setState(() {
                   produitsIndisponibles.add(snapshot.documents[0].data);
                   print(snapshot.documents[0].data["nomDuProduit"]);
                 });
               }
              } else {
                setState(() {
                  chargementProduitsIndisponible++;
                });
              }
            });
             // Fin de la vérification
            produitsPaniers.add(snapshot.documents[i].data);
          });
        }
      }
    });


  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  /// Cette fonction permet de récuperer le nombre d'ajout panier qui se trouve dans les variables de l'utilisateur. Cette variable est récupérée pour
  /// que quand tous les produits sont supprimés du panier le nombre de produits dans le panier soit mise à jour
  void getNombreProduitPanier() {
    _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
          ajoutPanier = value.data["nbAjoutPanier"];
        });
      }
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////
  /// Cette fonction permet de faire la somme des prix de tous les produits présents dans le panier
  void sumPrice() {
    _db.collection("Utilisateurs").document(Renseignements.emailUser)
        .collection("Panier").getDocuments()
        .then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        if (this.mounted) {
          setState(() {
            numberProductOrder++;
            total = total + value.documents[i].data["prix"];
            prixWithDot = priceWithDot(total);
          });
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    getProduitPanier();
    getNombreProduitPanier();
    sumPrice();
  }

  @override
  Widget build(BuildContext context) {
    if (total != null && produitsPaniers!=null && (chargementProduitsIndisponible==produitsPaniers.length || produitsIndisponibles!=null) ) {
      return Scaffold(
          backgroundColor: HexColor("#F5F5F5"),
          appBar: AppBar(
              backgroundColor: HexColor("#001c36"),
              title: StreamBuilder(
                  stream: FirestoreService().getProduitPanier(
                      Renseignements.emailUser),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PanierClasse>> snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Text("");
                    } else {
                      return Text(
                        " TOTAL" +  "  ($numberProductOrder)   :  " +   " $prixWithDot FCFA" ,textAlign: TextAlign.start, style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "MonseraBold"),);
                    }
                  }
              )
          ),
          body: ConnexionState(body: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  StreamBuilder(
                      stream:
                      FirestoreService().getProduitPanier(
                          Renseignements.emailUser),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PanierClasse>> snapshot) {
                        if (snapshot.hasError || !snapshot.hasData) {
                          return Column(
                            children: <Widget>[
                              SizedBox(height: longueurPerCent(300, context),),
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else if (snapshot.data.isEmpty) {
                          return elementsVides(context, Icons.shopping_cart,
                              "Pas de nouveaux produits ajoutés");
                        }
                        else {
                          /* */
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                bool dejaCommader=false;
                                PanierClasse panier = snapshot.data[i];
                                for(int i=0; i<produitsIndisponibles.length; i++){
                                  if(produitsIndisponibles[i]["image1"]==panier.image1)
                                    dejaCommader=true;
                                }
                                return Container(
                                  margin: EdgeInsets.only(
                                    top: longueurPerCent(18, context),
                                    left:longueurPerCent(18,context),
                                    right:longueurPerCent(18,context),
                                  ),
                                  height: longueurPerCent(100, context),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(7.0),
                                    elevation: 4,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: longueurPerCent(10, context),
                                            bottom: longueurPerCent(10, context),
                                            left:longueurPerCent(10,context),
                                          ),
                                          height: longueurPerCent(
                                              100, context),
                                          width: largeurPerCent(80, context),
                                          child: Image.network(
                                            panier.image1,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              margin:EdgeInsets.only(top: longueurPerCent(13, context),
                                                  left: longueurPerCent(10, context)),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(height: longueurPerCent(0, context),),
                                                  Text(
                                                    "${panier.nomDuProduit} ",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: HexColor(
                                                            "#909090"),
                                                        fontSize: 15,
                                                        fontFamily: "Regular"),
                                                  ),
                                                  SizedBox(
                                                    height: longueurPerCent(
                                                        4.0, context),
                                                  ),
                                                  Text(
                                                    "${panier.taille}",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: HexColor("#001C36"),
                                                      fontSize: 12,
                                                      fontFamily: "MontserratBold",
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: longueurPerCent(
                                                        15.0, context),
                                                  ),
                                                  PriceWithDot(price: panier.prix, couleur: HexColor("#00CC7b",),size: 16, police: "MontseraBold",),

                                                ],
                                              )
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(height: longueurPerCent(10, context),),
                                                (dejaCommader)?Text("Déjà commandé", style: TextStyle(color: Colors.red),):Text(""),
                                                Container(
                                                  margin: EdgeInsets.only(left: longueurPerCent(50, context)),
                                                  child: IconButton(icon: Icon(
                                                      Icons.delete, color: Colors.red, size: 20),
                                                      onPressed: () {
                                                        setState(() {
                                                          ajoutPanier--;
                                                        });
                                                        FirestoreService().deletePanier(Renseignements.emailUser, panier.id);
                                                        for(int i=0; i<produitsIndisponibles.length; i++){
                                                          if(produitsIndisponibles[i]["image1"]==panier.image1)
                                                            setState(() {
                                                              produitsIndisponibles.removeAt(i);
                                                            });
                                                        }
                                                        _db
                                                            .collection("Utilisateurs")
                                                            .document(
                                                            Renseignements.emailUser)
                                                            .updateData({
                                                          "nbAjoutPanier": ajoutPanier
                                                        });
                                                        setState(() {
                                                          total = total - panier.prix;
                                                          prixWithDot = priceWithDot(total);
                                                          produitsPaniers.removeAt(i);
                                                        });

                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                ],
              ),
              SizedBox(height: 100,),
            ],
          ),),
          floatingActionButton:
          (produitsPaniers!=null)?Center(
            child: Container(
              margin: EdgeInsets.only(
                  left: longueurPerCent(20, context),  top: MediaQuery
                  .of(context)
                  .size
                  .height - 60),
              child: button(
                  HexColor("#001C36"), HexColor("#FFC30D"), context, "ACHETER", () async {
                if(total==0){

                } else {
                  if(produitsIndisponibles.isNotEmpty){
                    confirmationPopup(context);
                  } else {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => Panier1(total: total,produitsPanier: produitsPaniers,)));
                  }
                }
              })
            ),
          ):Center(child: CircularProgressIndicator(),)
      );
    }
    else {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }
 }


  confirmationPopup(BuildContext dialogContext) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      descStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: "IMPORTANT?",
        desc: "Certains de vos produits ont été déjà commandés. Supprimer ces produits pour continuer l'achat.",

        buttons: [
          DialogButton(
            child: Text(
              "Continuer",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(context);
              /*Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => Panier1(total: total,produitsPanier: produitsPaniers,)));*/
            },
            color: HexColor("#001C36"),
          ),
        ]).show();
  }


  String priceWithDot(int price){
    int lengthPrice = price.toString().length;
    String priceWithDot=price.toString();
    if(lengthPrice==4){
      setState(() {
        priceWithDot = priceWithDot[0] + '.' + priceWithDot.substring(1, priceWithDot.length);
      });
      return priceWithDot;
    } else if(lengthPrice==5){
      setState(() {
        priceWithDot = priceWithDot.substring(0, 2) + '.' + priceWithDot.substring(2, 5) ;
      });
      return priceWithDot;
    }else if(lengthPrice==6){
      setState(() {
        priceWithDot = priceWithDot.substring(0, 3) + '.' + priceWithDot.substring(3, 6) ;
      });
      return priceWithDot;
    } else if(lengthPrice==7){
      setState(() {
        priceWithDot = priceWithDot.substring(0, 1) + '.' + priceWithDot.substring(1, 4) + '.' + priceWithDot.substring(4, 7) ;
      });
      return priceWithDot;
    } else
      return priceWithDot;
  }

}