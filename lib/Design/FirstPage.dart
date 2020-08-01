import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Authentification/slider.dart';
import 'package:premierchoixapp/Navigations_pages/all_navigation_page.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class FirstPage extends StatefulWidget {
  static String id="FirstPage";
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }


  bool currentUser=false;
  bool ajoue=false;
  List<Map<String, dynamic>> produits=[];
  List<Map<String, dynamic>> produitsFavorisUsers=[];
  String utilisateurConnecte;






  Future<void> obtenirLesProduits() async{
    await Firestore.instance.collection("produit").getDocuments().then((value){
      for(int i=0; i<value.documents.length; i++){
         produits.add(value.documents[i].data);
      }
    });
  }
  void idProduitsFavorisUser(List<Map<String, dynamic>> produit) async{
      try {
        for(int i=0;i<produit.length;i++){
          Firestore.instance.collection("Utilisateurs").document(Renseignements.emailUser).collection("ProduitsFavoirsUser")
          .where("imagePrincipaleProduit", isEqualTo: produit[i]["image1"]).getDocuments().then((QuerySnapshot snapshot){
           /* if(snapshot.documents.isEmpty){
              FirestoreService().addProduitFavorisUser(ProduitsFavorisUser(
                  imagePrincipaleProduit: produit[i]["image1"],
                  imageSelect: produit[i]["image1"],
                  etatIconeFavoris: false
              ), Renseignements.emailUser);
            }*/
          });
        }
      } catch (e){
        print(e);
      }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value){
      if(value!=null){
       setState(() {
         currentUser=true;
         utilisateurConnecte=value.email;
         /// Récupération des produits dans la variable produits qui est une liste de map
        /// obtenirLesProduits();
         /////////////////
         ///Récupération des produits dans produitsFavorisUsers
       /*  Firestore.instance.collection("Utilisateurs").document(value.email).collection("ProduitsFavoirsUser").getDocuments().then((value){
           for(int i=0; i<value.documents.length; i++){
             produitsFavorisUsers.add(value.documents[i].data);
           }
         });*/
         /////////////
         ///Ajout des produits dans produitsFavorisUser; si le produit existe déjà dans produitsFavorisUsers n'ajoute rien dans le cas contraire
         ///ajoute le produit qui n'est pas dans produitsFavorisUser

         ////////////
       });
      }
    });
    StarTimer();
  }

  StarTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }
  
  route (){
    if(currentUser ){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => AllNavigationPage()
      ));
    } else{
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => IntroScreen()
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#001C36"),
      body: new Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(175.0, context),),
                  height: longueurPerCent(227.5, context),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/images/1erchoix01.png",
                    fit: BoxFit.cover,),
                ),
                SizedBox(height: longueurPerCent(50, context),),
                Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),),
                SizedBox(height: longueurPerCent(50, context),),
                Container(
                  margin: EdgeInsets.only(left: longueurPerCent(0, context),top: longueurPerCent(46.0, context),),
                  child: Center(
                    child: Text(
                      "S'habiller n'a jamais été aussi simple",
                      style: TextStyle(color: HexColor("##FFFFFF"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

  }
}