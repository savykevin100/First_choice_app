import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Pages/search_filtre.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../checkConnexion.dart';
import 'Pages_article_paniers/panier.dart';
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
  int ajoutPanier = 0;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            print("L'ajout a été fait avant le onap");
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  DateTime expiryBadgeNew;

  int prixReduit(int prix, int pourcentageReduction) {
    int resultat = ((1 - pourcentageReduction / 100) * prix).toInt();
    return resultat;
  }

  @override
  Widget build(BuildContext context) {

    if(Platform.isAndroid)
      return Scaffold(
          appBar: appBarAndroid(),
          body: body());
    else
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: CupertinoPageScaffold(
            navigationBar: AppBarClasse().appBarIosWithoutDrawer(context, ajoutPanier, "Produits"),
            child: body(),
        ),
      );


   /* return (Platform.isAndroid)?Scaffold(
      appBar: appBarAndroid(),
      body: body()
    ):CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: AppBarClasse().appBarIosWithoutDrawer(ajoutPanier),
        child: body()
      ),
    );
    return Scaffold(
      appBar: appBarAndroid(),
      body: body()
    );*/
  }


  Widget appBarAndroid(){
    return ScrollAppBar(
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
                    if (snapshot.data[i].email == Renseignements.emailUser) {
                      ajoutPanier = snapshot.data[i].nbAjoutPanier;
                    }
                  }
                  return Text("$ajoutPanier");
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
    );
  }
  Widget body(){
    return Test(
      displayContains: ListView(
        controller: controller,
        children: <Widget>[
          SizedBox(
            height: longueurPerCent(30, context),
          ),
          product_grid_view(FirestoreService()
              .getSousCategoriesProducts(widget.genre, widget.titreCategorie))
        ],
      ),
    );
  }
}
