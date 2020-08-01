import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/Panier1.dart';
import 'package:premierchoixapp/Models/panier_classe.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';

class Panier extends StatefulWidget {
  static String id = 'Panier';

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  bool value;
  Firestore _db = Firestore.instance;
  int quantiteProduitDisponible;
  var idDocument;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int total = 0;
  List<String> idProduitsPanier = [];
  List<Map<String, dynamic>> produitsPaniers=[];
  int ajoutPanier;

  /// Cette fonction getIdProduit permet de recuperer l'id du produit en vue de pouvoir le supprimer. Donc je récupère tous les ID
  /// dans la variable idProduitsPanier et au moment de la suppression je supprimer le produit qui est à l'index i
  Future<void> getIdProduit() async {
    await _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .collection("Panier")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (int i = 0; i < snapshot.documents.length; i++) {
        if (this.mounted) {
          setState(() {
            idProduitsPanier.add(snapshot.documents[i].documentID);
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
            total = total + value.documents[i].data["prix"];
          });
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////


  @override
  void initState() {
    super.initState();
    getIdProduit();
    getNombreProduitPanier();
    sumPrice();
  }

  @override
  Widget build(BuildContext context) {
    if (idProduitsPanier != null && total != null && produitsPaniers!=null) {
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
                      return Padding(
                        padding: EdgeInsets.only(
                            left: largeurPerCent(50, context)),
                        child: Text(
                          " TOTAL :    ${total} FCFA", style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "MonseraBold"),),
                      );
                    }
                  }
              )
          ),
          body: ListView(
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
                              "AUCUN PRODUIT DANS LE PANIER");
                        }
                        else {
                          /* */
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                PanierClasse panier = snapshot.data[i];
                                return Container(
                                  margin: EdgeInsets.only(
                                    top: longueurPerCent(10, context),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          height: longueurPerCent(
                                              100.0, context),
                                          width: largeurPerCent(100.0, context),
                                          child: Image.network(
                                            panier.image1,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: largeurPerCent(
                                                  50, context)),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: 150
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "${panier.nomDuProduit} ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: HexColor(
                                                          "#909090"),
                                                      fontSize: 18,
                                                      fontFamily: "Regular"),
                                                ),
                                                SizedBox(
                                                  height: longueurPerCent(
                                                      4.0, context),
                                                ),
                                                Text(
                                                  "Rouge - 43",
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
                                                Text(
                                                  '${panier.prix} FCFA',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: HexColor("#001C36"),
                                                    fontSize: 16,
                                                    fontFamily: "MontserratBold",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      IconButton(icon: Icon(
                                        Icons.delete, color: Colors.red,),
                                          onPressed: () {
                                            FirestoreService().deletePanier(
                                                Renseignements.emailUser,
                                                idProduitsPanier[i]);
                                            setState(() {
                                              total = total - panier.prix;
                                              idProduitsPanier.removeAt(i);
                                              produitsPaniers.removeAt(i);
                                            });
                                            _db
                                                .collection("Utilisateurs")
                                                .document(
                                                Renseignements.emailUser)
                                                .updateData({
                                              "nbAjoutPanier": ajoutPanier--
                                            });
                                          })
                                    ],
                                  ),
                                );
                              });
                        }
                      }),
                ],
              ),
              SizedBox(height: 100,),
            ],
          ),
          floatingActionButton:Center(
            child: Container(
              margin: EdgeInsets.only(
                  left: longueurPerCent(20, context), top: MediaQuery
                  .of(context)
                  .size
                  .height - 60),
              child: button(
                  Colors.white, HexColor("#001C36"), context, "ACHETER", () {
               if(total==0){

               } else {
                 Navigator.push(
                     context, MaterialPageRoute(
                     builder: (context) => Panier1(total: total,produitsPanier: produitsPaniers,)));
               }
              }),
            ),
          )
      );
    } else if (idProduitsPanier == [] && total == 0) {
      return Scaffold(
        body: elementsVides(
            context, Icons.shopping_cart, "AUCUN PRODUIT DANS LE PANIER"),
      );
    }
    else {
      return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }
  }


}