import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';


class ProduitsCategorie extends StatefulWidget {
  String titreCategorie;
  ProduitsCategorie(this.titreCategorie);
  @override
  _ProduitsCategorieState createState() => _ProduitsCategorieState();
}

class _ProduitsCategorieState extends State<ProduitsCategorie> {

  int ajoutPanier;
  ScrollController controller=ScrollController();

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: widget.titreCategorie,
        controller: controller,
        context: context,
        nbAjoutPanier: ajoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      body: ListView(
        controller: controller,
        children: <Widget>[
          SizedBox(height: longueurPerCent(30, context),),
          product_grid_view(),
        ],
      ),
    );
  }
}
