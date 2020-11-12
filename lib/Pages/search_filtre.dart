

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

import 'displaySearchResult.dart';



class SearchFiltre extends StatefulWidget {
  static String id = "Test";

  @override
  _SearchFiltreState createState() => _SearchFiltreState();
}

class _SearchFiltreState extends State<SearchFiltre> {
  final controller = ScrollController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool prix = false;
  String taille;
  String color;
  bool sizeChekbox = false;
  int prixMax;
  int prixMin;
  String genre;
  String sousCategorie;
  List<Map<String, dynamic>> data = [];
  int nombreAjoutPanier;
  List<String> selectedSizes = <String>[];
  String emptySearch;
  bool loadingSearch = false;
  String noData;
  int notFound=0;
  int longueur=0;

  List<RadioModel> sampleData = new List<RadioModel>();
  List<RadioModelGenre> sampleDataGenre = new List<RadioModelGenre>();
  List<RadioModelColor> sampleDataColor = new List<RadioModelColor>();
  List<RadioModelGenre> sampleDataSousCategorie = new List<RadioModelGenre>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _prixMaxController = TextEditingController();
  TextEditingController _prixMinController = TextEditingController();


  List<String> sousCategorieHommesEtFemmes = [];
  int somme = 0;
  int verificationLength = 0;
  bool pressSearchButton = false;


  String couleur;

  Future<void> getSousCategorie() async {


    await Firestore.instance.collection("Hommes").getDocuments().then((value) {
      value.documents.forEach((element) {
          if (this.mounted) {
            setState(() {
              somme++;
              verificationLength++;
              sousCategorieHommesEtFemmes.add(element.data["nomCategorie"]);
              sampleDataSousCategorie.add(
                  RadioModelGenre(false, "", element.data["nomCategorie"]));
            });
          }
      });
    });

    await Firestore.instance.collection("Femmes").getDocuments().then((value) {
      value.documents.forEach((element) {
        print(element.data["nomCategorie"]);
        if (!sousCategorieHommesEtFemmes.contains(element.data["nomCategorie"])) {
          if (this.mounted) {
            setState(() {
              somme++;
              verificationLength++;
              sampleDataSousCategorie.add(
                  RadioModelGenre(false, "", element.data["nomCategorie"]));
            });
          }
        }
      });
    });
  }

  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Display Size of products
    sampleData.add(new RadioModel(false, 'XS'));
    sampleData.add(new RadioModel(false, 'S',));
    sampleData.add(new RadioModel(false, 'M',));
    sampleData.add(new RadioModel(false, 'L',));
    sampleData.add(new RadioModel(false, 'XL'));
    sampleData.add(new RadioModel(false, 'XXL',));
    sampleData.add(new RadioModel(false, '28',));
    sampleData.add(new RadioModel(false, '30',));
    sampleData.add(new RadioModel(false, '32'));
    sampleData.add(new RadioModel(false, '34',));
    sampleData.add(new RadioModel(false, '36',));
    sampleData.add(new RadioModel(false, '38',));
    sampleData.add(new RadioModel(false, '40'));
    sampleData.add(new RadioModel(false, '42',));
    sampleData.add(new RadioModel(false, '44',));
    sampleData.add(new RadioModel(false, '46',));
    sampleData.add(new RadioModel(false, '48',));
    sampleData.add(new RadioModel(false, '50',));


    //Display Genre
    sampleDataGenre.add(new RadioModelGenre(false, '', 'Hommes',));
    sampleDataGenre.add(new RadioModelGenre(false, '', 'Femmes',));

    //Display Color
    sampleDataColor.add(new RadioModelColor(false, 'Vert',Colors.green));
    sampleDataColor.add(new RadioModelColor(false, 'Jaune',Colors.yellow));
    sampleDataColor.add(new RadioModelColor(false, 'Rouge',Colors.red));
    sampleDataColor.add(new RadioModelColor(false, 'Bleu',Colors.blue));
    sampleDataColor.add(new RadioModelColor(false, 'Orange',Colors.orange));
    sampleDataColor.add(new RadioModelColor(false, 'Blanc',Colors.white));
    sampleDataColor.add(new RadioModelColor(false, 'Noir',Colors.black));
    sampleDataColor.add(new RadioModelColor(false, 'Violet',Colors.purple));
    sampleDataColor.add(new RadioModelColor(false, 'Marron',Colors.brown));
    sampleDataColor.add(new RadioModelColor(false, 'Rose',Colors.pink));
    sampleDataColor.add(new RadioModelColor(false, 'Gris',Colors.grey));



    getSousCategorie();
  }


  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
      titre: "Filtres",
      context: context,
      controller: controller,
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appBar.appBarFunctionStream(),
      body: SingleChildScrollView(
        child: Center(
            child: (sampleDataSousCategorie != null) ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                      "Prix",
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 15,
                        fontFamily: "MonseraBold",
                      )
                  ),
                ),
                Container(
                  color: HexColor("#F5F5F5"),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 30.0, right: 30.0, bottom: 10),
                  margin: const EdgeInsets.only(
                      top: 0.0, left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2,
                          child: TextField(
                            controller: _prixMinController,
                            style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 12,
                              fontFamily: "MonseraBold",
                            ),
                            decoration: InputDecoration(
                                hintText: "Prix Min",
                                hintStyle: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 12,
                                  fontFamily: "MonseraRegular",
                                )
                            ),
                            onChanged: (value) => prixMin = int.tryParse(value),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2,
                          child: TextField(
                            controller: _prixMaxController,
                            style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 12,
                              fontFamily: "MonseraBold",
                            ),
                            decoration: InputDecoration(
                                hintText: "Prix Max",
                                hintStyle: TextStyle(
                                  color: HexColor("#001C36"),
                                  fontSize: 12,
                                  fontFamily: "MonseraRegular",
                                )
                            ),
                            onChanged: (value) => prixMax = int.tryParse(value),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                      "Genre",
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 15,
                        fontFamily: "MonseraBold",
                      )
                  ),
                ),
                Container(
                    color: HexColor("#F5F5F5"),
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 0.0, right: 0.0),
                    margin: const EdgeInsets.only(
                        top: 0.0, left: 20.0, right: 20.0),
                    height: longueurPerCent(60, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.blueAccent,
                          onTap: () {
                            setState(() {
                              sampleDataGenre.forEach(
                                      (element) => element.isSelected = false);
                              sampleDataGenre[0].isSelected = true;
                              genre = sampleDataGenre[0].text;
                            });
                          },
                          child: new RadioItemGenre(sampleDataGenre[0]),
                        ),
                        InkWell(
                          splashColor: Colors.blueAccent,
                          onTap: () {
                            setState(() {
                              sampleDataGenre.forEach(
                                      (element) => element.isSelected = false);
                              sampleDataGenre[1].isSelected = true;
                              genre = sampleDataGenre[1].text;
                            });
                          },
                          child: new RadioItemGenre(sampleDataGenre[1]),
                        )
                      ],
                    )
                ),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                      "Catégories",
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 15,
                        fontFamily: "MonseraBold",
                      )
                  ),
                ),
                Container(
                  color: HexColor("#F5F5F5"),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 0.0, right: 0.0),
                  margin: const EdgeInsets.only(
                      top: 0.0, left: 20.0, right: 20.0),
                  height: longueurPerCent(250, context),
                  child: Center(
                    child: StaggeredGridView.countBuilder(
                      reverse: false,
                      crossAxisCount: 4,
                      itemCount: sampleDataSousCategorie.length,
                      itemBuilder: (BuildContext context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.blueAccent,
                              onTap: () {
                                setState(() {
                                  sampleDataSousCategorie.forEach(
                                          (element) =>
                                      element.isSelected = false);
                                  sampleDataSousCategorie[index].isSelected =
                                  true;
                                  sousCategorie =
                                      sampleDataSousCategorie[index].text;
                                });
                              },
                              child: new RadioItemGenre(
                                  sampleDataSousCategorie[index]),
                            ),
                          ],
                        );
                      },
                      staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 10.0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                      (sousCategorie!="ACCESSOIRES" && sousCategorie!=null)?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text("Couleurs",
                          style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 15,
                            fontFamily: "MonseraBold",
                          )),
                    ),
                    Container(
                      color: HexColor("#F5F5F5"),
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 0.0),
                      margin: const EdgeInsets.only(
                          top: 0.0, left: 20.0, right: 20.0),
                      height: longueurPerCent(250, context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: StaggeredGridView.countBuilder(
                              reverse: false,
                              crossAxisCount: 10,
                              itemCount: sampleDataColor.length,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  splashColor: Colors.blueAccent,
                                  onTap: () {
                                    setState(() {
                                      sampleDataColor.forEach(
                                              (element) => element.isSelected = false);
                                      sampleDataColor[index].isSelected = true;
                                      couleur = sampleDataColor[index].buttonText;
                                    });
                                  },
                                  child: new RadioItemColor(sampleDataColor[index]),
                                );
                              },
                              staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ):Text(""),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                      "Taille",
                      style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 15,
                        fontFamily: "MonseraBold",
                      )
                  ),
                ),
                Container(
                  color: HexColor("#F5F5F5"),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 30.0, right: 0.0),
                  margin: const EdgeInsets.only(
                      top: 0.0, left: 20.0, right: 20.0),
                  height: longueurPerCent(250, context),
                  child: Center(
                    child: StaggeredGridView.countBuilder(
                      reverse: false,
                      crossAxisCount: 10,
                      itemCount: sampleData.length,
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          splashColor: Colors.blueAccent,
                          onTap: () {
                            setState(() {
                              sampleData.forEach(
                                      (element) => element.isSelected = false);
                              sampleData[index].isSelected = true;
                              taille = sampleData[index].buttonText;
                            });
                          },
                          child: new RadioItem(sampleData[index]),
                        );
                      },
                      staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
              ],
            ) : CircularProgressIndicator()
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (prixMax == null && prixMin == null && taille == null &&
                genre == null && sousCategorie == null) {
              displaySnackBarNom(
                  context, "VOUS N'AVEZ EFFECTUÉ AUCUNE RECHERCHE",
                  Colors.white);

            } else if(  ((prixMin!=null && prixMax==null && genre!=null)|| (prixMin!=null && prixMax==null && sousCategorie!=null)) ||(prixMin!=null && prixMax==null && taille!=null)
              || (prixMin!=null && prixMax==null && genre!=null && sousCategorie!=null) ||  (prixMin!=null && prixMax==null && genre!=null && taille!=null)   || (prixMin!=null && prixMax==null && taille!=null && sousCategorie!=null)
                || (prixMin!=null && prixMax==null && genre!=null && sousCategorie!=null && taille!=null)


                                                                   ||

                ((prixMax==null && prixMax!=null && genre!=null)|| (prixMin==null && prixMax!=null && sousCategorie!=null)) ||(prixMin==null && prixMax!=null && taille!=null)
                || (prixMin==null && prixMax!=null && genre!=null && sousCategorie!=null) ||  (prixMin==null && prixMax!=null && genre!=null && taille!=null)   || (prixMin==null && prixMax!=null && taille!=null && sousCategorie!=null)
                || (prixMin==null && prixMax!=null && genre!=null && sousCategorie!=null && taille!=null)
            ){//close the dialoge
              displaySnackBarNom(context, "Veuillez entrer les prix minimal et maximal", Colors.white);
            }
            else {
              setState(() {
                data = [];
              });
              showLoadingDialog(context, _keyLoader);
              // Genre search
              if (genre != null && sousCategorie == null && prixMax == null &&
                  prixMin == null && taille == null)
                getGenreOnly(); // good
              else
              if (genre != null && sousCategorie != null && prixMax == null &&
                  prixMin == null && taille == null && couleur==null)
                getGenreAndSousCategorie(); // good
              else if (genre != null && prixMax != null && prixMin != null &&
                  taille == null && sousCategorie == null)
                getGenreAndPrice(genre, prixMin, prixMax); // good
              else
              if (genre != null && taille != null && sousCategorie == null &&
                  prixMax == null && prixMin == null)
                getGenreAndSize(); // good
              else
              if (genre != null && taille != null && sousCategorie == null &&
                  prixMax != null && prixMin != null)
                getGenreAndPriceAndSize(
                    genre, prixMax, prixMin, taille); // good
              else if (genre != null && taille != null && sousCategorie != null &&
                  prixMax != null && prixMin != null && couleur==null)
                getGenreAndPriceAndSizeAndCategorie(
                    genre, taille, sousCategorie, prixMax, prixMin); // good

              // categorie search
              else
              if (sousCategorie != null && genre == null && prixMax == null &&
                  prixMin == null && taille == null && couleur==null) {
                getCategorieOnly(sousCategorie); // good
              }
              else
              if (sousCategorie != null && prixMax != null && prixMin != null &&
                  genre == null && taille == null && couleur==null)
                getCategorieAndPrice(sousCategorie, prixMax, prixMin); // good
              else
              if (sousCategorie != null && taille != null && prixMax == null &&
                  prixMin == null && genre == null && couleur==null)
                getCategorieAndSize(sousCategorie, taille); // good
              else
              if (sousCategorie != null && taille != null && prixMax != null &&
                  prixMin != null && genre == null && couleur==null)
                getCategorieAndSizeAndPrice(
                    sousCategorie, taille, prixMax, prixMin); // good

              // categorie search with color
              else
              if (sousCategorie != null && genre == null && prixMax == null &&
                  prixMin == null && taille == null && couleur!=null) {
                getCategorieWithColor(); // good
              }
             else
              if (sousCategorie != null && prixMax != null && prixMin != null &&
                  genre == null && taille == null && couleur!=null)
                getCategorieWithPriceAndColor(sousCategorie, prixMin, prixMax, couleur);// good
               else
              if (sousCategorie!= null && taille != null && prixMax == null &&
                  prixMin == null && genre == null && couleur!=null )
                getCategorieWithSizeAndColor(sousCategorie, couleur, taille);// good
              else
              if (sousCategorie != null && taille != null && prixMax != null &&
                  prixMin != null && genre == null)
                getCategorieAndSizeAndPriceAndColor(
                    sousCategorie, taille, prixMax, prixMin, couleur); // good
              else
              if (genre != null && sousCategorie != null && prixMax == null &&
                  prixMin == null && taille == null && couleur!=null)
                getCategorieGenreAndColor(sousCategorie, genre, couleur);
              else
              if (genre != null && sousCategorie != null && prixMax == null &&
                  prixMin == null && taille != null && couleur!=null)
                getCategorieGenreAndColorSize(sousCategorie, genre, couleur, taille); // good
              else if (genre != null && taille != null && sousCategorie != null &&
                  prixMax != null && prixMin != null && couleur!=null)
                getGenreAndPriceAndSizeAndCategorieColor(
                    genre, taille, sousCategorie, prixMax, prixMin, couleur); // good


              // Price search
              else if (prixMin != null && prixMax == null && genre == null &&
                  sousCategorie == null && taille == null)
                getPriceOnlyPriceMin();
              else if (prixMax != null && prixMin == null && genre == null &&
                  sousCategorie == null && taille == null)
                getPriceOnlyPriceMax();
              else if (taille != null && prixMax != null && prixMin != null)
                getPriceAndSize(taille, prixMin, prixMax); // good
              else if (prixMax != null && prixMin != null)
                getPriceMinAndPriceMaxOnly(prixMin, prixMax); // good
              // Size search
              else if (prixMax == null && prixMin == null && taille != null &&
                  genre == null && sousCategorie == null) {
                getSizeOnly(); // good
              }
              else if (prixMax == null && prixMin == null && taille == null &&
                  genre == null && sousCategorie == null) {
                setState(() {
                  data = null;
                  noData = "Vous n'avez effectué aucune recherche";
                });
                if (noData != null && loadingSearch == false && data == null) {
                  Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                      .pop(); //close the dialoge
                  displaySnackBarNom(context, noData, Colors.white);
                }
              }

              setState(() {
                prixMax = null;
                prixMin = null;
                _prixMaxController.text = "";
                _prixMinController.text = "";
                sousCategorie = null;
                couleur=null;
                sizeChekbox = false;
                prix = false;
                taille = null;
                genre = null;
                sampleData.forEach((element) {
                  setState(() {
                    element.isSelected = false;
                  });
                });
                sampleDataGenre.forEach((element) {
                  setState(() {
                    element.isSelected = false;
                  });
                });
                sampleDataSousCategorie.forEach((element) {
                  setState(() {
                    element.isSelected = false;
                  });
                });
              });
            }
          },
          child: Icon(Icons.search, color: Colors.white,),
          backgroundColor: Theme
              .of(context)
              .primaryColor
      ),
    );
  }


  void getGenreOnly() {
    Firestore.instance.collection("TousLesProduits").where(
        "categorie", isEqualTo: genre).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
       noResultSearch();
      }
    });
  }

  void getCategorieOnly(String subCategorie) {
    Firestore.instance.collection("TousLesProduits").where(
        "sousCategorie", isEqualTo: subCategorie).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
        noResultSearch();
      }
    });
  }

  void getPriceOnlyPriceMin() {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: prixMin).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
          });
        });
        closePopAndNavigateNextPage();
      } else {
        noResultSearch();
      }
    });
  }

  void getPriceOnlyPriceMax() {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isLessThanOrEqualTo: prixMax).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
         noResultSearch();
      }
    });
  }

  void getPriceOnlySize() {
    Firestore.instance.collection("TousLesProduits").where(
        "taille", isLessThanOrEqualTo: taille).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
        displaySnackBarNom(
            context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE",
            Colors.white);
        if (this.mounted)
          setState(() {
            loadingSearch = false;
            Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                .pop(); //close the dialoge
          });
      }
    });
  }


  void getGenreAndSousCategorie() {
    Firestore.instance.collection(genre).document(sousCategorie).collection(
        "Produits").getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
       noResultSearch();
      }
    });
  }

  void getGenreAndPrice(String categorie, int min, int max) {
    print(categorie);
    print(min);
    print(max);
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: min).where(
        "prix", isLessThanOrEqualTo: max).getDocuments().then((value) {
          print(value.documents.length);
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
           if(element.data["categorie"]==categorie){
             setState(() {
               data.add(element.data);
             });
             closePopAndNavigateNextPage();
           }
        });
      } else {
        noResultSearch();
      }
    });
  }


  void getGenreAndSize() {
    Firestore.instance.collection("TousLesProduits").where(
        "categorie", isEqualTo: genre)
        .where("taille", isEqualTo: taille)
        .getDocuments()
        .then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
       noResultSearch();
      }
    });
  }

  void getGenreAndPriceAndSize(String categorie, int maxPrice, int minPrice, String size) {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: prixMin).where(
        "prix", isLessThanOrEqualTo: prixMax).getDocuments()
        .then((value){
      setState(() {
        longueur=value.documents.length;
      });
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if(element.data["taille"]==size && element.data["categorie"]==categorie){
            setState(() {
              data.add(element.data);
            });
          } else
            setState(() {
              notFound++;
            });
        });
        verificationWithLengthDocumentsSearch();

      } else {
        noResultSearch();
      }
    });
  }

  void getCategorieAndPrice(String subCategorie, int maxPrice, int minPrice) {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: minPrice).where(
        "prix", isLessThanOrEqualTo: maxPrice).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        longueur=value.documents.length;
        value.documents.forEach((element) {
          if (element.data["sousCategorie"] == subCategorie) {
            setState(() {
              data.add(element.data);
            });
          } else
            setState(() {
              notFound++;
            });
        });
        verificationWithLengthDocumentsSearch();
      } else {
       noResultSearch();
      }
    });
  }

  void getCategorieAndSize(String subCategorie, String size) {
    Firestore.instance.collection("TousLesProduits").where(
        "sousCategorie", isEqualTo: subCategorie).where(
        "taille", isEqualTo: size).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
        noResultSearch();
      }
    });
  }


  void getPriceAndSize(String size, int minPrice, int maxPrice) {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: minPrice).where(
        "prix", isLessThanOrEqualTo: maxPrice).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["taille"] == size) {
            closePopAndNavigateNextPage();
            setState(() {
              data.add(element.data);
            });
          } else {
            displaySearchResult();
          }
        });
      } else {
       noResultSearch();
      }
    });
  }



  void getGenreAndPriceAndSizeAndCategorie(String categorie, String size,
      String subCategorie, int maxPrice, int minPrice) {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: minPrice).where(
        "prix", isLessThanOrEqualTo: maxPrice).getDocuments().then((value) {
      setState(() {
        longueur=value.documents.length;
      });
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["sousCategorie"] == subCategorie &&
              element.data["taille"] == size &&
              element.data["categorie"] == categorie) {
            setState(() {
              data.add(element.data);
            });
            closePopAndNavigateNextPage();
          } else setState(() {
            notFound++;
          });
        });
        verificationWithLengthDocumentsSearch();
      } else {
       noResultSearch();
      }
    });
  }

  void getCategorieAndSizeAndPrice(String subCategorie, String size,
      int maxPrice, int minPrice) {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: minPrice).where(
        "prix", isLessThanOrEqualTo: maxPrice).getDocuments().then((value) {
          setState(() {
            longueur=value.documents.length;
          });
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["sousCategorie"] == subCategorie &&
              element.data["taille"] == size) {
            closePopAndNavigateNextPage();
            setState(() {
              data.add(element.data);
              loadingSearch = false;
            });
          } else
           setState(() {
             notFound++;
           });
        });
        verificationWithLengthDocumentsSearch();
      } else {
       noResultSearch();
      }
    });
  }

  void getPriceMinAndPriceMaxOnly(int minPrice, int maxPrice) {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: minPrice).where(
        "prix", isLessThanOrEqualTo: maxPrice).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
          });
        });
        closePopAndNavigateNextPage();
      } else {
       noResultSearch();
      }
    });
  }

  void getSizeOnly() {
    Firestore.instance.collection("TousLesProduits").where(
        "taille", isEqualTo: taille).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (this.mounted)
            setState(() {
              data.add(element.data);
              loadingSearch = false;
            });
        });
        closePopAndNavigateNextPage();
      } else {
       noResultSearch();
      }
    });
  }

  void getCategorieWithColor() {
    Firestore.instance.collection("TousLesProduits").where(
        "sousCategorie", isEqualTo: sousCategorie).where("couleur", isEqualTo: couleur).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
        closePopAndNavigateNextPage();
      } else {
        noResultSearch();
      }
    });
  }

  void getCategorieWithPriceAndColor(String subCategorie, int min, int max, String color){
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: min).where(
        "prix", isLessThanOrEqualTo: max).getDocuments().then((value) {
          setState(() {
            longueur = value.documents.length;
          });
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if(element.data["couleur"]==color && element.data["sousCategorie"]==subCategorie){
            setState(() {
              data.add(element.data);
            });
          } else {
            notFound++;
           }
        });
        verificationWithLengthDocumentsSearch();
      } else {
        noResultSearch();
      }
    });
  }

  void getCategorieWithSizeAndColor(String subCategorie, String color, String size){
    Firestore.instance.collection("TousLesProduits").where(
        "sousCategorie", isEqualTo: subCategorie).where(
        "taille", isEqualTo: size).getDocuments().then((value) {
      setState(() {
        longueur = value.documents.length;
      });
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["couleur"]==color) {
            setState(() {
              data.add(element.data);
            });
          }else {
            notFound++;
          }
        });
        verificationWithLengthDocumentsSearch();

      } else {
       noResultSearch();
      }
    });
  }

  void getCategorieAndSizeAndPriceAndColor(String sousCategorie, String taille, int prixMax, int prixMin, String couleur) {
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: prixMin).where(
        "prix", isLessThanOrEqualTo: prixMax).getDocuments().then((value) {
          setState(() {
            longueur=value.documents.length;
          });
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["sousCategorie"] == sousCategorie &&
              element.data["taille"] == taille && element.data["couleur"]==couleur)
            setState(() {
              data.add(element.data);
            });
          else
            setState(() {
              notFound++;
            });
        });
      verificationWithLengthDocumentsSearch();
      }
      else
        noResultSearch();
    });
  }


  void getCategorieSizePriceAndColor(){
    Firestore.instance.collection("TousLesProduits").where(
        "prix", isGreaterThanOrEqualTo: prixMin).where(
        "prix", isLessThanOrEqualTo: prixMax).getDocuments().then((value) {
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["sousCategorie"] == sousCategorie &&
              element.data["taille"] == taille && element.data["couleur"]==couleur)
            setState(() {
              data.add(element.data);
              loadingSearch = false;
            });
        });
        closePopAndNavigateNextPage();
      } else {
       noResultSearch();
      }
    });
  }

  void getCategorieGenreAndColor(String sousCategorie, String genre, String couleur){
    Firestore.instance.collection(genre).document(sousCategorie).collection(
        "Produits").getDocuments().then((value) {
          setState(() {
            longueur=value.documents.length;
          });
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["couleur"]==couleur)
            setState(() {
              data.add(element.data);
            });
          else
            setState(() {
              notFound++;
            });
        });
       verificationWithLengthDocumentsSearch();
      } else {
      noResultSearch();
      }
    });
  }

  void getCategorieGenreAndColorSize(String categorie, String genre, String couleur, String taille) {
    Firestore.instance.collection(genre).document(categorie).collection(
        "Produits").getDocuments().then((value) {
      setState(() {
        longueur=value.documents.length;
      });
      if (value.documents.isNotEmpty) {
        value.documents.forEach((element) {
          if (element.data["couleur"]==couleur && element.data["taille"]==taille)
            setState(() {
              data.add(element.data);
            });
          else
            setState(() {
              notFound++;
            });
        });
        verificationWithLengthDocumentsSearch();
      } else {
        noResultSearch();
      }
    });
  }

  void getGenreAndPriceAndSizeAndCategorieColor(String genre, String taille, String sousCategorie, int prixMax, int prixMin, String couleur) {
    Firestore.instance.collection(genre).document(sousCategorie).collection("Produits").where(
        "prix", isGreaterThanOrEqualTo: prixMin).where(
        "prix", isLessThanOrEqualTo: prixMax).getDocuments().then((value) {
          if(value.documents.isNotEmpty) {
            value.documents.forEach((element) {
              setState(() {
                longueur = value.documents.length;
              });
                 if(element.data["couleur"]==couleur) {
                   setState(() {
                     data.add(element.data);
                   });
                 } else
                   setState(() {
                     notFound++;
                   });
            });
            verificationWithLengthDocumentsSearch();
          } else
            noResultSearch();
    });
  }





  void verificationWithLengthDocumentsSearch(){
  if(notFound==longueur) {
    setState(() {
      notFound=0;
      longueur=0;
    });
    noResultSearch();
  }
  else {
    setState(() {
      notFound=0;
      longueur=0;
    });
    closePopAndNavigateNextPage();
  }
}
  void closePopAndNavigateNextPage() {
    if (data != null) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
      Navigator.push(
          context, MaterialPageRoute(
          builder: (context) => DisplaySearchResult(data: data,)));
    }
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 13)),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  // ignore: missing_return
  Widget displaySearchResult() {
    /*if(noData!=null && loadingSearch==false && data==null)
      return Center(child: Text(noData),);
    else*/ if (loadingSearch == false && emptySearch != null && data == null &&
        noData == null)
      return Center(child: Text(emptySearch),);
  }


  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            Text("CHARGEMENT", style: TextStyle(
                                color: Colors.black, fontFamily: "Bold"),),
                            SizedBox(height: longueurPerCent(10, context),),
                            FlatButton(onPressed: (){
                              Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                                  .pop(); //close
                              setState(() {
                                data=[];
                                couleur=null;
                              });
                             }, color: Theme.of(context).primaryColor,
                                child: Text("Annuler", style: TextStyle(color: Colors.white)))
                          ],
                        )
                      ]),
                    )
                  ]));
        });
  }


  void noResultSearch(){
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop();
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    displaySnackBarNom(
        context, "Aucun element ne correspond à votre recherche",
        Colors.white);
  }



}


class RadioItemGenre extends StatelessWidget {
  final RadioModelGenre _item;
  RadioItemGenre(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 20.0,
            width: 20.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                    color:
                    _item.isSelected ? Colors.white : HexColor("#001C36"),fontSize: 15,
                    fontFamily: "MonseraRegular",
                    //fontWeight: FontWeight.bold,
                  )),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? HexColor("#FFC30D")
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.blueAccent
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text,
                style: TextStyle(
                  color: HexColor("#001C36"),
                  fontSize: 12,
                  fontFamily: "MonseraRegular",
                )),
          )
        ],
      ),
    );
  }
}

class RadioModelGenre {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModelGenre(this.isSelected, this.buttonText, this.text);
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(bottom: 10),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            height: 40.0,
            width: 40.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                    color:
                    _item.isSelected ? Colors.white : HexColor("#001C36"),fontSize: 12,
                    fontFamily: "MonseraRegular",
                    //fontWeight: FontWeight.bold,
                  )),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? HexColor("#FFC30D")
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
            ),
          ),
        ],
      ),
    );
  }
}


class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}

class RadioItemColor extends StatelessWidget {
  final RadioModelColor _item;
  RadioItemColor(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 55.0,
            width: 55.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                    color:
                    _item.isSelected ? _item.myColor :  _item.myColor,fontSize: 12,
                    fontFamily: "MonseraRegular",
                    //fontWeight: FontWeight.bold,
                  )),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? _item.myColor
                  : _item.myColor,
              border: new Border.all(
                  width: _item.isSelected?
                  3.0 :1.0,
                  color: _item.isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
            ),
          ),
        ],
      ),
    );
  }
}


class RadioModelColor {
  bool isSelected;
  final String buttonText;
  Color myColor;

  RadioModelColor(this.isSelected, this.buttonText, this.myColor);
}
