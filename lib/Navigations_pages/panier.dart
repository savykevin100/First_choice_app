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
      print(produitsPaniers);
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
                            left: largeurPerCent(30, context)),
                        child: Text(
                          " TOTAL :    ${total} FCFA",textAlign: TextAlign.center, style: TextStyle(
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
                                                        15.0, context),
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
                                              )
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(height: longueurPerCent(18, context),),
                                                Container(
                                                  margin: EdgeInsets.only(left: longueurPerCent(20, context)),
                                                  child: IconButton(icon: Icon(
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
                                                      }),
                                                ),
                                                SizedBox(height: longueurPerCent(5, context),),
                                                (panier.etatSurMesure==false)?Text(""): Container(
                                                  height: longueurPerCent(20, context),
                                                  width: largeurPerCent(100, context),
                                                  margin: EdgeInsets.only(left: longueurPerCent(20, context)),
                                                  color: HexColor("#001C36"),
                                                  child: Center(
                                                    child: Text(
                                                      "SUR MESURE",
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                          color: HexColor("#FFFFFF"),
                                                          fontSize: 9.0,
                                                          fontFamily: "MontserratBold",
                                                          fontWeight: FontWeight.bold

                                                      ),
                                                    ),
                                                  ),
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
          ),
          floatingActionButton:Center(
            child: Container(
              margin: EdgeInsets.only(
                  left: longueurPerCent(20, context), top: MediaQuery
                  .of(context)
                  .size
                  .height - 60),
              child: button(
                  HexColor("#001C36"), HexColor("#FFC30D"), context, "ACHETER", () {
               if(total==0){

               } else {
                 ///_showDialog();
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



  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmez-vos mensurations?"),
          content: new Text("Vous n'avez pas encore entré vous mensurations, veuillez-allez au niveau de votre "
              "profil pour entrer vos mensurations"
              ""),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}