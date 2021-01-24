import 'dart:io';
import 'dart:typed_data';

import 'package:badges/badges.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Drawer/APrpos.dart';
import 'package:premierchoixapp/Drawer/Commande/mes_commandes.dart';
import 'package:premierchoixapp/Drawer/ConditionsGenerales.dart';
import 'package:premierchoixapp/Drawer/Mensuration.dart';
import 'package:premierchoixapp/Drawer/profile.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/panier.dart';
import 'package:premierchoixapp/Pages/search_filtre.dart';
import 'package:show_drawer/show_drawer.dart';

final _auth = FirebaseAuth.instance;
Widget AppBarIos(BuildContext context,String name, String email, String firstLetter , int numberProductCard, String pageName){
  return CupertinoNavigationBar(
    middle: Image.asset(
      "assets/images/1er choix-02.png",
      height: 100,
      width: 100,
    ),
    leading:
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: Icon(Icons.drag_handle, color: Colors.white,), onPressed: (){
          showDrawer(
            barrier: true,
            context: context,
            direction: DrawerDirection.topLeft,
            barrierDismissible: true,
            builder: (ctx, __, close) => Container(
              width: 300,
              height: MediaQuery.of(context).size.height,
              child: Scaffold(
                body: Container(
                  child: new ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        color: HexColor("#001C36"),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: longueurPerCent(30.0, context) ,),
                            Container(
                              padding: EdgeInsets.only(left:longueurPerCent(20, context)),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Text(
                                    Renseignements.userData[2][0],
                                    style: TextStyle(color: HexColor("#001c36"), fontSize: 50,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                radius: 50,
                              ),
                            ),
                            SizedBox(height: longueurPerCent(10, context)),
                            Container(
                              padding: EdgeInsets.only(left:longueurPerCent(20, context)),
                              child: Text(
                                Renseignements.userData[2],
                                style:TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MontserratBold',
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                            ),

                            SizedBox(height: longueurPerCent(0.0, context)),
                            Container(
                              padding: EdgeInsets.only(left:longueurPerCent(20, context),bottom: longueurPerCent(20, context)),
                              child: Text(
                                Renseignements.emailUser,
                                style:TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Montserrat_Light',
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child:Column(
                          children: <Widget>[
                            drawerItem(
                                icon: Icons.home,
                                text: "Accueil",
                                onTap: close
                            ),
                            drawerItem(
                                icon: Icons.person,
                                text: "Mon compte",
                                onTap: () {
                                  close();
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => UserProfil()));
                                }),
                            drawerItem(
                                icon: Icons.local_grocery_store,
                                text: "Mes commandes",
                                onTap: () {
                                  close();
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) =>MesCommandes()));
                                }),
                            drawerItem(
                                icon: Icons.description,
                                text: "Tableau des Mensurations",
                                onTap: () {
                                  close();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Mensuration()));
                                }),
                            drawerItem(
                                icon: Icons.exit_to_app,
                                text: "Deconnexion",
                                onTap: () async {
                                  close();
                                  await _auth.signOut();
                                  Navigator.pushNamed(context, Connexion.id);
                                }),
                            drawerItem(
                                icon: Icons.share,
                                text: "Partager l'application",
                                onTap: () {
                                  close();
                                  _shareImageFromUrl();

                                }),
                            Divider(),
                            drawerItem(
                                icon: Icons.library_books,
                                text: "Conditions Générales",
                                onTap: () {
                                  close();
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => ConditionGenerales()));
                                }),
                            drawerItem(
                                icon: Icons.info,
                                text: "À propos",
                                onTap: () {
                                  close();
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => APrpos()));
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        Text(pageName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            fontFamily: "MonseraBold"
          ),
        ),
      ],
    ),
    backgroundColor: Theme.of(context).primaryColor,
    trailing: Row(
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
  );

}


Widget drawerItem({IconData icon, String text, Function onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color:HexColor("#FFC30D"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: TextStyle(
              color: HexColor('#001C36'),
              fontSize: 16.0,
            ),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}


Future<void> _shareImageFromUrl() async {
  try {
    var request = await HttpClient().getUrl(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/marketeurfollomme.appspot.com/o/Untitled-2.jpg?alt=media&token=a1cbb03c-1e96-4fb7-b3e3-184f3c387f0e"));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Partager', 'amlog.jpg', bytes, 'image/jpg', text: "Hey! T'as déjà la nouvelle appli tendance de vente de vêtements de friperie? Sinon"
        " Télécharge la shap shap: https://play.google.com/store/apps/details?id=com.followme.premierchoix");
  } catch (e) {
    print('error: $e');
  }

}