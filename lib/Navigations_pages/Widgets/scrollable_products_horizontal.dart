import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:premierchoixapp/Models/reduction.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/article.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';


/***************************************************************************************************/

/// Cette fonction permet d'ajouter un produit dans ProduitsFavorisUser(collection composant le produit personnel
///de l'utilisateur pour la selection des images et l'ajout des favoris, cette collection est utilisée pour enregister les
///produits sur lesquels ils cliquent ce qui aide permet d'ajouter dans la table le produit avec les informations
void idProduitsFavorisUser(Produit produit, BuildContext context) async {
  if (Renseignements.emailUser != null) {
    try {
      Firestore.instance
          .collection("Utilisateurs")
          .document(Renseignements.emailUser)
          .collection("ProduitsFavoirsUser")
          .where("imagePrincipaleProduit", isEqualTo: produit.image1)
          .getDocuments()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.documents.isEmpty) {
          await FirestoreService().addProduitFavorisUser(
              ProduitsFavorisUser(
                  imagePrincipaleProduit: produit.image1,
                  imageSelect: produit.image1,
                  etatIconeFavoris: false,
                  etatSurMesure: false),
              Renseignements.emailUser);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

DateTime expiryBadgeNew;


////////////////////////////////////////////////////////////////////Fin de la fonction //////////////////////////////////////////////////////////
/*Fin de la fonction*/
// ignore: non_constant_identifier_names
Widget scrollabe_products_horizontal( Stream<List<Produit>> askDb){

  return StreamBuilder(
      stream: askDb,
      builder: (BuildContext context,
          AsyncSnapshot<List<Produit>> snapshot) {
        if (snapshot.hasError || !snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (snapshot.data.isEmpty) {
          return elementsVides(context, Icons.do_not_disturb,
              "Pas de nouveaux produits ajoutés");
        }
        else {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                expiryBadgeNew = DateTime.parse(snapshot.data[i].expiryBadgeNew);
                bool displayBadgeNew = !expiryBadgeNew.isBefore(DateTime.now());
                Produit produit = snapshot.data[i];
                int prixProduit = snapshot.data[i].prix;
                return GestureDetector(
                  onTap: (){
                    idProduitsFavorisUser(snapshot.data[i], context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ArticleSansTaille(snapshot.data[i], Renseignements.emailUser)));
                  },
                  child: Container(
                    height: double.infinity,
                    width: largeurPerCent(190, context),
                    margin: EdgeInsets.only(
                        left: largeurPerCent(10, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Card(
                      elevation: 5.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height:
                            longueurPerCent(110, context),
                            width: largeurPerCent(210, context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                  Radius.circular(10),
                                  topRight:
                                  Radius.circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data[i].image1,
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
                          ),
                          (displayBadgeNew)? Container(
                            height: longueurPerCent(10, context),
                            color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.only(left: longueurPerCent(10, context),right: longueurPerCent(10, context),),
                              child: Text(
                                "NOUVEAU",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: HexColor("#FFFFFF"),
                                    fontSize: 9.0,
                                    fontFamily: "MontserratBold",
                                    fontWeight: FontWeight.bold

                                ),
                              ),
                            ),
                          ):Container(),
                          StreamBuilder(stream: FirestoreService().getReductionCollection(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ReductionModel>> snapshotReduction) {
                              if(snapshotReduction.hasError || !snapshotReduction.hasData)
                                return Text("");
                              else {
                                bool appyReduce =false;
                                int pourcentageReduce = 0;
                                for(int i =0; i<snapshotReduction.data.length; i++){
                                  if(produit.sousCategorie == snapshotReduction.data[i].nomCategorie && !DateTime.parse(snapshotReduction.data[i].expiryDate).isBefore(DateTime.now()) && snapshotReduction.data[i].genre == produit.categorie && snapshotReduction.data[i].numberStar == produit.numberStar){
                                    appyReduce = true;
                                    pourcentageReduce = snapshotReduction.data[i].pourcentageReduction;
                                    produit.prix = prixReduit(prixProduit, pourcentageReduce);
                                  }
                                }

                                return Column(
                                  children: [
                                    (appyReduce)? Padding(
                                      padding: EdgeInsets.only(
                                          left: largeurPerCent(
                                              10, context),
                                          top: longueurPerCent(
                                              10, context)),
                                      child: Column(
                                        children: [
                                          PriceWithDot(price:prixProduit, couleur: Colors.red, size:14,police: "MonseraBold", decoration: TextDecoration.lineThrough),
                                          PriceWithDot(price:  prixReduit(prixProduit, pourcentageReduce), couleur: HexColor("#00CC7b"), size:14,police: "MonseraBold")
                                        ],
                                      ),
                                    ): Padding(
                                      padding: EdgeInsets.only(
                                          left: largeurPerCent(
                                              10, context),
                                          top: longueurPerCent(
                                              10, context)),
                                      child: Column(
                                        children: [
                                          PriceWithDot(price:prixProduit, couleur: HexColor("#00CC7b"), size:14,police: "MonseraBold")
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                            },
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth:
                              largeurPerCent(200, context),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: largeurPerCent(
                                      10, context),
                                  top: longueurPerCent(
                                      5, context)
                              ),
                              child: AutoSizeText(
                                snapshot.data[i].nomDuProduit,
                                minFontSize: 12,
                                maxLines: 2,
                                style: TextStyle(
                                    color: HexColor("#909090"),
                                    fontSize: 15,
                                    fontFamily:
                                    "MonseraRegular"),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top:
                                  longueurPerCent(5, context),
                                  left: largeurPerCent(4, context)
                              ),
                              child: RatingBar.builder(
                                initialRating: snapshot.data[i].numberStar.ceilToDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 3,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 10,
                                ),
                                itemSize: 20,
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      });
}

int prixReduit(int prix, int pourcentageReduction){
  int resultat = ((1-pourcentageReduction/100)*prix).toInt();
  return resultat;
}