import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/panier.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';



// ignore: must_be_immutable
class AppBarClasse extends StatefulWidget{
  BuildContext context;
  String titre;
  ScrollController controller = ScrollController();
  int nbAjoutPanier;
   AppBarClasse({this.titre, this.context , this.controller});





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }



  Widget appBarFunctionHome(){
    return  ScrollAppBar(
      controller: controller,
      backgroundColor: HexColor("#001c36"),
      title:Image.asset("assets/images/logo.png", height: 100, width: 100,),
      iconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        Badge(
          badgeContent:Text("${Renseignements.nombreAjoutPanier}"),
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
    );
  }
  Widget appBarFunctionStream(){
    return ScrollAppBar(
      controller: controller,
      backgroundColor: HexColor("#001c36"),
      title: Text(
        titre,
        style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        Badge(
          badgeContent:Text("${Renseignements.nombreAjoutPanier}"),
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
    );
  }


}




