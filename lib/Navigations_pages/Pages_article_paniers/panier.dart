import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Composants/databaseClient.dart';
import 'package:premierchoixapp/Design/CustomDialog.dart';
import 'package:premierchoixapp/Models/panier_classe_sqflite.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier1.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';

import '../../checkConnexion.dart';


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
  int chargementProduitsIndisponible=0;
  int numberProductOrder=0;
  String prixWithDot="0";


  // Table qui contient les éléments du panier
  List<PanierClasseSqflite> panierItems = [];

  int ajoutPanier=0;

  void getDataPanier(){
    DatabaseClient().readPanierData().then((value) {
      setState(() {
        panierItems=value;
      });
    });
  }


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




  void fetchDataInPanierAndVerificationIndiponibleProduct(){
    DatabaseClient().readPanierData().then((value) {
      value.forEach((element) {
        setState(() {
          numberProductOrder++;
          total = total + element.prix;
          prixWithDot = priceWithDot(total);
          produitsPaniers.add({
            "nomDuProduit": element.nomDuProduit,
            "prix":element.prix,
            "description": element.description,
            "sousCategorie": element.sousCategorie,
            "image1": element.image1,
            "taille": element.taille,
            "reference": element.reference,
            "numberStar": element.numberStar,
            "categorie": element.categorie,
            "idProduitCategorie": element.idProduitCategorie,
            "dejaCommander": false
          });
          panierItems=value;
        });
      });
    });

    _db.collection("ProduitsIndisponibles").getDocuments().then((value) {
      value.documents.forEach((produitIndisponible) {
        for(int i=0; i<produitsPaniers.length; i++){
          if(produitsPaniers[i]["image1"]==produitIndisponible.data["image1"]){
            if(this.mounted)
              setState(() {
                produitsIndisponibles.add(produitIndisponible.data);
                produitsPaniers[i]["dejaCommander"] = true;
              });
          } else
          if(this.mounted)
            setState(() {
              chargementProduitsIndisponible++;
            });
        }

      });
    });
  }



  ////////////////////////////////////////////////////////////////////////////////////////////////////


  @override
  void initState() {
    super.initState();
    fetchDataInPanierAndVerificationIndiponibleProduct();
    getDataPanier();
    getNombreProduitPanier();
  }

  @override
  Widget build(BuildContext context) {
    if (total != null && produitsPaniers!=null && (chargementProduitsIndisponible==produitsPaniers.length || produitsIndisponibles!=null) && ajoutPanier!=null) {
      return Scaffold(
          backgroundColor: HexColor("#F5F5F5"),
          appBar: AppBar(
              backgroundColor: HexColor("#001c36"),
              title: Text(
                " TOTAL" +  "  ($numberProductOrder)   :  " +   " $prixWithDot FCFA" ,textAlign: TextAlign.start, style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "MonseraBold"),)
          ),
          body:  (produitsPaniers.length==0)?elementsVides(context, Icons.shopping_cart,
              "Pas de nouveaux produits ajoutés"):Test(displayContains:  ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: produitsPaniers.length,
              itemBuilder: (BuildContext context, int index){
                return  Column(
                  children: <Widget>[
                    Container(
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
                              child: CachedNetworkImage(
                                imageUrl: produitsPaniers[index]["image1"],
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => LinearProgressIndicator(backgroundColor:HexColor("EFD807"),
                                ),
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
                                      SizedBox(height: longueurPerCent(10, context),),
                                      Text(
                                        "${produitsPaniers[index]["nomDuProduit"]} ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: HexColor(
                                                "#909090"),
                                            fontSize: 15,
                                            ),
                                      ),
                                      SizedBox(
                                        height: longueurPerCent(
                                            4.0, context),
                                      ),
                                      Text(
                                        "${produitsPaniers[index]["taille"]}",
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
                                            4.0, context),
                                      ),
                                      PriceWithDot(price: produitsPaniers[index]["prix"], couleur: HexColor("#00CC7b",),size: 15, police: "MontseraBold",),

                                    ],
                                  )
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: longueurPerCent(10, context),),
                                    (produitsPaniers[index]["dejaCommander"] == true)?Text("Déjà commandé", style: TextStyle(color: Colors.red),):Text(""),
                                    Container(
                                      margin: EdgeInsets.only(left: longueurPerCent(50, context)),
                                      child: IconButton(icon: Icon(
                                          Icons.delete, color: Colors.red, size: 20),
                                          onPressed: () {

                                            setState(() {
                                              ajoutPanier--;
                                            });

                                            DatabaseClient().deleteItemPanier(panierItems[index].id , "panier").then((value) {
                                              getDataPanier();
                                            });
                                            //  FirestoreService().deletePanier(Renseignements.emailUser, panier.id);
                                            for(int i=0; i<produitsIndisponibles.length; i++){
                                              if(produitsIndisponibles[i]["image1"]==produitsPaniers[index]["image1"])
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
                                              Renseignements.nombreAjoutPanier--;
                                              total = total - produitsPaniers[index]["prix"];
                                              prixWithDot = priceWithDot(total);
                                              numberProductOrder--;
                                              produitsPaniers.removeAt(index);
                                            });
                                            //ajouterNumberPanier(Renseignements.nombreAjoutPanier);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    (produitsPaniers.length-1==index)?SizedBox(height: longueurPerCent(100, context),):Text("")
                  ],
                );
              }),),
          floatingActionButton:
          (produitsPaniers!=null)?FloatingButton(displayContains: Center(
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
          ),):Center(child: CircularProgressIndicator(),)
      );
    }
    else {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }
  }



  confirmationPopup(BuildContext dialogContext) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Important",
        description:
        "Certains de vos produits ont été déjà commandés. Supprimer ces produits pour continuer l'achat.",
        cancelButton: FlatButton(
          onPressed: (
              ) {
            Navigator.of(context).pop(); // To close the dialog
          },
          child: Text("ANNULER",
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 12.0,
                fontFamily: "MonseraBold"
            ),
          ),
        ),
        nextButton: FlatButton(
          onPressed: (
              ) {
            Navigator.of(context).pop(); // To close the dialog
          },
          child: Text("CONTINUER",
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 12.0,
                fontFamily: "MonseraBold"
            ),),
        ),
        icon: Icon(Icons.add,size: 100,color: HexColor("#001C36")),
      ),
    );
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