import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
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
          product_grid_view(FirestoreService().getSousCategoriesProducts(widget.genre, widget.titreCategorie))
        ],
      ),
    );
  }
}
