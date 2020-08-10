import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';



/***************************************************************************************************/

/// Cette fonction permet d'ajouter un produit dans ProduitsFavorisUser(collection composant le produit personnel
///de l'utilisateur pour la selection des images et l'ajout des favoris, cette collection est utilisée pour enregister les
///produits sur lesquels ils cliquent ce qui aide permet d'ajouter dans la table le produit avec les informations

 void idProduitsFavorisUser(Produit produit, BuildContext context) async{
  if (Renseignements.emailUser != null) {
    try {
      Firestore.instance.collection("Utilisateurs").document(Renseignements.emailUser).collection("ProduitsFavoirsUser")
          .where("imagePrincipaleProduit", isEqualTo: produit.image1)
          .getDocuments().then((QuerySnapshot snapshot) async {
        if(snapshot.documents.isEmpty){
          await  FirestoreService().addProduitFavorisUser(ProduitsFavorisUser(
              imagePrincipaleProduit: produit.image1,
              imageSelect: produit.image1,
              etatIconeFavoris: false,
              etatSurMesure: false
          ), Renseignements.emailUser);
          print("L'ajout a été fait avant le onap");
        }
      });
    } catch (e){
      print(e);
    }
  }
}

////////////////////////////////////////////////////////////////////Fin de la fonction //////////////////////////////////////////////////////////

// ignore: non_constant_identifier_names
Widget product_grid_view(){
  return  StreamBuilder(
      stream: FirestoreService().getProduitFemmes(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Produit>> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return StaggeredGridView.countBuilder(
            reverse: false,
            crossAxisCount: 4,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, index) {
              Produit produit = snapshot.data[index];
              ///idProduitsFavorisUser(produit, context);
              return Container(
                width: largeurPerCent(200, context),
                margin: EdgeInsets.only(
                    left: largeurPerCent(10, context),
                    right: largeurPerCent(10, context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    idProduitsFavorisUser(produit, context);
                    print(produit.nomDuProduit);
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ArticleSansTaille(produit, Renseignements.emailUser)));*/
                  },
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: longueurPerCent(150, context),
                          width: largeurPerCent(200, context),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.network(
                                produit.image1,
                                loadingBuilder: (context,child, progress){
                                  return progress == null?child:LinearProgressIndicator(backgroundColor:HexColor("EFD807"), );
                                },
                                fit: BoxFit.cover,
                              )),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                            largeurPerCent(200, context),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                  largeurPerCent(10, context),
                                  top: longueurPerCent(
                                      10, context)),
                              child: Text(
                               "${ produit.prix} FCFA",
                                style: TextStyle(
                                    color: HexColor("#001C36"),
                                    fontSize: 15,
                                    fontFamily: "MonseraBold"),
                              )),
                        ),
                        SizedBox(
                          height: longueurPerCent(5, context),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                            largeurPerCent(200, context),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.only(left: largeurPerCent(10, context)),
                            child: Text(
                              produit.nomDuProduit,
                              style: TextStyle(
                                  color: HexColor("#909090"),
                                  fontSize: 15,
                                  fontFamily: "MonseraRegular"),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: longueurPerCent(10, context),left: largeurPerCent(4, context)),
                            child:  RatingBar(
                              initialRating:  produit.numberStar.ceilToDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 3,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              ignoreGestures: true,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 10,
                              ),
                              itemSize: 20,
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                        ),
                        SizedBox(height: longueurPerCent(10, context),),
                        new Container()
                      ],
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (_) => StaggeredTile.fit(2),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          );
        }
      }) ;

}