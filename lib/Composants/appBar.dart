import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/panier.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';



class AppBarClasse extends StatefulWidget{
  BuildContext context;
  String titre;
  ScrollController controller = ScrollController();
  int nbAjoutPanier;
   AppBarClasse({this.titre, this.context , this.controller, this.nbAjoutPanier});





  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
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
          badgeContent:StreamBuilder(
              stream: FirestoreService().getUtilisateurs(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Utilisateur>> snapshot) {
                if(snapshot.hasError || !snapshot.hasData){
                  return Text("");
                } else {
                  for(int i=0; i<snapshot.data.length; i++){
                    if(snapshot.data[i].email == Renseignements.emailUser){
                      nbAjoutPanier=snapshot.data[i].nbAjoutPanier;
                    }
                  }
                  return Text("${nbAjoutPanier}");}
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
  }


}




