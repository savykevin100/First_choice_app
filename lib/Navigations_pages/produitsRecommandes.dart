import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';

import '../checkConnexion.dart';
import 'Widgets/products_gried_view.dart';

class ProduitsRecommandes extends StatefulWidget {
  @override
  _ProduitsRecommandesState createState() => _ProduitsRecommandesState();
}

class _ProduitsRecommandesState extends State<ProduitsRecommandes> {
  int ajoutPanier = 0;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Produits Recommandés",
        context: context,
        controller: controller,
        nbAjoutPanier: ajoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      body: Test(
        displayContains: ListView(
          controller: controller,
          children: <Widget>[
            SizedBox(
              height: longueurPerCent(30, context),
            ),
            product_grid_view(FirestoreService().getProduitRecommandes())
          ],
        ),
      ),
    );
  }
}
