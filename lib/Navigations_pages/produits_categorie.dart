import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
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
    AppBarClasse _appBar = AppBarClasse(
      titre: widget.titreCategorie,
      controller: controller,
      context: context,
    );
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      body: ListView(
        controller: controller,
        children: <Widget>[
          SizedBox(
            height: longueurPerCent(30, context),
          ),
          product_grid_view(FirestoreService().getSousCategoriesProducts(widget.genre, widget.titreCategorie))
        ],
      ),
    );
  }
}
