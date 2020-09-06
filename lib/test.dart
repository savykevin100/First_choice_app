import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Test extends StatelessWidget {
  static String id="Test";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Offline Demo"),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: new Text(
                  '${connected ? 'CONNECTEZ!' : "VOUS N'ETES PAS CONNECTER À INTERNET"}',
                ),
              ),
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }
}


/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

import 'Composants/appBar.dart';

class Test extends StatefulWidget {
  static String id = "Test";

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final controller = ScrollController();

  bool isSwitchMan = false;
  bool isSwitchFemale = false;
  bool prix=false;
  bool taille=false;
  int prixMax;
  int prixMin;
  String _dropDownValue2;
  String sousCategorie;
  List<Map<String, dynamic>> data = [];
  int nombreAjoutPanier;
  List<String> selectedSizes = <String>[];
  String _currentCategory;

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: largeurPerCent(20, context)),
                    child: Text("Genre:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                  Checkbox(
                      value: isSwitchFemale,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitchFemale = value;
                        });
                      }),
                  Text("Femmes"),
                  SizedBox(
                    width: longueurPerCent(100, context),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isSwitchMan,
                          onChanged: (bool value) {
                            setState(() {
                              isSwitchMan = value;
                            });
                          }),
                      Text("Hommes")
                    ],
                  ),
                ],
              ),
              SizedBox(height: longueurPerCent(20, context),),
              Center(
                child: Container(
                  width: largeurPerCent(347.0, context),
                  height: longueurPerCent(30, context),
                  padding: EdgeInsets.only(
                      left: largeurPerCent(10, context),
                      right: largeurPerCent(20, context),
                      top: longueurPerCent(0, context)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      ),
                      border: Border.all(color: Colors.grey, width: 1)),
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
                    iconSize: 30.0,
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
              SizedBox(height: longueurPerCent(20, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: largeurPerCent(20, context)),
                    child: Text("Type:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                  Checkbox(
                      value: taille,
                      onChanged: (bool value) {
                        setState(() {
                          taille = value;
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
              (taille)?
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
              ):Text(""),
              SizedBox(height: longueurPerCent(20, context),),
              (prix)?Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    width: largeurPerCent(50, context),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Prix Max",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: largeurPerCent(100, context),),
                  Container(
                    width: largeurPerCent(50, context),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Prix Min",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ):Text(""),
              SizedBox(
                height: longueurPerCent(10, context),
              ),
              (data != null)
                  ? StaggeredGridView.countBuilder(
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
                            onTap: () {},
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
                    )
                  : Text(""),
              SizedBox(height: longueurPerCent(50, context),),
             /* */
            ],
          ),
        ),
      ),
        floatingActionButton:
       Center(
          child: Container(
              margin: EdgeInsets.only(
                  left: longueurPerCent(20, context),  top: MediaQuery
                  .of(context)
                  .size
                  .height - 60),
              child: button(HexColor("#001C36"),  HexColor("#FFC30D"), context, "RECHERCHER", () {
                setState(() {
                  data=[];

                });
                if (isSwitchMan == true && isSwitchFemale==false) {
                  Firestore.instance
                      .collection("Hommes")
                      .document(sousCategorie)
                      .collection("Produits")
                      .getDocuments()
                      .then((value) {
                    value.documents.forEach((element) {
                      setState(() {
                        data.add(element.data);
                      });
                      print(data);
                    });
                  });
                } else if (isSwitchFemale == true && isSwitchMan==false) {
                  Firestore.instance
                      .collection("Femmes")
                      .document(sousCategorie)
                      .collection("Produits")
                      .getDocuments()
                      .then((value) {
                    value.documents.forEach((element) {
                      setState(() {
                        data.add(element.data);
                      });
                      print(data);
                    });
                  });
                }
               setState(() {
                 isSwitchFemale=false;
                 isSwitchMan=false;
                 _dropDownValue2 = null;
               });
              })
          ),
        )
    );
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
}*/

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
