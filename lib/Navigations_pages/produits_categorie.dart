import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'Pages_article_paniers/article.dart';
import 'Widgets/products_gried_view.dart';


// ignore: must_be_immutable
class ProduitsCategorie extends StatefulWidget {
  String titreCategorie;
  String genre;

  ProduitsCategorie(this.titreCategorie, this.genre);

  @override
  _ProduitsCategorieState createState() => _ProduitsCategorieState();
}

class _ProduitsCategorieState extends State<ProduitsCategorie> {

  int ajoutPanier;
  ScrollController controller = ScrollController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: widget.titreCategorie,
        controller: controller,
        context: context,
        nbAjoutPanier: ajoutPanier);
    return
    Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      body: ListView(
        controller: controller,
        children: <Widget>[
          SizedBox(height: longueurPerCent(30, context),),
          StreamBuilder(
              stream: FirestoreService().getSousCategoriesProducts(widget.genre, widget.titreCategorie),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticleSansTaille(
                                        produit,
                                        Renseignements.emailUser)));
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
                                        loadingBuilder:
                                            (context, child, progress) {
                                          return progress == null
                                              ? child
                                              : LinearProgressIndicator(
                                            backgroundColor:
                                            HexColor("EFD807"),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: largeurPerCent(200, context),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: largeurPerCent(10, context),
                                          top:
                                          longueurPerCent(10, context)),
                                      child: Text(
                                        "${produit.prix} FCFA",
                                        style: TextStyle(
                                            color: HexColor("#00CC7b"),
                                            fontSize: 16.5,
                                            fontFamily: "MonseraBold"),
                                      )),
                                ),
                                SizedBox(
                                  height: longueurPerCent(5, context),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: largeurPerCent(200, context),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: largeurPerCent(10, context)),
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
                                        top: longueurPerCent(10, context),
                                        left: largeurPerCent(4, context)),
                                    child: RatingBar(
                                      initialRating:
                                      produit.numberStar.ceilToDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 3,
                                      itemPadding: EdgeInsets.symmetric(
                                          horizontal: 4.0),
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
                                    )),
                                SizedBox(
                                  height: longueurPerCent(10, context),
                                ),
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
              }),
        ],
      ),
    );
  }
}
