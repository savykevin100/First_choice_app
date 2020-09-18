import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/scrollable_products_horizontal.dart';
import 'package:premierchoixapp/Navigations_pages/panier.dart';
import 'package:premierchoixapp/Pages/search_filtre.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  final _auth = FirebaseAuth.instance;
  int nombreAjoutPanier;
  FirebaseUser utilisateurConnecte;
  int lenght;
  DateTime expiryBadgeNew;
  List<String> imagesCarousel=[];
  String nameUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          utilisateurConnecte = user;
          ajouter(utilisateurConnecte.email);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchDataUser(String id) async {
    await Firestore.instance
        .collection("Utilisateurs")
        .document(id)
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
          nameUser = value.data["nomComplet"];
        });
      }
    });
  }

  void fetchImageCarousel(){
    Firestore.instance.collection("Informations_générales").document("78k1bDeNwVHCzMy8hMGh").get().then((value) {
     setState(() {
       imagesCarousel.add(value.data["image1"]);
       imagesCarousel.add(value.data["image2"]);
       imagesCarousel.add(value.data["image3"]);
     });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    fetchImageCarousel();

  }

  @override
  Widget build(BuildContext context) {
    if (utilisateurConnecte != null && imagesCarousel.length==3) {
      fetchDataUser(utilisateurConnecte.email);
      return Scaffold(
          backgroundColor: HexColor("#F5F5F5"),
          appBar: ScrollAppBar(
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
                        return Text("");
                      } else {
                        for(int i=0; i<snapshot.data.length; i++){
                          if(snapshot.data[i].email == Renseignements.emailUser){
                            nombreAjoutPanier=snapshot.data[i].nbAjoutPanier;
                          }
                        } 
                        return Text("$nombreAjoutPanier");}
                    }
                ),
                toAnimate: true,
                position: BadgePosition.topRight(top:   0,  right: 0),
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
          drawer: ProfileSettings(
            userCurrent: utilisateurConnecte.email,
            firstLetter:(nameUser!=null)?nameUser[0]:""
          ),
          body: WillPopScope(
              onWillPop: _onBackPressed,
              child: ConnexionState(body: bodyAccueil(),)),
        floatingActionButton: FloatingActionButton(
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
      );

    } else {
      return Scaffold(
        appBar:  ScrollAppBar(
          controller: controller,
          backgroundColor: HexColor("#001c36"),
          title:Image.asset("assets/images/logo.png", height: 30, width: 50,),
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            Badge(
              badgeContent:StreamBuilder(
                  stream: FirestoreService().getUtilisateurs(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Utilisateur>> snapshot) {
                    if(snapshot.hasError || !snapshot.hasData){
                      return Text("");
                    } else {
                      for(int i=0; i<snapshot.data.length; i++){
                        if(snapshot.data[i].email == Renseignements.emailUser){
                          nombreAjoutPanier=snapshot.data[i].nbAjoutPanier;
                        }
                      }
                      return Text("$nombreAjoutPanier");}
                  }
              ),
              toAnimate: true,
              position: BadgePosition.topRight(top:   0,  right: 0),
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
        body:  Center(
          child: CircularProgressIndicator(),
        )
      );
    }
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
            animationDuration: Duration(seconds: 5),
            dotSize: 10.0,
            dotIncreasedColor: Colors.amber,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            indicatorBgPadding: 7.0,
            dotBgColor: Colors.red.withOpacity(0),
            images: [
              Image.network(imagesCarousel[0], fit: BoxFit.cover,),
              Image.network(imagesCarousel[1], fit: BoxFit.cover,),
              Image.network(imagesCarousel[2], fit: BoxFit.cover,),
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
            child:scrollabe_products_horizontal(context,  FirestoreService().getProduitRecommandes(),)),
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



  String key = "email_user";

  /*Cette fonction permet d'obtenir les valeurs à conserver dans le shared_preferences */
  Future<void> obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String liste = sharedPreferences.getString(key);
    if (liste != null) {
      setState(() {
        Renseignements.emailUser = liste;
      });
    }
  }

  /* Fin de la fonction */

  /* Cette fonction permet d'ajouter les informations*/

  Future<void> ajouter(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Renseignements.emailUser = str;
    await sharedPreferences.setString(key, Renseignements.emailUser);
    obtenir();
  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return Center(
      child: new Container(
          child: new Padding(
        padding: const EdgeInsets.only(left: 9.0, right: 9.0),
        child: Container(
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
              color: HexColor('#ffffff'),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      )),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 9.0, right: 9.0),
        child: Container(
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white, spreadRadius: 0.0, blurRadius: 10.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}

