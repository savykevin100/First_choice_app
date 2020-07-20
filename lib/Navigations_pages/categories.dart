import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';


class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(titre: "Catégories", context: context);
    return Scaffold(
      appBar: _appBar.appBarFunction(),
      drawer: ProfileSettings(),
      body: Container(
      ),
    );
  }

/* body:  , */
}