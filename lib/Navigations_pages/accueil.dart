import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Drawer/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:premierchoixapp/Models/reduction.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/panier.dart';
import 'package:premierchoixapp/Navigations_pages/produitsRecommandes.dart';
import 'package:premierchoixapp/Navigations_pages/tousLesProduits.dart';
import 'package:premierchoixapp/Pages/elements_vides.dart';
import 'package:premierchoixapp/Pages/search_filtre.dart';
import 'package:random_color/random_color.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../checkConnexion.dart';
import 'Pages_article_paniers/article.dart';

class Accueil extends StatefulWidget {
  static String id = "Accueil";

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  List<String> imagesCarousel = [];
  int nombreAjoutPanier = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int nbrPasHorizontal=10;
  int resteHorizontal=0;
  int nbreDisplayHorizontal=0;

  int nbrPasVertical=15;
  int resteVertical=0;
  int nbreDisplayVertical=0;



  List<Map<String, dynamic>> produitsRecommandes=[];
  List<Map<String, dynamic>> toutLesProduits=[];



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

  RandomColor _randomColor = RandomColor();

  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  Future<void> getImagesCarousel() async {
    Firestore.instance
        .collection("Informations_générales")
        .document("78k1bDeNwVHCzMy8hMGh")
        .get()
        .then((value) {
      if (this.mounted)
        setState(() {
          imagesCarousel.add(value.data["image1"]);
          imagesCarousel.add(value.data["image2"]);
          imagesCarousel.add(value.data["image3"]);
        });
    });
  }

  void registerUserPreference() {
    getUser().then((value) {
      if (value != null)
        try {
          Firestore.instance
              .collection("Utilisateurs")
              .document(value.email)
              .get()
              .then((value) {
            if (this.mounted)
              ajouter([
                value.data["numero"],
                value.data["email"],
                value.data["nomComplet"],
                value.data["age"],
                value.data["sexe"],
              ]);
            Renseignements.emailUser = value.data["email"];
          });
        } catch (e) {
          print(e.toString());
        }
    });
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /* Firestore.instance.collection("ProduitsRecommandes").getDocuments().then((value) {
      value.documents.forEach((element) {
        setState(() {
          produitsRecommandes.add(element.data);
        });
      });
    });
    Firestore.instance.collection("TousLesProduits").getDocuments().then((value) {
      value.documents.forEach((element) {
        setState(() {
          toutLesProduits.add(element.data);
        });
      });
    });*/
    getImagesCarousel();
    registerUserPreference();
  }

  @override
  Widget build(BuildContext context) {
    if ((imagesCarousel.length == 3 && Renseignements.userData.length == 5)) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("#F5F5F5"),
        appBar: ScrollAppBar(
          controller: controller,
          backgroundColor: HexColor("#001c36"),
          title: Image.asset(
            "assets/images/1er choix-02.png",
            height: 100,
            width: 100,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchFiltre()));
                }),
            Badge(
              badgeContent: StreamBuilder(
                  stream: FirestoreService().getUtilisateurs(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Utilisateur>> snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Text("");
                    } else {
                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (snapshot.data[i].email ==
                            Renseignements.emailUser) {
                          nombreAjoutPanier = snapshot.data[i].nbAjoutPanier;
                        }
                      }
                      return Text("$nombreAjoutPanier");
                    }
                  }),
              toAnimate: true,
              position: BadgePosition(top: 0, end: 0),
              child: IconButton(
                  icon: Icon(
                    Icons.local_grocery_store,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Panier()));
                  }),
            )
          ],
        ),
        drawer: (Renseignements.userData.length == 5)
            ? ProfileSettings(
                userCurrent: Renseignements.userData[1],
                firstLetter: Renseignements.userData[2][0])
            : ProfileSettings(
                userCurrent: "",
                firstLetter: "",
              ),
        body: WillPopScope(
            onWillPop: _onBackPressed,
            child: Test(
              displayContains: bodyAccueil(),
            )),
        /*floatingActionButton: FloatingButton(
        displayContains: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchFiltre ()));
            },
            child: Icon(
              Icons.search,
              color: HexColor("#001C36"),
              size: 30,
            ),
            backgroundColor: HexColor("#FFC30D")
        ),
      )*/
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              "assets/images/1er choix-02.png",
              height: 100,
              width: 100,
            ),
          ),
          drawer: Drawer(),
          body: Test(
            displayContains: Center(
                child: SpinKitFadingCircle(
              color: HexColor("#001c36"),
              size: 30,
            )),
          ));
    }
  }

  Snap bodyAccueil() {
    return Snap(
      controller: controller.appBar,
      child: ListView(controller: controller, children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: longueurPerCent(200, context),
          decoration: BoxDecoration(
            color: HexColor("#001C36"),
          ),
          child: Carousel(
            boxFit: BoxFit.cover,
            autoplay: true,
            autoplayDuration: Duration(seconds: 6),
            animationCurve: Curves.linearToEaseOut,
            animationDuration: Duration(seconds: 2),
            dotSize: 10.0,
            dotIncreasedColor: Colors.amber,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            indicatorBgPadding: 7.0,
            dotBgColor: Colors.red.withOpacity(0),
            images: [
              CachedNetworkImage(
                  imageUrl: imagesCarousel[0],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator()),
              CachedNetworkImage(
                  imageUrl: imagesCarousel[1],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator()),
              CachedNetworkImage(
                  imageUrl: imagesCarousel[2],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator()),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: longueurPerCent(30, context),
              left: largeurPerCent(13, context),
              right: largeurPerCent(13, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:EdgeInsets.only(top: 15),
                child: Text(
                  "Produits recommandés",
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 16,
                      fontFamily: "MonseraBold"),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: longueurPerCent(16, context),
        ),
        Container(
            height: longueurPerCent(220, context),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                StreamBuilder(
                    stream: FirestoreService().getProduitRecommandes(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Produit>> snapshot) {
                      if (snapshot.hasError || !snapshot.hasData)
                        return Center(
                          child: Center(
                              child: SpinKitFadingCircle(
                                color: HexColor("#001c36"),
                                size: 30,
                              )),
                        );
                      else if (snapshot.data.isEmpty) {
                        return Center();
                      } else {
                        Color _color = _randomColor.randomColor();
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: nbrPasHorizontal,
                            itemBuilder: (context, i) {
                              resteHorizontal= snapshot.data.length%10;
                              nbreDisplayHorizontal=snapshot.data.length~/10;
                              expiryBadgeNew =
                                  DateTime.parse(snapshot.data[i].expiryBadgeNew);
                              bool displayBadgeNew =
                              !expiryBadgeNew.isBefore(DateTime.now());
                              Produit produit = snapshot.data[i];
                              int prixProduit = snapshot.data[i].prix;
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      idProduitsFavorisUser(snapshot.data[i], context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ArticleSansTaille(
                                                  snapshot.data[i],
                                                  Renseignements.emailUser)));
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: 154,
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
                                              height: longueurPerCent(110, context),
                                              width: largeurPerCent(210, context),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot.data[i].image1,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                        color: _color,
                                                        height:
                                                        longueurPerCent(110, context),
                                                        width: largeurPerCent(210, context),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            (displayBadgeNew)
                                                ? Container(
                                              height:
                                              longueurPerCent(10, context),
                                              color: Colors.red,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: longueurPerCent(
                                                      10, context),
                                                  right: longueurPerCent(
                                                      10, context),
                                                ),
                                                child: Text(
                                                  "NOUVEAU",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: HexColor("#FFFFFF"),
                                                      fontSize: 9.0,
                                                      fontFamily:
                                                      "MontserratBold",
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            )
                                                : Container(),
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
                                                    if (produit.sousCategorie ==
                                                        snapshotReduction
                                                            .data[i].nomCategorie &&
                                                        !DateTime.parse(
                                                            snapshotReduction
                                                                .data[i].expiryDate)
                                                            .isBefore(DateTime.now()) &&
                                                        snapshotReduction
                                                            .data[i].genre ==
                                                            produit.categorie &&
                                                        snapshotReduction
                                                            .data[i].numberStar ==
                                                            produit.numberStar) {
                                                      appyReduce = true;
                                                      pourcentageReduce =
                                                          snapshotReduction.data[i]
                                                              .pourcentageReduction;
                                                      produit.prix = prixReduit(
                                                          prixProduit,
                                                          pourcentageReduce);
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
                                                                price:
                                                                prixProduit,
                                                                couleur:
                                                                Colors.red,
                                                                size: 14,
                                                                police:
                                                                "MonseraBold",
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
                                                                police:
                                                                "MonseraBold")
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
                                                                price:
                                                                prixProduit,
                                                                couleur: HexColor(
                                                                    "#00CC7b"),
                                                                size: 14,
                                                                police:
                                                                "MonseraBold")
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
                                                maxWidth: largeurPerCent(200, context),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: largeurPerCent(10, context),
                                                    top: longueurPerCent(5, context)),
                                                child: AutoSizeText(
                                                  snapshot.data[i].nomDuProduit,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: HexColor("#909090"),
                                                      fontSize: 15,
                                                      fontFamily: "MonseraRegular"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: longueurPerCent(5, context),
                                                    left: largeurPerCent(4, context)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    RatingBar.builder(
                                                      initialRating: snapshot
                                                          .data[i].numberStar
                                                          .ceilToDouble(),
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 3,
                                                      itemPadding: EdgeInsets.symmetric(
                                                          horizontal: 4.0),
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
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    }),
                (nbrPasHorizontal!=nbreDisplayHorizontal*10+resteHorizontal)?Padding(
                  padding: EdgeInsets.only(left:20, right:20),
                  child: GestureDetector(
                    onTap: () {
                       if(nbrPasHorizontal==nbreDisplayHorizontal*10)
                         setState(() {
                           nbrPasHorizontal+=resteHorizontal;
                         });
                       else if(nbreDisplayHorizontal!=nbreDisplayHorizontal*10)
                         setState(() {
                           nbrPasHorizontal+=10;
                         });
                      /* Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => ProduitsRecommandes()));*/
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 100),
                         height: 30,
                          width: 100,
                      child: Center(
                        child: Text("Voir plus", style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 16,
                            fontFamily: "MonseraBold"),),
                      ),
                      color: HexColor("#FFC30D"),
                    ),
                  ),
                ):Text("")
              ],
            )),
        Padding(
          padding: EdgeInsets.only(
              top: longueurPerCent(18, context),
              left: largeurPerCent(13, context)),
          child: Text(
            "Découvrir",
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 16,
                fontFamily: "MonseraBold"),
          ),
        ),
        SizedBox(
          height: longueurPerCent(18, context),
        ),

        //display all the products
        StreamBuilder(
            stream: FirestoreService().getTousLesProduits(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Produit>> snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Center(
                  child: Center(
                      child: SpinKitFadingCircle(
                    color: HexColor("#001c36"),
                    size: 30,
                  )),
                );
              } else if (snapshot.data.isEmpty) {
                return elementsVides(context, Icons.do_not_disturb,
                    "Pas de nouveaux produits ajoutés");
              } else {
                return StaggeredGridView.countBuilder(
                  reverse: false,
                  crossAxisCount: 4,
                  itemCount: nbrPasVertical,
                  itemBuilder: (BuildContext context, index) {
                    resteVertical= snapshot.data.length%nbrPasVertical;
                    nbreDisplayVertical=snapshot.data.length~/nbrPasVertical;
                    Color _color = _randomColor.randomColor();
                    expiryBadgeNew =
                        DateTime.parse(snapshot.data[index].expiryBadgeNew);
                    bool displayBadgeNew =
                        !expiryBadgeNew.isBefore(DateTime.now());
                    Produit produit = snapshot.data[index];
                    int prixProduit = produit.prix;
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
                                      produit, Renseignements.emailUser)));
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
                                    imageUrl: produit.image1,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: _color,
                                      height: longueurPerCent(110, context),
                                      width: largeurPerCent(210, context),
                                    ),
                                  ),
                                ),
                              ),
                              (displayBadgeNew)
                                  ? Container(
                                      height: longueurPerCent(10, context),
                                      width: largeurPerCent(50, context),
                                      color: Colors.red,
                                      child: Center(
                                        child: Text(
                                          "NOUVEAU",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: HexColor("#FFFFFF"),
                                              fontSize: 9.0,
                                              fontFamily: "MontserratBold",
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              StreamBuilder(
                                stream:
                                    FirestoreService().getReductionCollection(),
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
                                      if (produit.sousCategorie ==
                                              snapshotReduction
                                                  .data[i].nomCategorie &&
                                          !DateTime.parse(snapshotReduction
                                                  .data[i].expiryDate)
                                              .isBefore(DateTime.now()) &&
                                          snapshotReduction.data[i].genre ==
                                              produit.categorie &&
                                          snapshotReduction
                                                  .data[i].numberStar ==
                                              produit.numberStar) {
                                        appyReduce = true;
                                        pourcentageReduce = snapshotReduction
                                            .data[i].pourcentageReduction;
                                        produit.prix = prixReduit(
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
                                                        couleur:
                                                            HexColor("#00CC7b"),
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
                                                        couleur:
                                                            HexColor("#00CC7b"),
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
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: largeurPerCent(200, context),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: largeurPerCent(10, context),
                                      top: longueurPerCent(5, context)),
                                  child: AutoSizeText(
                                    snapshot.data[index].nomDuProduit,
                                    minFontSize: 12,
                                    maxLines: 2,
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingBar.builder(
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
                                      ),
                                      /*Padding(
                                  padding: EdgeInsets.only(right:10),
                                  child: Text(produit.taille, style:TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontFamily:
                                      "MonseraBold"),),
                                )*/
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
                  crossAxisSpacing: 0.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
              }
            }),
        SizedBox(
          height: longueurPerCent(10, context),
        ),
        (nbrPasVertical!=nbreDisplayVertical*10+resteVertical)?GestureDetector(
          onTap: () {
            if(nbrPasVertical==nbreDisplayVertical*10)
              setState(() {
                nbrPasVertical+=resteVertical;
              });
            else if(nbreDisplayVertical!=nbreDisplayVertical*10)
              setState(() {
                nbrPasVertical+=10;
              });
          },
          child: Center(
            child: Container(
              height: 30,
              width: 100,
              child: Center(
                child: Text("Voir plus", style: TextStyle(
                    color: HexColor("#001C36"),
                    fontSize: 16,
                    fontFamily: "MonseraBold"),),
              ),
              color: HexColor("#FFC30D"),
            ),
          ),
        ):Text(""),
        SizedBox(
          height: longueurPerCent(28, context),
        ),
      ]),
    );
  }

/* StreamBuilder(
                    stream: FirestoreService().getProduitRecommandes(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Produit>> snapshot) {
                      if (snapshot.hasError || !snapshot.hasData)
                        return Center(
                          child: Center(
                              child: SpinKitFadingCircle(
                            color: HexColor("#001c36"),
                            size: 30,
                          )),
                        );
                      else if (snapshot.data.isEmpty) {
                        return Center();
                      } else {
                        Color _color = _randomColor.randomColor();
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: nbrHorizontal,
                            itemBuilder: (context, i) {
                               reste= snapshot.data.length%10;
                               nbreDisplay=(snapshot.data.length/10).toInt();
                              expiryBadgeNew =
                                  DateTime.parse(snapshot.data[i].expiryBadgeNew);
                              bool displayBadgeNew =
                                  !expiryBadgeNew.isBefore(DateTime.now());
                              Produit produit = snapshot.data[i];
                              int prixProduit = snapshot.data[i].prix;
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      idProduitsFavorisUser(snapshot.data[i], context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ArticleSansTaille(
                                                  snapshot.data[i],
                                                  Renseignements.emailUser)));
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: 154,
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
                                              height: longueurPerCent(110, context),
                                              width: largeurPerCent(210, context),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot.data[i].image1,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    color: _color,
                                                    height:
                                                        longueurPerCent(110, context),
                                                    width: largeurPerCent(210, context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (displayBadgeNew)
                                                ? Container(
                                                    height:
                                                        longueurPerCent(10, context),
                                                    color: Colors.red,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: longueurPerCent(
                                                            10, context),
                                                        right: longueurPerCent(
                                                            10, context),
                                                      ),
                                                      child: Text(
                                                        "NOUVEAU",
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                            color: HexColor("#FFFFFF"),
                                                            fontSize: 9.0,
                                                            fontFamily:
                                                                "MontserratBold",
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
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
                                                    if (produit.sousCategorie ==
                                                            snapshotReduction
                                                                .data[i].nomCategorie &&
                                                        !DateTime.parse(
                                                                snapshotReduction
                                                                    .data[i].expiryDate)
                                                            .isBefore(DateTime.now()) &&
                                                        snapshotReduction
                                                                .data[i].genre ==
                                                            produit.categorie &&
                                                        snapshotReduction
                                                                .data[i].numberStar ==
                                                            produit.numberStar) {
                                                      appyReduce = true;
                                                      pourcentageReduce =
                                                          snapshotReduction.data[i]
                                                              .pourcentageReduction;
                                                      produit.prix = prixReduit(
                                                          prixProduit,
                                                          pourcentageReduce);
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
                                                                      price:
                                                                          prixProduit,
                                                                      couleur:
                                                                          Colors.red,
                                                                      size: 14,
                                                                      police:
                                                                          "MonseraBold",
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
                                                                      police:
                                                                          "MonseraBold")
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
                                                                      price:
                                                                          prixProduit,
                                                                      couleur: HexColor(
                                                                          "#00CC7b"),
                                                                      size: 14,
                                                                      police:
                                                                          "MonseraBold")
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
                                                maxWidth: largeurPerCent(200, context),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: largeurPerCent(10, context),
                                                    top: longueurPerCent(5, context)),
                                                child: AutoSizeText(
                                                  snapshot.data[i].nomDuProduit,
                                                  minFontSize: 12,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: HexColor("#909090"),
                                                      fontSize: 15,
                                                      fontFamily: "MonseraRegular"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: longueurPerCent(5, context),
                                                    left: largeurPerCent(4, context)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RatingBar.builder(
                                                      initialRating: snapshot
                                                          .data[i].numberStar
                                                          .ceilToDouble(),
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 3,
                                                      itemPadding: EdgeInsets.symmetric(
                                                          horizontal: 4.0),
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
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*(i==nbreDisplay-1)?
                                  (nbrHorizontal<snapshot.data.length)?Padding(
                                    padding: EdgeInsets.only(left:20, right:20),
                                    child: FlatButton(
                                      onPressed: () {
                                       if(!(nbrHorizontal>snapshot.data.length)){
                                         setState(() {
                                           nbrHorizontal+=10;
                                         });
                                       } else {
                                         nbrHorizontal=snapshot.data.length;
                                       }
                                       /* Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => ProduitsRecommandes()));*/
                                      },
                                      child: Text("Voir plus", style: TextStyle(
                                          color: HexColor("#001C36"),
                                          fontSize: 16,
                                          fontFamily: "MonseraBold"),),
                                      color: HexColor("#FFC30D"),
                                    ),
                                  ):Text(""):Text("")*/
                                ],
                              );
                            });
                      }
                    }),*/

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text("Fermer l'application",
                style: TextStyle(
                    color: HexColor("#001C36"),
                    fontSize: 15.0,
                    fontFamily: "MonseraBold")),
            content: new Text("Voulez-vous quitter l'application?",
                style: TextStyle(fontFamily: "MonseraLight")),
            actions: <Widget>[
              new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text(
                    "NON",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 12.0,
                        fontFamily: "MonseraBold"),
                  )),
              SizedBox(
                height: longueurPerCent(10, context),
              ),
              SizedBox(
                width: largeurPerCent(50, context),
              ),
              new GestureDetector(
                  onTap: () => exit(0),
                  child: Text(
                    "OUI",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 12.0,
                        fontFamily: "MonseraBold"),
                  )),
              SizedBox(
                height: longueurPerCent(10, context),
              ),
              SizedBox(
                width: largeurPerCent(20, context),
              ),
            ],
          ),
        ) ??
        false;
  }

  int prixReduit(int prix, int pourcentageReduction) {
    int resultat = ((1 - pourcentageReduction / 100) * prix).toInt();
    return resultat;
  }

  String key = "email_user";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> liste = sharedPreferences.getStringList(key);
    if (liste != null) {
      if (this.mounted)
        setState(() {
          Renseignements.userData = liste;
        });
    }
  }

  /* Fin de la fonction */

  /* Cette fonction permet d'ajouter les informations*/

  Future<void> ajouter(List<String> str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.userData = str;
    await sharedPreferences.setStringList(key, Renseignements.userData);
    obtenir();
  }
}
