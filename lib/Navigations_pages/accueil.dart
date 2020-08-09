import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages_article_paniers/article.dart';
import 'Widgets/scrollable_products_horizontal.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  final _auth = FirebaseAuth.instance;
  Firestore _db = Firestore.instance;
  int nombreAjoutPanier;
  FirebaseUser utilisateurConnecte;
  AnimationController animationController;
  Animation carouselAnimation;
  int lenght;
  List<Map<String, dynamic>> produitsRecommander = [];
  List<Map<String, dynamic>> tousLesProduits=[];

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          utilisateurConnecte = user;
          ajouter(utilisateurConnecte.email);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void idProduitsFavorisUser1(Map<String, dynamic> produit, BuildContext context) async {
    if (Renseignements.emailUser != null) {
      try {
        Firestore.instance
            .collection("Utilisateurs")
            .document(Renseignements.emailUser)
            .collection("ProduitsFavoirsUser")
            .where("imagePrincipaleProduit", isEqualTo: produit["image1"])
            .getDocuments()
            .then((QuerySnapshot snapshot) async {
          if (snapshot.documents.isEmpty) {
            await FirestoreService().addProduitFavorisUser(
                ProduitsFavorisUser(
                    imagePrincipaleProduit: produit["image1"],
                    imageSelect: produit["image1"],
                    etatIconeFavoris: false,
                    etatSurMesure: false),
                Renseignements.emailUser);
            print("L'ajout a été fait avant le onap");
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

/* Liste de photos qui contient les images à defiler dans le carousel */
  int photoIndex = 0;
  List<String> photos = [
    'assets/images/gadgets-336635_1920.jpg',
    'assets/images/make-up-1209798_1920.jpg',
    'assets/images/sketchbook-156775_1280.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    animationController =
        AnimationController(duration: Duration(seconds: 18), vsync: this);

    carouselAnimation =
        IntTween(begin: 0, end: photos.length - 1).animate(animationController)
          ..addListener(() {
            setState(() {
              photoIndex = carouselAnimation.value;
            });
          });

    animationController.repeat();

    Firestore.instance
        .collection("Femmes")
        .document("CHAUSSURES")
        .collection("Produits")
        .getDocuments()
        .then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        if (value.documents[i].data["numberStar"] == 3) {
          produitsRecommander.add(value.documents[i].data);
        }
        tousLesProduits.add(value.documents[i].data);
      }
    });
    Firestore.instance
        .collection("Femmes")
        .document("JEANS")
        .collection("Produits")
        .getDocuments()
        .then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        if (value.documents[i].data["numberStar"] == 3) {
          produitsRecommander.add(value.documents[i].data);
        }
        tousLesProduits.add(value.documents[i].data);
      }
    });
    Firestore.instance
        .collection("Femmes")
        .document("ACCESSOIRES")
        .collection("Produits")
        .getDocuments()
        .then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        if (value.documents[i].data["numberStar"] == 3) {
          produitsRecommander.add(value.documents[i].data);
        }
        tousLesProduits.add(value.documents[i].data);
      }
    });
    Firestore.instance
        .collection("Femmes")
        .document("T-SHIRT")
        .collection("Produits")
        .getDocuments()
        .then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        if (value.documents[i].data["numberStar"] == 3) {
          produitsRecommander.add(value.documents[i].data);
        }
        tousLesProduits.add(value.documents[i].data);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  /*Fin de l'initialisation de la page*/

  Widget carousel() {
    return Stack(
      children: <Widget>[
        Container(
          height: longueurPerCent(200, context),
          //margin: EdgeInsets.only(top: longueurPerCent(0, context)),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(photos[photoIndex]), fit: BoxFit.cover)),
        ),
        Positioned(
          top: longueurPerCent(170.0, context),
          left: longueurPerCent(MediaQuery.of(context).size.width*0.33, context),
          child: SelectedPhoto(
              photoIndex: photoIndex, numberOfDots: photos.length),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
      if (utilisateurConnecte != null && produitsRecommander != null && tousLesProduits != null) {
        AppBarClasse _appBar = AppBarClasse(
            titre: "Premier Choix",
            context: context,
            controller: controller,
            nbAjoutPanier: nombreAjoutPanier);
        return Scaffold(
          backgroundColor: HexColor("#F5F5F5"),
            appBar: _appBar.appBarFunctionStream(),
            drawer: ProfileSettings(
              userCurrent: utilisateurConnecte.email,
            ),
            body: Snap(
              controller: controller.appBar,
              child: ListView(controller: controller, children: <Widget>[
                SizedBox(
                  height: longueurPerCent(10, context),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: largeurPerCent(6, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      color: HexColor("#DDDDDD"),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding:
                          EdgeInsets.only(left: largeurPerCent(90, context)),
                          child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                        ),
                        labelText: "Rechercher un produit",
                        labelStyle: TextStyle(
                            color: HexColor('#9B9B9B'),
                            fontSize: 17.0,
                            fontFamily: 'MonseraLight'),
                        contentPadding: EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                        ),
                      ),
                    )),
                SizedBox(
                  height: longueurPerCent(10, context),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: longueurPerCent(200, context),
                  decoration: BoxDecoration(
                    color: HexColor("#001C36"),
                  ),
                  child: carousel(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(30, context),
                      left: largeurPerCent(13, context)),
                  child: Text(
                    "Produits recommandés",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 20,
                        fontFamily: "MonseraBold"),
                  ),
                ),
                SizedBox(
                  height: longueurPerCent(16, context),
                ),
                Container(
                  height: longueurPerCent(220, context),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: produitsRecommander.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            idProduitsFavorisUser1(
                                produitsRecommander[i], context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ArticleSansTaille(
                                            produitsRecommander[i],
                                            Renseignements.emailUser)));
                          },
                          child: Container(
                            width: largeurPerCent(160, context),
                            margin: EdgeInsets.only(
                                left: largeurPerCent(10, context)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Card(
                              elevation: 5.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height:
                                    longueurPerCent(120, context),
                                    width: largeurPerCent(160, context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                            Radius.circular(7),
                                            topRight:
                                            Radius.circular(7)),
                                        child: Image.network(
                                          produitsRecommander[i]["image1"],
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              progress) {
                                            return progress == null
                                                ? child
                                                : LinearProgressIndicator(
                                              backgroundColor: HexColor(
                                                  "EFD807"),);
                                          },
                                        )),
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
                                                10, context)),
                                        child: Text(
                                          "${produitsRecommander[i]["prix"]} FCFA",
                                          style: TextStyle(
                                              color:
                                              HexColor("#00CC7b"),
                                              fontSize: 16.5,
                                              fontFamily:
                                              "MonseraBold"),
                                        )),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                      largeurPerCent(200, context),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: largeurPerCent(10, context),
                                          top: longueurPerCent(5, context)),
                                      child: Text(
                                        produitsRecommander[i]["nomDuProduit"],
                                        style: TextStyle(
                                            color: HexColor("#909090"),
                                            fontSize: 15,
                                            fontFamily: "MonseraRegular"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                          longueurPerCent(10, context),
                                          left: largeurPerCent(4, context)
                                      ),
                                      child: RatingBar(
                                        initialRating: produitsRecommander[i]["numberStar"]
                                            .ceilToDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 3,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) =>
                                            Icon(
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
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(18, context),
                      left: largeurPerCent(13, context)),
                  child: Text(
                    "Découverte",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 20,
                        fontFamily: "MonseraBold"),
                  ),
                ),
                SizedBox(
                  height: longueurPerCent(18, context),
                ),
                (tousLesProduits != null) ? StaggeredGridView.countBuilder(
                  reverse: false,
                  crossAxisCount: 4,
                  itemCount: tousLesProduits.length,
                  itemBuilder: (BuildContext context, index) {
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
                          idProduitsFavorisUser1(
                              tousLesProduits[index], context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ArticleSansTaille(tousLesProduits[index],
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
                                      tousLesProduits[index]["image1"],
                                      loadingBuilder: (context, child,
                                          progress) {
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
                                        top: longueurPerCent(10, context)),
                                    child: Text(
                                      "${tousLesProduits[index]["prix"]} FCFA",
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
                                    tousLesProduits[index]["nomDuProduit"],
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
                                    initialRating: tousLesProduits[index]
                                    ["numberStar"]
                                        .ceilToDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 3,
                                    itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                    ignoreGestures: true,
                                    itemBuilder: (context, _) =>
                                        Icon(
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
                ) : Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: longueurPerCent(18, context),
                ),
              ]),
            ));
      } else {
        return Container(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        );
      }
    }

  String key = "email_user";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String liste = sharedPreferences.getString(key);
    if (liste != null) {
      setState(() {
        Renseignements.emailUser = liste;
      });
    }
  }

  /* Fin de la fonction */

  /* Cette fonction permet d'ajouter les informations*/

  Future<void> ajouter(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.emailUser = str;
    await sharedPreferences.setString(key, Renseignements.emailUser);
    obtenir();
  }
}




class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return Center(
      child: new Container(
          child: new Padding(
        padding: const EdgeInsets.only(left: 9.0, right: 9.0),
        child: Container(
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
              color: HexColor('#ffffff'),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      )),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 9.0, right: 9.0),
        child: Container(
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white, spreadRadius: 0.0, blurRadius: 10.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
