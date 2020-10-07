import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/InfoCategories.dart';
import 'package:premierchoixapp/Navigations_pages/produits_categorie.dart';
import 'package:premierchoixapp/Pages/search_filtre.dart';

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


  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle(fontFamily: "MonseraBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("Non", style: TextStyle(fontFamily: "MonseraBold"),)
          ),
          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("Oui", style: TextStyle(fontFamily: "MonseraBold"),)
          ),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }





  @override
  Widget build(BuildContext context) {
    AppBarClasse _appBar = AppBarClasse(
        titre: "Notifications",
        context: context,
        controller: controller,
        nbAjoutPanier: ajoutPanier);
    return Scaffold(
      appBar: _appBar.appBarFunctionStream(),
      drawer: ProfileSettings(
          userCurrent: Renseignements.userData[1],
          firstLetter:Renseignements.userData[2][0]
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: ConnexionState(body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: longueurPerCent(20, context),),
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
                      animationDuration: Duration(milliseconds: 3),
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
                        "FEMME",
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
                    stream: FirestoreService().getSousCategoriesNoms("Femmes"),
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
                                    ),
                                    child:  CachedNetworkImage(
                                      imageUrl: categories.imagePath,
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
                                    //FadeInImage(placeholder: AssetImage("assets/images/no_image_icon.png"), image: NetworkImage(categories.imagePath), fit: BoxFit.cover,),
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
                                      padding: EdgeInsets.only(top: 140,bottom: longueurPerCent(10, context)),
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: 300
                                          ),
                                          child: Text(categories.nomCategorie, style: TextStyle(color:Colors.white, fontSize: 15,fontFamily: "MonseraBold"),)),
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
                    stream: FirestoreService().getSousCategoriesNoms("Hommes"),
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
                                    ),
                                    child:  CachedNetworkImage(
                                      imageUrl: categories.imagePath,
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
                                    //FadeInImage(placeholder: AssetImage("assets/images/no_image_icon.png"), image: NetworkImage(categories.imagePath), fit: BoxFit.cover,),
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
                                      padding: EdgeInsets.only(top: 140,bottom: longueurPerCent(10, context)),
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: 300
                                          ),
                                          child: Text(categories.nomCategorie, style: TextStyle(color:Colors.white, fontSize: 15,fontFamily: "MonseraBold"),)),
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
        ),),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchFiltre()));
          },
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: Theme.of(context).primaryColor),
    );
  }

/*  */
}