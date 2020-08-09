import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';

import 'Pages_article_paniers/article.dart';

class Favoris extends StatefulWidget {
  @override
  _FavorisState createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {
  final controller = ScrollController();
  int ajoutPanier;
  Firestore  _db = Firestore.instance;
  List<String> idProduitsFavoris=[];
  List<String> identifiantDocumentsFavorisUser=[];
  List<String> etatFavoris=[];

  /// Cette fonction permet d'avoir l'identifiant du produit dans les favoris pour pouvoir faciliter le suppression de ce produit
  /// des favoris
  Future<void> getIdFavoris() async{
    await  _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .collection("Favoris")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
         for(int i=0; i<snapshot.documents.length; i++){
          if(this.mounted){
            setState(() {
              idProduitsFavoris.add(snapshot.documents[i].documentID);
            });
          }
         }
    });
  }
  //////////////////////////////////////////////////////////////////////////////////////////

  /// Cette fonction permet de recuperer l'id du produit dans la collection ProduitsFavorisUser en vue de changer l'etat de etatIconFavoris
  /// en false pour que le coeur ne soit plus colorié au niveau de la page article
  void getIdProduitFavorisUser() {
    _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .collection("ProduitsFavoirsUser")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (int i = 0; i < snapshot.documents.length; i++) {
     if(this.mounted){
       setState(() {
         etatFavoris.add(snapshot.documents[i].data["imagePrincipaleProduit"]);
         identifiantDocumentsFavorisUser.add(snapshot.documents[i].documentID);
       });
     }
      }
    });
  }
  /////////////////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdProduitFavorisUser();
    getIdFavoris();
  }
  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Favoris",
        context: context,
        controller: controller,
        nbAjoutPanier: ajoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      drawer: ProfileSettings(userCurrent: Renseignements.emailUser),
      body:(identifiantDocumentsFavorisUser!=null && idProduitsFavoris!=null && etatFavoris!=null)? StreamBuilder(
          stream: FirestoreService().getFavoris(Renseignements.emailUser),
          builder: (BuildContext context,
              AsyncSnapshot<List<Produit>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if(snapshot.data.isEmpty){
              return elementsVides(context, Icons.favorite, "AUCUN PRODUIT DANS LES FAVORIS");
            }
            else {
              return StaggeredGridView.countBuilder(
                reverse: false,
                crossAxisCount: 4,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, index) {
                  Produit produit = snapshot.data[index];

                  return Container(
                    width: largeurPerCent(150, context),
                    margin: EdgeInsets.only(
                        left: largeurPerCent(0, context), top: longueurPerCent(20, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () {
                        print(produit.nomDuProduit);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ArticleSansTaille({
                                      "nomDuProduit": produit.nomDuProduit,
                                      "prix": produit.prix,
                                      "description": produit.description,
                                      "image1":produit.image1,
                                      "image2":produit.image2,
                                      "image3":produit.image3,
                                      "selectImage":produit.selectImage,
                                      "numberImages":produit.numberImages,
                                      "numberStar":produit.numberStar,
                                      "surMesure":produit.surMesure,
                                      "taille":produit.taille
                                    }, Renseignements.emailUser)));
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
                                          5, context)),
                                  child: Text(
                                    "${ produit.prix} FCFA",
                                    style: TextStyle(
                                        color: HexColor("#00CC7b"),
                                        fontSize: 16.5,
                                        fontFamily: "MonseraBold"),
                                  )),
                            ),
                            SizedBox(
                              height: longueurPerCent(10, context),
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
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: longueurPerCent(10, context),left: largeurPerCent(5, context)),
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
                                  ),
                                ),
                                SizedBox(width: largeurPerCent(30, context),),
                                Padding(
                                  padding: EdgeInsets.only(left: longueurPerCent(20, context)),
                                    child:IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){
                                      for(int i=0; i<etatFavoris.length; i++){
                                        if(produit.image1==etatFavoris[i]) {
                                          _db
                                              .collection("Utilisateurs")
                                              .document(Renseignements.emailUser).collection("ProduitsFavoirsUser")
                                              .document(identifiantDocumentsFavorisUser[i])
                                              .updateData({"etatIconeFavoris":false});
                                          setState(() {
                                            identifiantDocumentsFavorisUser.removeAt(i);
                                            etatFavoris.removeAt(i);
                                          });
                                          print("Ça marche");
                                          FirestoreService().deleteFavoris(Renseignements.emailUser, idProduitsFavoris[index]);
                                          setState(() {
                                            idProduitsFavoris.removeAt(index);
                                          });
                                        }

                                      }
                                    })
                                ),
                              ],
                            ),
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
          }):Center(child: CircularProgressIndicator(),)
    );
  }
}
