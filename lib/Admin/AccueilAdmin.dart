import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/profileUtilisateur.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Page {dashboard, manage}

class AccueilAdmin extends StatefulWidget {
  static String id = "accueilAdmin";
  @override
  _AccueilAdminState createState() => _AccueilAdminState();
}

class _AccueilAdminState extends State<AccueilAdmin> with SingleTickerProviderStateMixin {
  final controller = ScrollController();
  final _auth = FirebaseAuth.instance;
  FirebaseUser utilisateurConnecte;
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  /*Fin de l'initialisation de la page*/


  @override
  Widget build(BuildContext context) {
    {
      AppBarClasse _appBar = AppBarClasse(
        titre: "Admin",
        context: context,
        controller: controller,
      );
      return Scaffold(
        backgroundColor: HexColor("#F5F5F5"),
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton.icon(onPressed: () {
                  setState(() => _selectedPage = Page.dashboard);
                },
                    icon: Icon(
                      Icons.dashboard,
                      color: _selectedPage == Page.dashboard
                          ? active
                          : notActive,
                    ),
                    label: Text("Dashboard")),
              ),
              Expanded(
                child: FlatButton.icon(onPressed: () {
                  setState(() => _selectedPage = Page.manage);
                }, icon: Icon(
                  Icons.sort,
                  color:
                  _selectedPage == Page.manage ? active : notActive,
                ), label: Text("Manage")),
              )
            ],
          ),
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen(),
      );

    }
  }
  Widget _loadScreen(){
    switch(_selectedPage){
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                onPressed: null,
                icon:Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.green,
                ),
                  label:Text("12.000",
                  textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0, color:Colors.grey),
                  ),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                children: <Widget>[
                  Padding(
                    padding:const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(onPressed: null, icon: Icon(Icons.people_outline),
                            label: Text("Utilisateurs")),
                        subtitle: Text("7",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: active,fontSize: 60.0),),
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(onPressed: null, icon: Icon(Icons.category),
                            label: Text("Catégories")),
                        subtitle: Text("23",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active,fontSize: 60.0),),
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(onPressed: null, icon: Icon(Icons.track_changes),
                            label: Text("Produits")),
                        subtitle: Text("120",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active,fontSize: 60.0),),
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(onPressed: null, icon: Icon(Icons.shopping_cart),
                            label: Text("Commandes")),
                        subtitle: Text("7",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active,fontSize: 60.0),),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading:Icon(Icons.add),
              title: Text("Ajouter un produits"),
              onTap: (){},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title:Text("Listes des produits"),
              onTap: (){},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title:Text("Ajouter de catégorie"),
              onTap: (){},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title:Text("Listes des catégories"),
              onTap: (){},
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}
