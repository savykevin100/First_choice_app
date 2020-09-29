import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:premierchoixapp/Authentification/connexion.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Design/Mensuration.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';
import 'package:premierchoixapp/Navigations_pages/APrpos.dart';
import 'package:premierchoixapp/Navigations_pages/ConditionsGenerales.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import 'package:premierchoixapp/Navigations_pages/chat.dart';
import 'package:premierchoixapp/Navigations_pages/mes_commandes.dart';
import 'package:premierchoixapp/Navigations_pages/profile.dart';
import 'hexadecimal.dart';

// ignore: must_be_immutable
class ProfileSettings extends StatefulWidget {
  // final Widget creationHeader;
  //  ProfileSettings({this.creationHeader});
  String userCurrent;
  String firstLetter;
  ProfileSettings({this.userCurrent, this.firstLetter});

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _auth = FirebaseAuth.instance;
  Utilisateur donneesUtilisateurConnecte;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          creationHeader(widget.userCurrent),
          drawerItem(
              icon: Icons.home,
              text: "Accueil",
              onTap: () {
                Navigator.pushNamed(context, AllNavigationPage.id);
              }),
          drawerItem(
              icon: Icons.person,
              text: "Mon compte",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => UserProfil()));
              }),
          drawerItem(
              icon: Icons.local_grocery_store,
              text: "Mes commandes",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MesCommandes()));
              }),
          drawerItem(
              icon: Icons.description,
              text: "Tableau Mensurations",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Mensuration()));
              }),
          drawerItem(
              icon: Icons.local_gas_station,
              text: "Deconnexion",
              onTap: () async {
                await _auth.signOut();
                print("Reussie");
                Navigator.pushNamed(context, Connexion.id);
              }),
          drawerItem(
              icon: Icons.share,
              text: "Partager l'application",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              }),
          Divider(),
         drawerItem(
              icon: Icons.library_books,
              text: "Conditions Générales",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ConditionGenerales()));
              }),
         drawerItem(
              icon: Icons.info,
              text: "À propos",
              onTap: () {

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => APrpos()));
              }),
        ],
      ),
    );
  }

  Widget creationHeader(String currentUser) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: HexColor('#001C36'),
      ),
      otherAccountsPictures: <Widget>[],
      accountName: StreamBuilder(
          stream:  FirestoreService().getUtilisateurs(),
          builder: (BuildContext context, AsyncSnapshot<List<Utilisateur>> snapshot) {
            if(snapshot.hasError || !snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              for(int i=0; i<snapshot.data.length; i++) {
                Utilisateur utilisateur = snapshot.data[i];
                if(utilisateur.email == currentUser) {
                  donneesUtilisateurConnecte = utilisateur;
                }
              }

              return Text("${donneesUtilisateurConnecte.nomComplet}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold));
            }
          }
      ),
      accountEmail: Text(currentUser, style: TextStyle(fontSize: 15)),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: Text(
            widget.firstLetter,
            style: TextStyle(color: HexColor("#001c36"), fontSize: 50,fontWeight: FontWeight.bold),
          ),
        ),),
    );
  }

  Widget drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                  color: HexColor('#001C36'),
                  fontSize: 18.0,
                  fontFamily: 'Regular'),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
