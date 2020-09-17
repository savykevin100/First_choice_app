import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/article.dart';



class SearchFiltre extends StatefulWidget {
  static String id = "Test";

  @override
  _SearchFiltreState createState() => _SearchFiltreState();
}

class _SearchFiltreState extends State<SearchFiltre> {
  final controller = ScrollController();


  bool prix=false;
  String taille;
  bool sizeChekbox=false;
  int prixMax;
  int prixMin;
  String _dropDownValue2;
  String genre;
  String sousCategorie;
  List<Map<String, dynamic>> data = [];
  int nombreAjoutPanier;
  List<String> selectedSizes = <String>[];
  String _currentCategory;
  String emptySearch=null;
  bool loadingSearch=false;
  String noData ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Filtres",
        context: context,
        controller: controller,
        nbAjoutPanier: nombreAjoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: longueurPerCent(50, context),),
              Padding(
                padding: EdgeInsets.only(right: largeurPerCent(20, context)),
                child: Text("Selectionnez le genre:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "MonseraBold"),),
              ),
              SizedBox(height: longueurPerCent(10, context),),
              // Genre list
              Center(
                child: Card(
                  child: Container(
                    height: longueurPerCent(50, context),
                    padding: EdgeInsets.only(
                        left: largeurPerCent(10, context),
                        right: largeurPerCent(20, context),
                        top: longueurPerCent(10, context)),
                    child: DropdownButton(
                      underline: Text(""),
                      hint: genre == null
                          ? Text(
                        'Genre',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                          : Text(
                        genre,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      isExpanded: true,
                      iconSize: 40.0,
                      items: ['Hommes', 'Femmes'].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            genre = val;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),
              Padding(
                padding: EdgeInsets.only(right: largeurPerCent(20, context)),
                child: Text("Selectionnez la catégorie :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "MonseraBold"),),
              ),
              SizedBox(height: longueurPerCent(10, context),),

              // Categorie list
              Center(
                child: Card(
                  child: Container(
                    height: longueurPerCent(50, context),
                    padding: EdgeInsets.only(
                        left: largeurPerCent(10, context),
                        right: largeurPerCent(20, context),
                        top: longueurPerCent(10, context)),
                    child: DropdownButton(
                      underline: Text(""),
                      hint: _dropDownValue2 == null
                          ? Text(
                        'Categorie',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                          : Text(
                        _dropDownValue2,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      isExpanded: true,
                      iconSize: 40.0,
                      items: ['ACCESSOIRES', 'CHEMISES', 'T-SHIRT', 'JEANS'].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            _dropDownValue2 = val;
                            sousCategorie = _dropDownValue2;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),
              Padding(
                padding: EdgeInsets.only(right: largeurPerCent(20, context)),
                child: Text("Selectionnez le type de filtre :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "MonseraBold"),),
              ),
              SizedBox(height: longueurPerCent(10, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: sizeChekbox,
                      onChanged: (bool value) {
                        setState(() {
                          sizeChekbox = value;
                        });
                      }),
                  Text("Taille"),
                  SizedBox(
                    width: longueurPerCent(100, context),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: prix,
                          onChanged: (bool value) {
                            setState(() {
                              prix = value;
                            });
                          }),
                      Text("prix")
                    ],
                  ),
                ],
              ),

              SizedBox(height: longueurPerCent(20, context),),
              (sizeChekbox)?Card(
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Taille",
                    ),
                    onChanged: (value) => taille=value,
                  ),
                ),
              ):Text(""),
              /*(sizeChekbox)?
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(value: selectedSizes.contains('XS'), onChanged: (value) => changeSelectedSize('XS')),
                      Text('XS'),

                      Checkbox(value: selectedSizes.contains('S'), onChanged: (value) => changeSelectedSize('S')),
                      Text('S'),

                      Checkbox(value: selectedSizes.contains('M'), onChanged: (value) => changeSelectedSize('M')),
                      Text('M'),

                      Checkbox(value: selectedSizes.contains('L'), onChanged: (value) => changeSelectedSize('L')),
                      Text('L'),

                      Checkbox(value: selectedSizes.contains('XL'), onChanged: (value) => changeSelectedSize('XL')),
                      Text('XL'),

                      Checkbox(value: selectedSizes.contains('XXL'), onChanged: (value) => changeSelectedSize('XXL')),
                      Text('XXL'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(value: selectedSizes.contains('28'), onChanged: (value) => changeSelectedSize('28')),
                      Text('28'),

                      Checkbox(value: selectedSizes.contains('30'), onChanged: (value) => changeSelectedSize('30')),
                      Text('30'),

                      Checkbox(value: selectedSizes.contains('32'), onChanged: (value) => changeSelectedSize('32')),
                      Text('32'),

                      Checkbox(value: selectedSizes.contains('34'), onChanged: (value) => changeSelectedSize('34')),
                      Text('34'),


                      Checkbox(value: selectedSizes.contains('36'), onChanged: (value) => changeSelectedSize('36')),
                      Text('36'),

                      Checkbox(value: selectedSizes.contains('38'), onChanged: (value) => changeSelectedSize('38')),
                      Text('38'),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(value: selectedSizes.contains('40'), onChanged: (value) => changeSelectedSize('40')),
                      Text('40'),

                      Checkbox(value: selectedSizes.contains('42'), onChanged: (value) => changeSelectedSize('42')),
                      Text('42'),

                      Checkbox(value: selectedSizes.contains('44'), onChanged: (value) => changeSelectedSize('44')),
                      Text('44'),

                      Checkbox(value: selectedSizes.contains('46'), onChanged: (value) => changeSelectedSize('46')),
                      Text('46'),

                      Checkbox(value: selectedSizes.contains('48'), onChanged: (value) => changeSelectedSize('48')),
                      Text('48'),

                      Checkbox(value: selectedSizes.contains('50'), onChanged: (value) => changeSelectedSize('50')),
                      Text('50'),
                    ],
                  ),
                ],
              ):Text(""),*/
              SizedBox(height: longueurPerCent(20, context),),
              (prix)?Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Prix Min",
                          ),
                          onChanged: (value) => prixMin=int.tryParse(value),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()),
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Prix Max",
                          ),
                          onChanged: (value) => prixMax=int.tryParse(value),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                ],
              ):Text(""),
              SizedBox(
                height: longueurPerCent(10, context),
              ),
              (loadingSearch==false)? displaySearchResult():Center(child: CircularProgressIndicator(),),
              SizedBox(
                height: longueurPerCent(50, context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              loadingSearch=true;
              data=[];
            });
            // Genre search
            if (genre!=null && sousCategorie==null && prixMax==null && prixMin==null && taille==null)
              getGenreOnly(); // good
            else if(genre!=null && sousCategorie!=null && prixMax==null && prixMin==null && taille==null)
              getGenreAndSousCategorie(); // good
            else if(genre!=null && prixMax!=null && prixMin!=null && taille==null && sousCategorie==null)
              getGenreAndPrice(genre); // good
            else if(genre!=null && taille!=null &&  sousCategorie==null && prixMax==null && prixMin==null)
              getGenreAndSize(); // good
            else if(genre!=null && taille!=null &&  sousCategorie==null && prixMax!=null && prixMin!=null)
              getGenreAndPriceAndSize(genre, prixMax, prixMin, taille); // good
            else if(genre!=null && taille!=null &&  sousCategorie!=null && prixMax!=null && prixMin!=null)
              getGenreAndPriceAndSizeAndCategorie(genre, taille, sousCategorie, prixMax, prixMin); // good

            // categorie search
            else if (sousCategorie != null && genre == null && prixMax==null && prixMin==null && taille==null)
              getCategorieOnly(sousCategorie);// good
            else if(sousCategorie!=null && prixMax!=null && prixMin!=null && genre==null && taille==null)
              getCategorieAndPrice(sousCategorie, prixMax, prixMin); // good
            else if(sousCategorie!=null && taille!=null && prixMax==null && prixMin==null && genre==null)
              getCategorieAndSize(sousCategorie, taille); // good
            else if(sousCategorie!=null && taille!=null && prixMax!=null && prixMin!=null && genre==null)
              getCategorieAndSizeAndPrice(sousCategorie, taille , prixMax, prixMin); // good


            // Price search
            else if (prixMin != null && prixMax == null && genre==null && sousCategorie==null && taille==null)
              getPriceOnlyPriceMin();
            else if (prixMax != null && prixMin == null   && genre==null && sousCategorie==null  && taille==null)
              getPriceOnlyPriceMax();
            else if (taille!=null && prixMax!=null && prixMin!=null )
              getPriceAndSize(taille, prixMin, prixMax); // good
            else if (  prixMax!=null && prixMin!=null )
              getPriceMinAndPriceMaxOnly(prixMin, prixMax); // good
            // Size search
            else if(prixMax==null && prixMin==null && taille!=null && genre==null && sousCategorie==null)
              getSizeOnly();// good
            else if(prixMax==null && prixMin==null && taille==null && genre==null && sousCategorie==null)
              setState(() {
                data=null;
                loadingSearch=false;
                emptySearch="VOUS N'AVEZ EFFECTUÉ AUCUNE RECHERCHE";
              });
            setState(() {
              _dropDownValue2=null;
              sousCategorie=null;
              sizeChekbox = false;
              prix = false;
              prixMax = null;
              prixMin = null;
              taille = null;
              genre = null;
            });
          },
          child: Icon(Icons.search, color: Colors.white,),
          backgroundColor: Theme.of(context).primaryColor
      ),
    );
  }

  void getGenreOnly(){
    Firestore.instance.collection("TousLesProduits").where("categorie", isEqualTo: genre).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getCategorieOnly(String subCategorie){
    Firestore.instance.collection("TousLesProduits").where("sousCategorie", isEqualTo: subCategorie).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
      } else {
        setState(() {
          loadingSearch = false;
          noData="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
          print(noData);
        });
      }
    });
  }

  void getPriceOnlyPriceMin(){
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: prixMin).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getPriceOnlyPriceMax(){
    Firestore.instance.collection("TousLesProduits").where("prix", isLessThanOrEqualTo: prixMax).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getPriceOnlySize(){
    Firestore.instance.collection("TousLesProduits").where("taille", isLessThanOrEqualTo: taille).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }


  void getGenreAndSousCategorie(){
    Firestore.instance.collection(genre).document(sousCategorie).collection("Produits").getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;
          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getGenreAndPrice(String categorie) {
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: prixMin).where("prix", isLessThanOrEqualTo:prixMax).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if(element.data["categorie"]==categorie)
            setState(() {
              data.add(element.data);
              loadingSearch = false;
            });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }


  void getGenreAndSize() {
    Firestore.instance.collection("TousLesProduits").where("categorie", isEqualTo: genre).where("taille", isEqualTo:taille).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;

          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getCategorieAndPrice(String subCategorie, int maxPrice, int minPrice) {
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: minPrice).where("prix", isLessThanOrEqualTo:maxPrice).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if(element.data["sousCategorie"]==subCategorie)
            setState(() {
              data.add(element.data);
              loadingSearch = false;

            });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getCategorieAndSize(String subCategorie, String size) {
    Firestore.instance.collection("TousLesProduits").where("sousCategorie", isEqualTo: subCategorie).where("taille", isEqualTo:size).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;

          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }


  void getPriceAndSize(String size, int minPrice, int maxPrice) {
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: minPrice).where("prix", isLessThanOrEqualTo:maxPrice).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if( element.data["taille"]==size)
            setState(() {
              data.add(element.data);
              loadingSearch = false;

            });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getGenreAndPriceAndSize(String categorie, int maxPrice, int minPrice, String size) {
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: minPrice).where("prix", isLessThanOrEqualTo:maxPrice).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if(element.data["taille"]==size && element.data["categorie"]==categorie)
            setState(() {
              data.add(element.data);
              loadingSearch = false;

            });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getGenreAndPriceAndSizeAndCategorie(String categorie, String size, String subCategorie, int maxPrice, int minPrice) {
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: minPrice).where("prix", isLessThanOrEqualTo:maxPrice).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if(element.data["sousCategorie"]==subCategorie && element.data["taille"]==size && element.data["categorie"]==categorie)
            setState(() {
              data.add(element.data);
              loadingSearch = false;

            });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getCategorieAndSizeAndPrice(String subCategorie, String size, int maxPrice, int minPrice) {
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: minPrice).where("prix", isLessThanOrEqualTo:maxPrice).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if(element.data["sousCategorie"]==subCategorie && element.data["taille"]==size)
            setState(() {
              data.add(element.data);
              loadingSearch = false;

            });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getPriceMinAndPriceMaxOnly(int minPrice, int maxPrice) {
    Firestore.instance.collection("TousLesProduits").where("prix", isGreaterThanOrEqualTo: minPrice).where("prix", isLessThanOrEqualTo:maxPrice).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;

          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }

  void getSizeOnly() {
    Firestore.instance.collection("TousLesProduits").where("taille", isEqualTo: taille).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          setState(() {
            data.add(element.data);
            loadingSearch = false;

          });
        });
      } else {
        emptySearch="AUCUN RESULTAT NE CORRESPOND À VOTRE RECHERCHE";
      }
    });
  }


  Widget displaySearchResult(){
    if(data!=null && loadingSearch==false){
      return  StaggeredGridView.countBuilder(
        reverse: false,
        crossAxisCount: 4,
        itemCount: data.length,
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
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ArticleSansTaille(Produit(
                              id: data[index]["id"],
                              nomDuProduit: data[index]["nomDuProduit"],
                              description: data[index]["description"],
                              image1: data[index]["image1"],
                              image2: data[index]["image2"],
                              image3: data[index]["image3"],
                              selectImage: data[index]["selectImage"],
                              prix: data[index]["prix"],
                              numberImages: data[index]["numberImages"],
                              numberStar: data[index]["numberStar"],
                              taille: data[index]["taille"],
                              categorie: data[index]["catagorie"],
                              sousCategorie: data[index]["sousCategorie"],
                              expiryBadgeNew: data[index]["expiryBadgeNew"],
                              idProduitCategorie: data[index]
                              ["idProduitCategorie"]), Renseignements.emailUser))),
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
                            data[index]["image1"],
                            loadingBuilder:
                                (context, child, progress) {
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
                            "${data[index]["prix"]} FCFA",
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
                          data[index]["nomDuProduit"],
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
                          initialRating: data[index]["numberStar"]
                              .ceilToDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 3,
                          itemPadding: EdgeInsets.symmetric(
                              horizontal: 4.0),
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
      );
    }
    else if(emptySearch!=null && data==null)
      return Center(child: Text(emptySearch),);
    else if(noData!=null && loadingSearch==false && data==null)
      return Center(child: Text("Pas de données"),);

  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentCategory = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if(selectedSizes.contains(size)){
      setState(() {
        selectedSizes.remove(size);
      });
    }else{
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }







}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Composants/firestore_service.dart';

class MyHomePage extends StatefulWidget {
 static String id="Homepage";
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
     FirestoreService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['categorie'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Firestore search'),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Faites une recherche',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 10.0),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList())
        ]));
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(data['categorie'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              )
          )
      )
  );
}*/
