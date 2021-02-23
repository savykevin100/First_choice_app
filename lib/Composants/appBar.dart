import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/panier.dart';
import 'package:premierchoixapp/Pages/search_filtre.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';



// ignore: must_be_immutable
class AppBarClasse extends StatefulWidget{
  BuildContext context;
  String titre;
  ScrollController controller = ScrollController();
  int nbAjoutPanier=0;
  AppBarClasse({this.titre, this.context , this.controller, this.nbAjoutPanier});





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }



  Widget appBarFunctionStream(){
    return ScrollAppBar(
      controller: controller,
      backgroundColor:HexColor("#001C36"),
      title: Text(
        titre,
        style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
      ),
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
                      nbAjoutPanier=snapshot.data[i].nbAjoutPanier;
                    }
                  }
                  return (nbAjoutPanier<0)?Text("0"):Text('$nbAjoutPanier');
                }
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
    );
  }


  Widget appBarIosWithoutDrawer( BuildContext context, int  numberProductCard, String pageName){
    return  CupertinoNavigationBar(
      automaticallyImplyLeading: true,
      backgroundColor: HexColor("#001C36"),
      leading: Material(
          color: HexColor("#001C36"),
          child: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30,), onPressed: ()=>Navigator.pop(context))),
      trailing: Material(
        color: HexColor("#001C36"),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchFiltre()));
                }),
            Badge(
              badgeContent: StreamBuilder(
                  stream: FirestoreService().getUtilisateurs(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Utilisateur>> snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Text("");
                    } else {
                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (snapshot.data[i].email ==
                            Renseignements.emailUser) {
                          numberProductCard = snapshot.data[i].nbAjoutPanier;
                        }
                      }
                      return Text("$numberProductCard");
                    }
                  }),
              toAnimate: true,
              position: BadgePosition(top: 0, end: 0),
              child: IconButton(
                  icon: Icon(
                    Icons.local_grocery_store,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Panier()));
                  }),
            )
          ],),
      ),
    );
  }


}

