import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/scrollable_products_horizontal.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final controller = ScrollController();
  Firestore _db = Firestore.instance;
  List<Map<String, dynamic>> recommandationProducts = [];

  Future<void> fecthProductsRecommandation() async {
    await _db.collection("produit").getDocuments().then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        recommandationProducts.add(value.documents[i].data);
        print(recommandationProducts[0]["nomDuProduit"]);
      }
      print(recommandationProducts[0]["nomDuProduit"]);
      print(recommandationProducts[1]["nomDuProduit"]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fecthProductsRecommandation();
    print(Renseignements.emailUser);
  }

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Accueil", context: context, controller: controller);
    return (recommandationProducts != null)
        ? Scaffold(
            appBar: _appBar.appBarFunction(),
            drawer: ProfileSettings(),
            body: Snap(
              controller: controller.appBar,
              child: ListView(controller: controller, children: <Widget>[
                SizedBox(
                  height: longueurPerCent(20, context),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: largeurPerCent(20, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: HexColor("#DDDDDD"),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding:  EdgeInsets.only(left: largeurPerCent(20, context)),
                          child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                        ),
                        labelText: "Rechercher un produit",
                        labelStyle: TextStyle(
                            color: HexColor('#9B9B9B'),
                            fontSize: 17.0,
                            fontFamily: 'MonseraLight'),
                        contentPadding: EdgeInsets.only(top: 10, bottom: 5, left:100),

                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(20, context),
                      left: largeurPerCent(10, context)),
                  child: Text(
                    "RECOMMANDÉS",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 22,
                        fontFamily: "MonseraBold"),
                  ),
                ),
                SizedBox(
                  height: longueurPerCent(20, context),
                ),
                scrollabe_products_horizontal(context),
                Padding(
                  padding: EdgeInsets.only(
                      top: longueurPerCent(20, context),
                      left: largeurPerCent(10, context)),
                  child: Text(
                    "DÉCOUVERTES",
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 22,
                        fontFamily: "MonseraBold"),
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                 product_grid_view()
              ]),
            ))
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget afficherRecommandation() {
    if (recommandationProducts != null) {
      for (int i = 0; i < recommandationProducts.length; i++) {
        Map<String, dynamic> produit = recommandationProducts[i];
        return Container(
          padding: EdgeInsets.only(top: 30, right: 10, left: 10),
          child: InkWell(
              onTap: () {},
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: longueurPerCent(200, context),
                  width: largeurPerCent(200, context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: longueurPerCent(160, context),
                        width: largeurPerCent(200, context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            image: DecorationImage(
                                image: NetworkImage(produit["image1"]),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                          height: longueurPerCent(40, context),
                          width: largeurPerCent(200, context),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  produit[i]["nomDuProduit"],
                                  style: TextStyle(
                                      color: HexColor("#001C36"),
                                      fontFamily: "MonseraBold"),
                                ),
                                Text(
                                  produit[i]["prix"],
                                  style: TextStyle(
                                      color: HexColor("#001C36"),
                                      fontFamily: "MonseraBold"),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )),
        );
      }
    }
  }

  Widget categories() {
    return StreamBuilder(
        stream: FirestoreService().getProduit(),
        builder: (BuildContext context, AsyncSnapshot<List<Produit>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return StaggeredGridView.countBuilder(
                reverse: false,
                crossAxisCount: 4,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, index) {
                  Produit produit = snapshot.data[index];
                  return Container(
                    padding: EdgeInsets.only(top: 30, right: 10, left: 10),
                    child: InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 5.0,
                          child: Container(
                            height: longueurPerCent(200, context),
                            width: largeurPerCent(200, context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: longueurPerCent(160, context),
                                  width: largeurPerCent(200, context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      image: DecorationImage(
                                          image: NetworkImage(produit.image1),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                    height: longueurPerCent(40, context),
                                    width: largeurPerCent(200, context),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            produit.nomDuProduit,
                                            style: TextStyle(
                                                color: HexColor("#001C36"),
                                                fontFamily: "MonseraBold"),
                                          ),
                                          Text(
                                            produit.prix,
                                            style: TextStyle(
                                                color: HexColor("#001C36"),
                                                fontFamily: "MonseraBold"),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )),
                  );
                },
                staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                shrinkWrap: false);
          }
        });
  }
}
/* SizedBox(
                height: 400,
                child: StreamBuilder(
                      stream: FirestoreService().getProduit(),
                      builder: (BuildContext context, AsyncSnapshot<List<Produit>> snapshot){
                        if(snapshot.hasError || !snapshot.hasData)
                          return Center(child: CircularProgressIndicator(),);
                        else {
                         return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i){
                                return Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.network(snapshot.data[i].image1),
                                );
                              });
                        }
                      })
              ),*/
