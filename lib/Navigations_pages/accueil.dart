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
          left: MediaQuery.of(context).size.width / 2.5,
          child: SelectedPhoto(
              photoIndex: photoIndex, numberOfDots: photos.length),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
   if(utilisateurConnecte!=null){
     AppBarClasse _appBar = AppBarClasse(
         titre: "Accueil", context: context, controller: controller, nbAjoutPanier: nombreAjoutPanier);
     return Scaffold(
         appBar: _appBar.appBarFunctionStream(),
         drawer: ProfileSettings(userCurrent: utilisateurConnecte.email,),
         body: Snap(
           controller: controller.appBar,
           child: ListView(controller: controller, children: <Widget>[
             SizedBox(
               height: longueurPerCent(10, context),
             ),
             Container(
                 margin: EdgeInsets.symmetric(horizontal: largeurPerCent(6, context)),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(7.0)),
                   color: HexColor("#DDDDDD"),
                 ),
                 child: TextFormField(
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     prefixIcon: Padding(
                       padding:  EdgeInsets.only(left: largeurPerCent(90, context)),
                       child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                     ),

                     labelText: "Rechercher un produit",
                     labelStyle: TextStyle(
                         color: HexColor('#9B9B9B'),
                         fontSize: 17.0,
                         fontFamily: 'MonseraLight'),
                     contentPadding: EdgeInsets.only(top: 10, bottom: 5, ),

                   ),
                 )),
             SizedBox(
              height: longueurPerCent(10, context),
             ),
             Container(
               width: MediaQuery.of(context).size.width ,
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
                 "PRODUITS RECOMMANDÉS",
                 style: TextStyle(
                     color: HexColor("#001C36"),
                     fontSize: 20,
                     fontFamily: "MonseraBold"),
               ),
             ),
             SizedBox(
               height: longueurPerCent(16, context),
             ),
             scrollabe_products_horizontal(context),
             Padding(
               padding: EdgeInsets.only(
                   top: longueurPerCent(18, context),
                   left: largeurPerCent(13, context)),
               child: Text(
                 "DÉCOUVERTES",
                 style: TextStyle(
                     color: HexColor("#001C36"),
                     fontSize: 20,
                     fontFamily: "MonseraBold"),
               ),
             ),
             SizedBox(height: longueurPerCent(18, context),),
             product_grid_view(),
             SizedBox(height: longueurPerCent(18, context),),
             new Container()
           ]),
         ));
    if (utilisateurConnecte != null && produitsRecommander != null) {
      AppBarClasse _appBar = AppBarClasse(
          titre: "Accueil",
          context: context,
          controller: controller,
          nbAjoutPanier: nombreAjoutPanier);
      return Scaffold(
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
                width: MediaQuery.of(context).size.width,
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
                  "PRODUITS RECOMMANDÉS",
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 20,
                      fontFamily: "MonseraBold"),
                ),
              ),
              SizedBox(
                height: longueurPerCent(16, context),
              ),
              scrollabe_products_horizontal(context),
              Padding(
                padding: EdgeInsets.only(
                    top: longueurPerCent(18, context),
                    left: largeurPerCent(13, context)),
                child: Text(
                  "DÉCOUVERTES",
                  style: TextStyle(
                      color: HexColor("#001C36"),
                      fontSize: 20,
                      fontFamily: "MonseraBold"),
                ),
              ),
              SizedBox(
                height: longueurPerCent(18, context),
              ),
              StaggeredGridView.countBuilder(
                reverse: false,
                crossAxisCount: 4,
                itemCount: produitsRecommander.length,
                itemBuilder: (BuildContext context, index) {
                  ///  Produit produit = snapshot.data[index];
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
                        /// idProduitsFavorisUser(produit, context);
                        ///print(produit.nomDuProduit);
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
                                    produitsRecommander[index]["image1"],
                                    loadingBuilder: (context, child, progress) {
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
                                    "${produitsRecommander[index]["prix"]} FCFA",
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
                                maxWidth: largeurPerCent(200, context),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: largeurPerCent(10, context)),
                                child: Text(
                                  produitsRecommander[index]["nomDuProduit"],
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
                                  initialRating: produitsRecommander[index]
                                          ["numberStar"]
                                      .ceilToDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 3,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
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
              ),
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
