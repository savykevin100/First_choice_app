import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Drawer/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/informations_generales.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/scrollable_products_horizontal.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/panier.dart';
import 'package:premierchoixapp/Pages/search_filtre.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../checkConnexion.dart';


class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  List<String> imagesCarousel=[];
  int nombreAjoutPanier=0;


  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }


  Future<void> getReduction() async {
    await Firestore.instance.collection("Reduction").getDocuments().then((value) {
      value.documents.forEach((element) {
        print(element.data);
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      if(value!=null)
       try{
         Firestore.instance.collection("Utilisateurs").document(value.email).get().then((value) {
           if(this.mounted)
             ajouter([
               value.data["numero"],
               value.data["email"],
               value.data["nomComplet"],
               value.data["age"],
               value.data["sexe"],
             ]);
           Renseignements.emailUser=value.data["email"];
         });
       } catch(e) {
        print(e.toString());
       }
    });
    getReduction();
  }

  @override
  Widget build(BuildContext context) {
    return (Renseignements.userData!=null)?Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      appBar:ScrollAppBar(
        controller: controller,
        backgroundColor: HexColor("#001c36"),
        title:Image.asset("assets/images/1er choix-02.png", height: 100, width: 100,),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Badge(
            badgeContent:StreamBuilder(
                stream: FirestoreService().getUtilisateurs(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Utilisateur>> snapshot) {
                  if(snapshot.hasError || !snapshot.hasData){
                    return Text("0");
                  } else {
                    for(int i=0; i<snapshot.data.length; i++){
                      if(snapshot.data[i].email == Renseignements.emailUser){
                        nombreAjoutPanier=snapshot.data[i].nbAjoutPanier;
                      }
                    }
                    return Text((nombreAjoutPanier==0)?"0":nombreAjoutPanier);}
                }
            ),
            toAnimate: true,
            position: BadgePosition(top: 0, end: 0),
            child: IconButton(
                icon: Icon(
                  Icons.local_grocery_store,
                  color: Colors.white,
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Panier  ()));
                }),
          )

        ],
      ),
      drawer: (Renseignements.userData.length==5)?ProfileSettings(
          userCurrent: Renseignements.userData[1],
          firstLetter:Renseignements.userData[2][0]
      ):ProfileSettings(
        userCurrent: "",
        firstLetter: "",
      ),
      body: WillPopScope(
          onWillPop: _onBackPressed,
          child:  Test(displayContains: bodyAccueil(),)
      ),
      floatingActionButton: FloatingButton(
        displayContains: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchFiltre ()));
            },
            child: Icon(
              Icons.search,
              color:Colors.white,
              size: 30,
            ),
            backgroundColor: Theme.of(context).primaryColor
        ),
      )
    ):Scaffold(
        appBar: AppBar(
          title:Image.asset("assets/images/1er choix-02.png", height: 100, width: 100,),
        ),
        drawer: Drawer(),
        body: Test(
          displayContains: Center(child: CircularProgressIndicator(),),));
  }

  Snap bodyAccueil(){
    return Snap(
      controller: controller.appBar,
      child: ListView(controller: controller, children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: longueurPerCent(200, context),
          decoration: BoxDecoration(
            color: HexColor("#001C36"),
          ),
          child: Carousel(
            boxFit: BoxFit.cover,
            autoplay: true,
            animationCurve: Curves.linearToEaseOut,
            animationDuration: Duration(seconds: 1),
            dotSize: 10.0,
            dotIncreasedColor: Colors.amber,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            indicatorBgPadding: 7.0,
            dotBgColor: Colors.red.withOpacity(0),
            images: [
              StreamBuilder(
                  stream: FirestoreService().getImageCaroussel(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<InformationsGenerales>> snapshot) {
                    if(snapshot.hasError || !snapshot.hasData)
                      return Center(child:CircularProgressIndicator());
                    else {
                      return CachedNetworkImage(
                        imageUrl: snapshot.data[0].image1,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>  CircularProgressIndicator()
                      );
                    }
                  }
              ),
              StreamBuilder(
                  stream: FirestoreService().getImageCaroussel(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<InformationsGenerales>> snapshot) {
                    if(snapshot.hasError || !snapshot.hasData)
                      return Center(child:CircularProgressIndicator());
                    else {
                      return CachedNetworkImage(
                        imageUrl: snapshot.data[0].image2,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>  CircularProgressIndicator()
                      );
                    }
                  }
              ),
              StreamBuilder(
                  stream: FirestoreService().getImageCaroussel(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<InformationsGenerales>> snapshot) {
                    if(snapshot.hasError || !snapshot.hasData)
                      return Center(child:CircularProgressIndicator());
                    else {
                      return CachedNetworkImage(
                        imageUrl: snapshot.data[0].image3,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator()
                      );
                    }
                  }
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: longueurPerCent(30, context),
              left: largeurPerCent(13, context)),
          child: Text(
            "Produits recommandés",
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 20,
                fontFamily: "MonseraBold"),
          ),
        ),
        SizedBox(
          height: longueurPerCent(16, context),
        ),
        Container(
            height: longueurPerCent(220, context),
            child:scrollabe_products_horizontal(FirestoreService().getProduitRecommandes(),)),
        Padding(
          padding: EdgeInsets.only(
              top: longueurPerCent(18, context),
              left: largeurPerCent(13, context)),
          child: Text(
            "Découvrir",
            style: TextStyle(
                color: HexColor("#001C36"),
                fontSize: 20,
                fontFamily: "MonseraBold"),
          ),
        ),
        SizedBox(
          height: longueurPerCent(18, context),
        ),

        //display all the products
        product_grid_view(FirestoreService().getTousLesProduits()),
        SizedBox(
          height: longueurPerCent(18, context),

        ),
      ]),
    );
  }


  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle( color: HexColor("#001C36"),
            fontSize: 15.0,
            fontFamily: "MonseraBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NON", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),

          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("OUI", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }


  String key = "email_user";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> liste = sharedPreferences.getStringList(key);
    if (liste != null) {
      setState(() {
        Renseignements.userData = liste;
      });
    }
  }

  /* Fin de la fonction */

  /* Cette fonction permet d'ajouter les informations*/

  Future<void> ajouter(List<String> str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.userData = str;
    await sharedPreferences.setStringList(key, Renseignements.userData);
    obtenir();
  }
}