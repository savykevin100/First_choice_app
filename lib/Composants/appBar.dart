import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Navigations_pages/panier.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';


class AppBarClasse{
  BuildContext context;
  String titre;
  ScrollController controller = ScrollController();
  /*int nbAjoutPanier;

  String currentUserId;*/

  ///AppBarClasse.nb({this.titre, this.nbAjoutPanier, this.context});
  /// AppBarClasse({this.titre, this.context, this.currentUserId, });
   AppBarClasse({this.titre, this.context , this.controller});


  Widget appBarFunction(){
    return ScrollAppBar(
      controller: controller,
      title: Text(
        titre,
        style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
      ),
      backgroundColor: HexColor("#001c36"),
      /// badgeContent: Text("${nbAjoutPanier}"),
      actions: <Widget>[
        Badge(
          badgeContent: Text(""),
          toAnimate: true,
          position: BadgePosition.topRight(top:   0,  right: 0),
          child: IconButton(
              icon: Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Panier()));
              }),
        )

      ],
    );
  }

 /* Widget appBarFunctionStream(){
    return SearchAppBar<String>(
      backgroundColor: HexColor("#001c36"),
      title: Text(
        titre,
        style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
      ),
      searcher: null,
      filter: Filters.startsWith,
      iconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        Badge(
          badgeContent: StreamBuilder(
            stream: FirestoreService().getProduitPanier(Renseignement1.infos_utilisateur_connnecte),
              builder: (BuildContext context,
              AsyncSnapshot<List<PanierClasse>> snapshot) {
               if(snapshot.hasError || !snapshot.hasData){
                 return Text("");
               } else {
               for(int i=0; i<snapshot.data.length; i++) {
                 if(snapshot.data[i].description=="AjoutPanierBadge"){
                   nbAjoutPanier=snapshot.data[i].nombreAjout;
                 }
                }
               return Text("${nbAjoutPanier}");
               }
              }
          ),
          toAnimate: true,
          position: BadgePosition.topRight(top:   0,  right: 0),
          child: IconButton(
              icon: Icon(
                Icons.shopping_basket,
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
  }*/



}




