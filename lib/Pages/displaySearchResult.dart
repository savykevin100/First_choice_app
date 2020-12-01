import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:premierchoixapp/Models/reduction.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/article.dart';
import 'package:random_color/random_color.dart';

// ignore: must_be_immutable
class DisplaySearchResult extends StatefulWidget {
  List<Map<String, dynamic>> data = [];
  static String id="DisplaySearchResult";

  DisplaySearchResult({this.data});
  @override
  _DisplaySearchResultState createState() => _DisplaySearchResultState();
}

class _DisplaySearchResultState extends State<DisplaySearchResult> {

  final controller = ScrollController();

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
  RandomColor _randomColor = RandomColor();

  int prixReduit(int prix, int pourcentageReduction){
    int resultat = ((1-pourcentageReduction/100)*prix).toInt();
    return resultat;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
      titre: "Filtres resultats",
      context: context,
      controller: controller,
    );
    return Scaffold(
        appBar: _appBar.appBarFunctionStream(),
        body: SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
            reverse: false,
            crossAxisCount: 4,
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, index) {
              int prixProduit = widget.data[index]["prix"];
              return Container(
                width: largeurPerCent(200, context),
                margin: EdgeInsets.only(
                    top: longueurPerCent(20, context),
                    left: largeurPerCent(10, context),
                    right: largeurPerCent(10, context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(

                  onTap: () {
                    idProduitsFavorisUser(Produit(
                        id: widget.data[index]["id"],
                        nomDuProduit: widget.data[index]["nomDuProduit"],
                        description: widget.data[index]["description"],
                        image1: widget.data[index]["image1"],
                        image2: widget.data[index]["image2"],
                        image3: widget.data[index]["image3"],
                        selectImage: widget.data[index]["selectImage"],
                        prix: widget.data[index]["prix"],
                        numberImages: widget.data[index]["numberImages"],
                        numberStar: widget.data[index]["numberStar"],
                        taille: widget.data[index]["taille"],
                        categorie: widget.data[index]["catagorie"],
                        sousCategorie: widget.data[index]["sousCategorie"],
                        expiryBadgeNew: widget.data[index]["expiryBadgeNew"],
                        idProduitCategorie: widget.data[index]
                        ["idProduitCategorie"]), context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ArticleSansTaille(Produit(
                                    id: widget.data[index]["id"],
                                    nomDuProduit: widget.data[index]["nomDuProduit"],
                                    description: widget.data[index]["description"],
                                    image1: widget.data[index]["image1"],
                                    image2: widget.data[index]["image2"],
                                    image3: widget.data[index]["image3"],
                                    selectImage: widget.data[index]["selectImage"],
                                    prix: widget.data[index]["prix"],
                                    numberImages: widget.data[index]["numberImages"],
                                    numberStar: widget.data[index]["numberStar"],
                                    taille: widget.data[index]["taille"],
                                    categorie: widget.data[index]["catagorie"],
                                    sousCategorie: widget.data[index]["sousCategorie"],
                                    expiryBadgeNew: widget.data[index]["expiryBadgeNew"],
                                    idProduitCategorie: widget.data[index]
                                    ["idProduitCategorie"]), Renseignements.emailUser)));
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
                            child: CachedNetworkImage(
                              imageUrl: widget.data[index]["image1"],
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(color:_randomColor.randomColor(), height: longueurPerCent(150, context), width: largeurPerCent(210, context),),
                            ),
                          ),
                        ),
                        SizedBox(width: largeurPerCent(10, context),),
                        StreamBuilder(
                          stream: FirestoreService()
                              .getReductionCollection(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ReductionModel>>
                              snapshotReduction) {
                            if (snapshotReduction.hasError ||
                                !snapshotReduction.hasData)
                              return Text("");
                            else {
                              bool appyReduce = false;
                              int pourcentageReduce = 0;
                              for (int i = 0;
                              i < snapshotReduction.data.length;
                              i++) {
                                if (widget.data[index]["sousCategorie"] ==
                                    snapshotReduction
                                        .data[i].nomCategorie &&
                                    !DateTime.parse(snapshotReduction
                                        .data[i].expiryDate)
                                        .isBefore(DateTime.now()) &&
                                    snapshotReduction.data[i].genre ==
                                        widget.data[index]["categorie"] &&
                                    snapshotReduction
                                        .data[i].numberStar ==
                                        widget.data[index]["numberStar"]) {
                                  appyReduce = true;
                                  pourcentageReduce = snapshotReduction
                                      .data[i].pourcentageReduction;
                                  widget.data[index]["prix"] = prixReduit(
                                      prixProduit, pourcentageReduce);
                                }
                              }

                              return Column(
                                children: [
                                  (appyReduce)
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: largeurPerCent(
                                            10, context),
                                        top: longueurPerCent(
                                            10, context)),
                                    child: Column(
                                      children: [
                                        PriceWithDot(
                                            price: prixProduit,
                                            couleur: Colors.red,
                                            size: 14,
                                            police: "MonseraBold",
                                            decoration:
                                            TextDecoration
                                                .lineThrough),
                                        PriceWithDot(
                                            price: prixReduit(
                                                prixProduit,
                                                pourcentageReduce),
                                            couleur: HexColor(
                                                "#00CC7b"),
                                            size: 14,
                                            police: "MonseraBold")
                                      ],
                                    ),
                                  )
                                      : Padding(
                                    padding: EdgeInsets.only(
                                        left: largeurPerCent(
                                            10, context),
                                        top: longueurPerCent(
                                            10, context)),
                                    child: Column(
                                      children: [
                                        PriceWithDot(
                                            price: prixProduit,
                                            couleur: HexColor(
                                                "#00CC7b"),
                                            size: 14,
                                            police: "MonseraBold")
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                          },
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
                            child: AutoSizeText(
                              widget.data[index]["nomDuProduit"],
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
                                top: longueurPerCent(10, context),
                                left: largeurPerCent(4, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  initialRating: widget.data[index]["numberStar"]
                                      .ceilToDouble(),
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
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    widget.data[index]["categorie"]=="Hommes"?"H":"F",
                                    style:TextStyle(
                                        color:    widget.data[index]["categorie"] == "Hommes"?HexColor("#FFC30D"):Colors.pink,
                                        fontSize: 15,
                                        fontFamily: "MonseraBold"),
                                  ),
                                )
                              ],
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
          ),
        )
    );
  }
}