import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/products_gried_view.dart';
import 'package:premierchoixapp/Navigations_pages/Widgets/scrollable_products_horizontal.dart';
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
  AnimationController animationController;
  Animation carouselAnimation;
  int lenght;
  List<Map<String, dynamic>> produitsRecommander = [];
  List<Map<String, dynamic>> tousLesProduits = [];
  DateTime expiryBadgeNew;

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


/* Liste de photos qui contient les images à defiler dans le carousel */
  int photoIndex = 0;
  List<String> photos = [
    'assets/images/gadgets-336635_1920.jpg',
    'assets/images/make-up-1209798_1920.jpg',
    'assets/images/sketchbook-156775_1280.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    animationController =
        AnimationController(duration: Duration(seconds: 18), vsync: this);

    carouselAnimation =
        IntTween(begin: 0, end: photos.length - 1).animate(animationController)
          ..addListener(() {
            setState(() {
              photoIndex = carouselAnimation.value;
            });
          });

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  /*Fin de l'initialisation de la page*/

  Widget carousel() {
    return Stack(
      children: <Widget>[
        Container(
          height: longueurPerCent(200, context),
          //margin: EdgeInsets.only(top: longueurPerCent(0, context)),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(photos[photoIndex]), fit: BoxFit.cover)),
        ),
        Positioned(
          top: longueurPerCent(170.0, context),
          left: longueurPerCent(
              MediaQuery.of(context).size.width * 0.33, context),
          child: SelectedPhoto(
              photoIndex: photoIndex, numberOfDots: photos.length),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (utilisateurConnecte != null ) {
      AppBarClasse _appBar = AppBarClasse(
          titre: "Premier Choix",
          context: context,
          controller: controller,
          nbAjoutPanier: nombreAjoutPanier);
      return Scaffold(
          backgroundColor: HexColor("#F5F5F5"),
          appBar: _appBar.appBarFunctionStream(),
          drawer: ProfileSettings(
            userCurrent: utilisateurConnecte.email,
            firstLetter: utilisateurConnecte.email[0],
          ),
          body: ConnexionState(body: bodyAccueil(),)
      );
    } else {
      return Container(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(),
      );
    }
  }

  Snap bodyAccueil(){
    return Snap(
      controller: controller.appBar,
      child: ListView(controller: controller, children: <Widget>[
        SizedBox(
          height: longueurPerCent(10, context),
        ),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: largeurPerCent(6, context)),
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
                hintText: "Rechercher un produit",
                hintStyle: TextStyle(
                    color: HexColor('#9B9B9B'),
                    fontSize: 17.0,
                    fontFamily: 'MonseraLight'),
                contentPadding: EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                ),
              ),
            )),
        SizedBox(
          height: longueurPerCent(10, context),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: longueurPerCent(200, context),
          decoration: BoxDecoration(
            color: HexColor("#001C36"),
          ),
          child: carousel(),
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

