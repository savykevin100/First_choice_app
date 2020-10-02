import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  String genre;
  String sousCategorie;
  List<Map<String, dynamic>> data = [];
  int nombreAjoutPanier;
  List<String> selectedSizes = <String>[];
  String emptySearch;
  bool loadingSearch=false;
  String noData ;
  List<RadioModel> sampleData = new List<RadioModel>();
  List<RadioModelGenre> sampleDataGenre = new List<RadioModelGenre>();
  List<RadioModelGenre> sampleDataSousCategorie = new List<RadioModelGenre>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _prixMaxController = TextEditingController();
  TextEditingController _prixMinController = TextEditingController();


  List<String> sousCategorieHommes=[];
  List<String> sousCategorieFemmes=[];
  List<String> sousCategorieHommesEtFemmes=[];
  int somme=0;
  int verificationLength=0;




  Future<void> getSousCategorie() async{
    await Firestore.instance.collection("Hommes").getDocuments().then((value) {
      value.documents.forEach((element) {
        if(this.mounted){
          setState(() {
            somme++;
            verificationLength++;
            sampleDataSousCategorie.add(RadioModelGenre(false, "", element.data["nomCategorie"]));
          });
        }

      });
    });



    await Firestore.instance.collection("Femmes").getDocuments().then((value) {
      value.documents.forEach((element) {
       if(sampleDataSousCategorie.contains(element.data['nomCategorie'])){
        if(this.mounted){
          setState(() {
            somme++;
            sampleDataSousCategorie.add(RadioModelGenre(false, "", element.data["nomCategorie"]));
          });
        }
       }
      });
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sampleData.add(new RadioModel(false, 'XS'));
    sampleData.add(new RadioModel(false, 'S',));
    sampleData.add(new RadioModel(false, 'M', ));
    sampleData.add(new RadioModel(false, 'L',));
    sampleData.add(new RadioModel(false, 'XL'));
    sampleData.add(new RadioModel(false, 'XXL',));
    sampleData.add(new RadioModel(false, '28', ));
    sampleData.add(new RadioModel(false, '30',));
    sampleData.add(new RadioModel(false, '32'));
    sampleData.add(new RadioModel(false, '34',));
    sampleData.add(new RadioModel(false, '36', ));
    sampleData.add(new RadioModel(false, '38',));
    sampleData.add(new RadioModel(false, '40'));
    sampleData.add(new RadioModel(false, '42',));
    sampleData.add(new RadioModel(false, '44', ));
    sampleData.add(new RadioModel(false, '46',));
    sampleData.add(new RadioModel(false, '48',));
    sampleData.add(new RadioModel(false, '50',));



    sampleDataGenre.add(new RadioModelGenre(false, '','Hommes',));
    sampleDataGenre.add(new RadioModelGenre(false, '','Femmes',));

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
      appBar: _appBar.appBarFunctionStream(),
      body: SingleChildScrollView(
        child: Center(
          child:  (sampleDataSousCategorie!=null)?Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: longueurPerCent(20, context),),

              SizedBox(height: longueurPerCent(20, context),),

              Card(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 10.0, left: 60.0, right: 0.0),
                  margin: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                  height: longueurPerCent(60, context),
                  child:  ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: sampleDataGenre.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new InkWell(
                        splashColor: Colors.blueAccent,
                        onTap: () {
                          setState(() {
                            sampleDataGenre.forEach(
                                    (element) => element.isSelected = false);
                            sampleDataGenre[index].isSelected = true;
                            genre=sampleDataGenre[index].text;
                          });
                        },
                        child: new RadioItemGenre(sampleDataGenre[index]),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),
             Container(
               height: longueurPerCent(200, context),
               child:  StaggeredGridView.countBuilder(
                 reverse: false,
                 crossAxisCount: 4,
                 itemCount: sampleDataSousCategorie.length,
                 itemBuilder: (BuildContext context, index) {
                   return InkWell(
                     splashColor: Colors.blueAccent,
                     onTap: () {
                       setState(() {
                         sampleDataSousCategorie.forEach(
                                 (element) => element.isSelected = false);
                         sampleDataSousCategorie[index].isSelected = true;
                         sousCategorie=sampleDataSousCategorie[index].text;
                       });
                     },
                     child: new RadioItemGenre(sampleDataSousCategorie[index]),
                   );
                 },
                 staggeredTileBuilder: (_) => StaggeredTile.  fit(2),
                 mainAxisSpacing: 0.0,
                 crossAxisSpacing: 10.0,
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
               ),
             ),
             Container(
                height: longueurPerCent(200, context),
                child:  StaggeredGridView.countBuilder(
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
                          taille=sampleData[index].buttonText;
                        });
                      },
                      child: new RadioItem(sampleData[index]),
                    );
                  },
                  staggeredTileBuilder: (_) => StaggeredTile.  fit(2),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
              SizedBox(height: longueurPerCent(10, context),),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: TextField(
                          controller: _prixMinController,
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
                          controller: _prixMaxController,
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
              ),
              SizedBox(
                height: longueurPerCent(10, context),
              ),
              (loadingSearch==false)? displaySearchResult():Center(child: CircularProgressIndicator(),),
              SizedBox(
                height: longueurPerCent(200, context),
              ),
            ],
          ):CircularProgressIndicator()
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
            {
              getGenreAndPriceAndSize(genre, prixMax, prixMin, taille);// good
            }
            else if(genre!=null && taille!=null &&  sousCategorie!=null && prixMax!=null && prixMin!=null)
              getGenreAndPriceAndSizeAndCategorie(genre, taille, sousCategorie, prixMax, prixMin); // good

            // categorie search
            else if (sousCategorie != null && genre == null && prixMax==null && prixMin==null && taille==null){
              getCategorieOnly(sousCategorie);// good
            }
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
            else if(prixMax==null && prixMin==null && taille!=null && genre==null && sousCategorie==null) {
              getSizeOnly();// good
            }
            else if(prixMax==null && prixMin==null && taille==null && genre==null && sousCategorie==null)
              setState(() {
                data=null;
                loadingSearch=false;
                noData="VOUS N'AVEZ EFFECTUÉ AUCUNE RECHERCHE";
              });
            setState(() {
              prixMax=null;
              prixMin=null;
              _prixMaxController.text="";
              _prixMinController.text="";
              sousCategorie=null;
              sizeChekbox = false;
              prix = false;
              taille = null;
              genre = null;
              sampleData.forEach((element) {
                setState(() {
                  element.isSelected=false;
                });
              });
              sampleDataGenre.forEach((element) {
                setState(() {
                  element.isSelected=false;
                });
              });
              sampleDataSousCategorie.forEach((element) {
                setState(() {
                  element.isSelected=false;
                });
              });
            });
          },
          child: Icon(Icons.search, color: Colors.white,),
          backgroundColor: Theme.of(context).primaryColor
      ),
    );
  }

  // -----------------------------------------------
  // Creates a list of RangeSliders, based on their
  // definition and SliderTheme customizations
  // -----------------------------------------------
  /* List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        // adapt the RangeSlider lowerValue and upperValue
        setState(() {
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
        });
      }));
      // Add an extra padding at the bottom of each RangeSlider
      children.add(SizedBox(height: 8.0));
    }

    return children;
  }*/

  // -------------------------------------------------
  // Creates a list of RangeSlider definitions
  // -------------------------------------------------
  /*List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0.0,
          max: 500000.0,
          lowerValue: 10.0,
          upperValue: 1000.0,
          showValueIndicator: true,
          valueIndicatorMaxDecimals: 0,
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.red[50],
          valueIndicatorColor: Colors.green),

    ];
  }*/

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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
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
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
      }
    });
  }

  void getSizeOnly() {
    Firestore.instance.collection("TousLesProduits").where("taille", isEqualTo: taille).getDocuments().then((value){
      if(value.documents.isNotEmpty){
        value.documents.forEach((element) {
          if(this.mounted)
            setState(() {
            data.add(element.data);
            loadingSearch = false;

          });
        });
      } else {
        displaySnackBarNom(context, "AUCUN ELEMENT NE CORRESPOND À VOTRE RECHERCHE", Colors.white);
        if(this.mounted)
          setState(() {
            loadingSearch = false;
          });
      }
    });
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 13)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  // ignore: missing_return
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
                          child: CachedNetworkImage(
                            imageUrl: data[index]["image1"],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => LinearProgressIndicator(backgroundColor:HexColor("EFD807"),
                            ),
                          ),
                         ),
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
    else if(noData!=null && loadingSearch==false && data==null)
      return Center(child: Text(noData),);
    else if(loadingSearch==false && emptySearch!=null && data==null && noData==null)
      return Center(child: Text(emptySearch),);
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
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
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
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
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
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 30.0,
            width: 30.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 15.0)),
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
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
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
// ---------------------------------------------------
// Helper class aimed at simplifying the way to
// automate the creation of a series of RangeSliders,
// based on various parameters
//
// This class is to be used to demonstrate the appearance
// customization of the RangeSliders
// ---------------------------------------------------
/*class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = const Color(0xFF0175c2);
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0x8a0175c2);
  static const Color defaultThumbColor = const Color(0xFF0175c2);
  static const Color defaultValueIndicatorColor = const Color(0xFF0175c2);
  static const Color defaultOverlayColor = const Color(0x290175c2);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 500,
    this.forceValueIndicator: true,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  // Returns the values in text format, with the number
  // of decimals, limited to the valueIndicatedMaxDecimals
  //
  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

// Builds a RangeSlider and customizes the theme
// based on parameters
//
Widget build(BuildContext context, frs.RangeSliderCallback callback) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minWidth: 70.0,
              maxWidth: 70.0,
            ),
            child: Text(lowerValueText),
          ),
          Expanded(

            child: Container(
              margin: EdgeInsets.only(top: 60,),
              child: SliderTheme(
                // Customization of the SliderTheme
                // based on individual definitions
                // (see rangeSliders in _RangeSliderSampleState)
                data: SliderTheme.of(context).copyWith(
                  overlayColor: overlayColor,
                  activeTickMarkColor: activeTickMarkColor,
                  activeTrackColor: activeTrackColor,
                  inactiveTrackColor: inactiveTrackColor,
                  //trackHeight: 8.0,
                  thumbColor: thumbColor,
                  valueIndicatorColor: valueIndicatorColor,
                  showValueIndicator: showValueIndicator
                      ? ShowValueIndicator.always
                      : ShowValueIndicator.onlyForDiscrete,
                ),
                child: frs.RangeSlider(
                  min: min,
                  max: max,
                  lowerValue: lowerValue,
                  upperValue: upperValue,
                  divisions: 500,
                  showValueIndicator: showValueIndicator,
                  valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                  onChanged: (double lower, double upper) {
                    // call
                    callback(lower, upper);
                  },
                ),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 100.0,
              maxWidth: 100.0,
            ),
            child: Text(upperValueText + " F CFA"),
          ),
        ],
      ),
    );
  }
}*/