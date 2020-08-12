import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/InfoCategories.dart';
import 'package:premierchoixapp/Navigations_pages/produits_categorie.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  ScrollController controller = ScrollController();
  bool val = false;
  int ajoutPanier;
  int nombre;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombre=1;
  }

  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Menu",
        context: context,
        controller: controller,
        nbAjoutPanier: ajoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      drawer: ProfileSettings(userCurrent: Renseignements.emailUser),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                    left: largeurPerCent(6, context),right: largeurPerCent(6, context),top: longueurPerCent(10, context),bottom: longueurPerCent(20, context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: HexColor("#DDDDDD"),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding:
                      EdgeInsets.only(left: largeurPerCent(90, context)),
                      child: Icon(Icons.search, color: HexColor('#9B9B9B')),
                    ),
                    labelText: "Rechercher un produit",
                    labelStyle: TextStyle(
                        color: HexColor('#9B9B9B'),
                        fontSize: 17.0,
                        fontFamily: 'MonseraLight'),
                    contentPadding: EdgeInsets.only(
                      top: 10,
                      bottom: 5,
                    ),
                  ),
                )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: largeurPerCent(10, context)),
                    child: Text(
                      "HOMMES",
                      style: TextStyle(
                          color: HexColor("#FFC30D"),
                          fontFamily: "MonseraBold",
                          fontSize: 18),
                    ),
                  ),
                  LiteRollingSwitch(
                    //initial value
                    value: val,
                    textOn: '',
                    textOff: '',
                    colorOn: Colors.pink,
                    colorOff: HexColor("#FFC30D"),
                    iconOn: Icons.account_circle,
                    iconOff: Icons.account_circle,
                    textSize: 16.0,
                    animationDuration: Duration(milliseconds: 1),
                    onChanged: (bool state) {
                      val=state;
                    },
                    onTap: (){
                      if(nombre==0)setState(() {
                        nombre++;
                      });
                      else setState(() {
                        nombre--;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: largeurPerCent(10, context)),
                    child: Text(
                      "FEMMES",
                      style: TextStyle(
                          color: Colors.pink,
                          fontFamily: "MonseraBold",
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: longueurPerCent(30, context),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: longueurPerCent(20, context),
                  left: largeurPerCent(10, context),
                  bottom: longueurPerCent(20, context)),
              child: Text(
                "Catégories",
                style: TextStyle(
                    color: HexColor("#001C36"),
                    fontSize: 20,
                    fontFamily: "MonseraBold"),
              ),
            ),
            SizedBox(height: longueurPerCent(5, context)),
              (nombre==0)?Padding(
              padding:EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                  stream: FirestoreService().getCategoriesHF("Femmes"),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<InfoCategories>> snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          InfoCategories categories = snapshot.data[index];
                          return  GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         ProduitsCategorie(categories.nomCategorie, "Femmes")));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image:NetworkImage(categories.imagePath,
                                        ),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0.0),
                                            Colors.black.withOpacity(0.8),
                                          ],
                                          stops: [
                                            0.0,
                                            1.0
                                          ])),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 140),
                                    child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 300
                                        ),
                                        child: Text(categories.nomCategorie, style: TextStyle(color:Colors.white, fontSize: 20,fontFamily: "MonseraBold"),)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 10.0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    }
                  }),
            ):Padding(
                padding:EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder(
                    stream: FirestoreService().getCategoriesHF("Hommes"),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<InfoCategories>> snapshot) {
                      if (snapshot.hasError || !snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return StaggeredGridView.countBuilder(
                          crossAxisCount: 4,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            InfoCategories categories = snapshot.data[index];
                            return  GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProduitsCategorie(categories.nomCategorie, "Hommes")));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image:NetworkImage(categories.imagePath,
                                          ),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 180.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        gradient: LinearGradient(
                                            begin: FractionalOffset.topCenter,
                                            end: FractionalOffset.bottomCenter,
                                            colors: [
                                              Colors.grey.withOpacity(0.0),
                                              Colors.black.withOpacity(0.8),
                                            ],
                                            stops: [
                                              0.0,
                                              1.0
                                            ])),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 140),
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: 300
                                          ),
                                          child: Text(categories.nomCategorie, style: TextStyle(color:Colors.white, fontSize: 20,fontFamily: "MonseraBold"),)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 10.0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        );
                      }
                    }),
              )
          ],
        ),
      ),
    );
  }

/*  */
}
