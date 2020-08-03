import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/panier_classe.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';

import 'Panier1.dart';

class ArticleSansTaille extends StatefulWidget {
  Produit produit;
  String currentUserId;

  ArticleSansTaille(this.produit, this.currentUserId);

  @override
  _ArticleSansTailleState createState() => _ArticleSansTailleState();
}

class _ArticleSansTailleState extends State<ArticleSansTaille> {
  //  String imageCliquer = widget.produit.image1;
  int index = 1;
  Firestore _db = Firestore.instance;
  // ignore: non_constant_identifier_names
  String id_produit;
  /// Cette variable permet de contenir l'id du produit affiché au niveau de produitFavorisUser
  int quantite;
  /// afiiche la quantite du produit que le client
  bool etatIconeFavoris;
  /// Variable permettant de changer la couleur de l'icone et la gestion de la couleur
  String idFavorisProduit;
  int ajoutPanier;
  /// Variable contenant le nombre de produit ajouter aux favoris à chaque ajout
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool etatSurMesure=false;
  bool isSwitch=false;

  /*****************************************************************************************/

  ///Cette fonction permet d'obtenir l'id du produit pour permettre la suppression et l'ajout de ce produit dans les favoris
  void getIdFavoris() async {
    await _db
        .collection("Utilisateurs")
        .document(widget.currentUserId) 
        .collection("Favoris")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      if (snapshot.documents.isEmpty) {
      } else {
        for (int i = 0; i < snapshot.documents.length; i++) {
          if (snapshot.documents[i].data["image1"] == widget.produit.image1) {
            if (this.mounted) {
              setState(() {
                idFavorisProduit = snapshot.documents[i].documentID;
              });
            }
          }
        }
      }
    });
  }



  ///Cette fonction permet d'obtenir les informations qui sont dans la collection ProduitsFavorisUser(ce produit a déjà été ajouté dans la collection
  ///ProduitFavorisUser donc on récupère ce produit pour permettre la selection des images, avoir l'état de l'icone Favoris
  void getIdProduitFavorisUser() {
    _db
        .collection("Utilisateurs")
        .document(widget.currentUserId)
        .collection("ProduitsFavoirsUser")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      for (int i = 0; i < snapshot.documents.length; i++) {
        if (snapshot.documents[i].data["imagePrincipaleProduit"] ==
            widget.produit.image1) {
          if (this.mounted) {
            setState(() {
              id_produit = snapshot.documents[i].documentID;
              quantite = snapshot.documents[i].data["quantite"];
              etatIconeFavoris = snapshot.documents[i].data["etatIconeFavoris"];
             /// etatSurMesure = snapshot.documents[i].data["etatSurMesure"];
            });
          }
        }
      }
    });
  }

  ///////////////////////////////////////////////////// fin de la fonction/////////////////////////////////////////////////////////////////////

  /// Cette permet de permet de recuperer le nombre de produit ajouter dans le panier et l'incrémenter si l'utilisateur clique sur le bouton Ajouter au panier
  void getNombreProduitPanier() {
    _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
          ajoutPanier = value.data["nbAjoutPanier"];
        });
      }
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getIdFavoris();
    getIdProduitFavorisUser();
  }

  @override
  void initState() {
    super.initState();
    getNombreProduitPanier();

  }

  ScrollController controller = ScrollController();



  @override
  Widget build(BuildContext context) {

    AppBarClasse _appBar = AppBarClasse(
        titre: "Article", context: context, controller: controller, nbAjoutPanier: ajoutPanier);
    getIdFavoris();
    getIdProduitFavorisUser();
    return  Scaffold(
            key: _scaffoldKey,
            appBar: _appBar.appBarFunctionStream(),
            body: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.only(top: longueurPerCent(20, context), left: largeurPerCent(10, context), bottom: longueurPerCent(10, context)),
                              child: Text(widget.produit.nomDuProduit, style: TextStyle(color: HexColor("#909090"), fontSize: 22),),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: largeurPerCent(10, context), bottom: longueurPerCent(5, context)),
                              child: Text( "${widget.produit.prix} FCFA",
                                  style: TextStyle(
                                      color: HexColor("#001c36"),
                                      fontFamily: "MonseraBold",
                                      fontSize: 20)),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: largeurPerCent(5, context), bottom: longueurPerCent(5, context)),
                              child: RatingBar(
                                initialRating:  widget.produit.numberStar.ceilToDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 3,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 10,
                                ),
                                itemSize: 20,
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                           SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(right: largeurPerCent(17, context), bottom:  longueurPerCent(40, context)),
                      child: GestureDetector(
                        onTap: (){
                          _db .collection("Utilisateurs")
                              .document(widget.currentUserId).collection("Panier").where("image1", isEqualTo: widget.produit.image1)
                              .getDocuments().then((QuerySnapshot snapshot){
                            if(snapshot.documents.isEmpty){
                              displaySnackBarNom(context, "Produit ajouté au panier", Colors.green);
                              setState(() {
                                ajoutPanier++;
                                FirestoreService().addPanierSansId(PanierClasse(
                                    nomDuProduit: widget.produit.nomDuProduit,
                                    image1: widget.produit.image1,
                                    prix: widget.produit.prix,
                                    etatSurMesure: etatSurMesure,
                                    description: widget.produit.description,
                                ), widget.currentUserId, );
                                _db
                                    .collection("Utilisateurs")
                                    .document(widget.currentUserId).collection("Panier")
                                    .document("AjoutPanierBadge")
                                    .updateData({"nombreAjout": ajoutPanier});
                              });
                            }
                          });
                        },
                        child: InkWell(
                          onTap: (){
                            _db .collection("Utilisateurs")
                                .document(widget.currentUserId).collection("Panier").where("image1", isEqualTo: widget.produit.image1)
                                .getDocuments().then((QuerySnapshot snapshot){
                              if(snapshot.documents.isEmpty){
                                displaySnackBarNom(context, "Produit ajouté au panier", Colors.green);
                                setState(() {
                                  ajoutPanier=ajoutPanier+1;
                                  FirestoreService().addPanierSansId(PanierClasse(
                                      nomDuProduit: widget.produit.nomDuProduit,
                                      image1: widget.produit.image1,
                                      prix: widget.produit.prix,
                                      etatSurMesure: etatSurMesure,
                                      description: widget.produit.description,
                                  ), widget.currentUserId, );
                                  _db
                                      .collection("Utilisateurs")
                                      .document(Renseignements.emailUser)
                                      .updateData({"nbAjoutPanier": ajoutPanier});
                                });
                              } else displaySnackBarNom(context, "Produit déjà ajouté au panier", Colors.green);
                            });
                          },
                          child: Column(
                           children: <Widget>[
                              Container(
                               height: longueurPerCent(38, context),
                               width: largeurPerCent(180, context),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7),
                                 color: HexColor("#001C36"),
                               ),
                               child: Center(
                                 child: Text(
                                   "AJOUTER AU PANIER",
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontFamily: "MonseraBold",
                                       fontSize: 11),
                                 ),
                               ),
                             ),
                           ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                (id_produit!=null && etatIconeFavoris!=null)? apparitionImage():Center(child: CircularProgressIndicator()),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding:  EdgeInsets.only(left: largeurPerCent(10, context)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Taille:", style: TextStyle(color: HexColor("#909090"), fontSize: 15, decoration: TextDecoration.underline)),
                          SizedBox(width: largeurPerCent(20, context),),
                          Text("4.3", style: TextStyle(color: HexColor("#001c36"), fontSize: 15) )
                        ],
                      ),
                      SizedBox(width: largeurPerCent(80, context),),
                      Row(
                        children: <Widget>[
                          Text("Couleur", style: TextStyle(color: HexColor("#909090"), fontSize: 15, decoration: TextDecoration.underline)),
                          SizedBox(width: largeurPerCent(20, context),),
                          Text("4.3", style: TextStyle(color: HexColor("#001c36"), fontSize: 15) )
                        ],
                      ),
                      SizedBox(width: largeurPerCent(90, context),),
                      GestureDetector(
                          onTap: () {
                            if(id_produit!=null && etatIconeFavoris!=null){
                              if(etatIconeFavoris == false){
                                setState(() {
                                  displaySnackBarNom(context, "Produit ajouté aux favoris", Colors.green);
                                  print("ajout");
                                  etatIconeFavoris = true;
                                  FirestoreService().addFavoris(widget.produit, Renseignements.emailUser);
                                  _db
                                      .collection("Utilisateurs")
                                      .document(Renseignements.emailUser).collection("ProduitsFavoirsUser")
                                      .document(id_produit)
                                      .updateData({"etatIconeFavoris":etatIconeFavoris});
                                });
                              } else {
                                setState(() {
                                  displaySnackBarNom(context, "Produit supprimé des favoris", Colors.green);
                                  print("supprimer");
                                  etatIconeFavoris = false;
                                  _db
                                      .collection("Utilisateurs")
                                      .document(widget.currentUserId).collection("ProduitsFavoirsUser")
                                      .document(id_produit)
                                      .updateData({"etatIconeFavoris":etatIconeFavoris});
                                  FirestoreService().deleteFavoris(Renseignements.emailUser, idFavorisProduit);
                                });
                              }
                            }
                          },
                          child: (id_produit!=null && etatIconeFavoris!=null)?(Icon((etatIconeFavoris == false)?Icons.favorite_border:Icons.favorite, color: Colors.red, size:30,)):CircularProgressIndicator())
                    ],
                  ),
                ),
                (etatSurMesure!=null)? Padding(padding: EdgeInsets.only(left: largeurPerCent(0, context)), child: Row(
                  children: <Widget>[
                    Checkbox(value: isSwitch, onChanged: (bool value){
                      setState(() {
                        isSwitch=value;
                        etatSurMesure=value;
                        _db
                            .collection("Utilisateurs")
                            .document(widget.currentUserId).collection("ProduitsFavoirsUser")
                            .document(id_produit)
                            .updateData({"etatSurMesure":etatSurMesure});
                      });
                      print(etatSurMesure);
                    }),
                    Text("Voulez-vous du sur-mesure", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),)
                  ],
                ),):Text(""),
                SizedBox(height: longueurPerCent(10, context),),
                Padding(
                  padding:  EdgeInsets.only(left: largeurPerCent(10, context), bottom: longueurPerCent(10, context)),
                  child: Text("Descriptif",
                      style: TextStyle(
                          color: HexColor("#001c36"),
                          fontFamily: "MonseraBold",
                          fontSize: 15)),
                ),
                Padding(padding:  EdgeInsets.only(left: largeurPerCent(10, context)),
                  child:  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width-10,
                    ),
                    child: Text((widget.produit.description==null)?"Pas de descritption":"${widget.produit.description}", style: TextStyle(
                        color: HexColor("#001c36"),
                        fontFamily: "MonseraLight",
                        fontSize: 15) ),
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                Row(
                 children: <Widget>[
                   SizedBox(width: largeurPerCent(20, context),),
                   InkWell(
                     onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) =>
                                   Panier1(total: widget.produit.prix, unSeulProduit: widget.produit,)));
                     },
                     child: Padding(
                       padding:  EdgeInsets.only(left: largeurPerCent(10, context)),
                       child: Container(
                         height: longueurPerCent(37, context),
                         width: largeurPerCent(160, context),
                         decoration: BoxDecoration(
                             color: HexColor('#FFC30D'),
                             border: Border.all(color: HexColor('#FFC30D'), width: 1),
                             borderRadius: BorderRadius.circular(7)),
                         child: Center(
                           child: Text(
                             "ACHETER",
                             style: TextStyle(
                                 color: HexColor('#001C36'),
                                 fontFamily: "MonseraBold",
                                 fontWeight: FontWeight.bold,
                                 fontSize: 11),
                           ),
                         ),
                       ),
                     ),
                   ),
                   SizedBox(width: largeurPerCent(20, context),),
                   InkWell(
                     onTap: () async => await _shareImageFromUrl(),
                     child: Padding(
                       padding:  EdgeInsets.only(left: largeurPerCent(15, context)),
                       child: Container(
                         height: longueurPerCent(38, context),
                         width: largeurPerCent(160, context),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(7),
                           color: HexColor('#001C36'),
                         ),
                         child: Center(
                           child: Text(
                             "RECOMMANDER",
                             style: TextStyle(
                                 color: HexColor('#FFFFFF'),
                                 fontFamily: "MonseraBold",
                                 fontSize: 11),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
                SizedBox(height: longueurPerCent(20, context),),
              ],
            ));
  }

  Stream<List<ProduitsFavorisUser>> getImagesProduct(){
    return  _db.collection("Utilisateurs").document(widget.currentUserId).collection("ProduitsFavoirsUser").snapshots().map(
    (snapshot) => snapshot.documents
        .map(
    (doc) => ProduitsFavorisUser.fromMap(doc.data, doc.documentID),
    )
        .toList(),
    );
  }

  Widget notImage(){
    return  Container(
      height: longueurPerCent(70, context),
      width: largeurPerCent(83, context),
      decoration: BoxDecoration(
          border: Border.all(
              width: largeurPerCent(1, context),
              color: HexColor("#707070")),),
      child: Center(child: Text("Pas d'image"),),
    );
  }

  Widget affichageImagesSecondaires(){
    if(widget.produit.numberImages==1){
     return Column(
         children: <Widget>[
           notImage(),
           notImage(),
           notImage()
         ],
     );
    } else if(widget.produit.numberImages==2){
      return Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _db
                    .collection("Utilisateurs")
                    .document(widget.currentUserId).collection("ProduitsFavoirsUser")
                    .document(id_produit)
                    .updateData({"imageSelect": widget.produit.image1});
                print(widget.produit.selectImage);
              });
            },
            child: Container(
              height: longueurPerCent(70, context),
              width: largeurPerCent(83, context),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: largeurPerCent(1, context),
                      color: HexColor("#707070")),
                  image: DecorationImage(
                      image: NetworkImage(widget.produit.image1),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(height: longueurPerCent(20, context),),

          GestureDetector(
            onTap: () {
              setState(() {
                _db
                    .collection("Utilisateurs")
                    .document(widget.currentUserId).collection("ProduitsFavoirsUser")
                    .document(id_produit)
                    .updateData({"imageSelect": widget.produit.image2});
                print(widget.produit.selectImage);
              });
            },
            child: Container(
              height: longueurPerCent(70, context),
              width: largeurPerCent(83, context),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: largeurPerCent(1, context),
                      color: HexColor("#707070")),
                  image: DecorationImage(
                      image: NetworkImage(widget.produit.image2),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(height: longueurPerCent(20, context),),

          notImage()
        ],
      );
    } else {
     return Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _db
                    .collection("Utilisateurs")
                    .document(widget.currentUserId).collection("ProduitsFavoirsUser")
                    .document(id_produit)
                    .updateData({"imageSelect": widget.produit.image1});
                print(widget.produit.selectImage);
              });
            },
            child: Container(
              height: longueurPerCent(70, context),
              width: largeurPerCent(83, context),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: largeurPerCent(1, context),
                      color: HexColor("#707070")),
                  image: DecorationImage(
                      image: NetworkImage(widget.produit.image1),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(height: longueurPerCent(20, context),),

          GestureDetector(
            onTap: () {
              setState(() {
                _db
                    .collection("Utilisateurs")
                    .document(widget.currentUserId).collection("ProduitsFavoirsUser")
                    .document(id_produit)
                    .updateData({"imageSelect": widget.produit.image2});
                print(widget.produit.selectImage);
              });
            },
            child: Container(
              height: longueurPerCent(70, context),
              width: largeurPerCent(83, context),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: largeurPerCent(1, context),
                      color: HexColor("#707070")),
                  image: DecorationImage(
                      image: NetworkImage(widget.produit.image2),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(height: longueurPerCent(20, context),),

          GestureDetector(
            onTap: () {
              setState(() {
                _db
                    .collection("Utilisateurs")
                    .document(widget.currentUserId).collection("ProduitsFavoirsUser")
                    .document(id_produit)
                    .updateData({"imageSelect": widget.produit.image3});
                print(widget.produit.selectImage);
              });
            },
            child: Container(
              height: longueurPerCent(70, context),
              width: largeurPerCent(83, context),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: largeurPerCent(1, context),
                      color: HexColor("#707070")),
                  image: DecorationImage(
                      image: NetworkImage(widget.produit.image3),
                      fit: BoxFit.cover)),
            ),
          ),
        ],
      );
    }
  }

  Widget apparitionImage(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(left: largeurPerCent(10, context),right: largeurPerCent(40, context)),
            child: StreamBuilder(
              stream: getImagesProduct(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProduitsFavorisUser>> snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(
                      child: null,
                    );
                  } else {
                    for (int i = 0; i < snapshot.data.length; i++) {
                      if (widget.produit.image1 == snapshot.data[i].imagePrincipaleProduit) {
                        ProduitsFavorisUser produit = snapshot.data[i];
                        return Container(
                          height: longueurPerCent(253, context),
                          width: largeurPerCent(262, context),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(produit.imageSelect, ),

                                  fit: BoxFit.cover)),
                        );
                      }
                    }
                    return null;
                  }
                }),
          ),
         affichageImagesSecondaires()
        ],
      );

  }

  Future<void> _shareImageFromUrl() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          widget.produit.image1));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg', text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }


  /// BAR D'AJOUT OU DE SUPPRESSION EN BAS
  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }



  ///Cette fonction permet d'afficher les images secondaires en fonction de leurs nombres
  Widget imageApparition() {
    if (widget.produit.numberImages == 1) {
      return Stack(children: <Widget>[
        Positioned(
          top: longueurPerCent(120, context),
          left: largeurPerCent(40, context),
          child: StreamBuilder(
              stream: _db
                  .collection("Utilisateurs")
                  .document(widget.currentUserId)
                  .collection("ProduitsFavoirsUser")
                  .snapshots()
                  .map(
                    (snapshot) => snapshot.documents
                        .map(
                          (doc) => ProduitsFavorisUser.fromMap(
                              doc.data, doc.documentID),
                        )
                        .toList(),
                  ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProduitsFavorisUser>> snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: null,
                  );
                } else {
                  for (int i = 0; i < snapshot.data.length; i++) {
                    if (widget.produit.image1 ==
                        snapshot.data[i].imagePrincipaleProduit) {
                      ProduitsFavorisUser produit = snapshot.data[i];
                      return Container(
                        height: longueurPerCent(253, context),
                        width: largeurPerCent(300, context),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(produit.imageSelect),
                                fit: BoxFit.cover)),
                      );
                    }
                  }
                  return null;
                }
              }),
        ),
      ]);
    } else if (widget.produit.numberImages == 2) {
      return Stack(children: <Widget>[
        Positioned(
          top: longueurPerCent(120, context),
          left: largeurPerCent(10, context),
          child: StreamBuilder(
              stream: _db
                  .collection("Utilisateurs")
                  .document(widget.currentUserId)
                  .collection("ProduitsFavoirsUser")
                  .snapshots()
                  .map(
                    (snapshot) => snapshot.documents
                        .map(
                          (doc) => ProduitsFavorisUser.fromMap(
                              doc.data, doc.documentID),
                        )
                        .toList(),
                  ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProduitsFavorisUser>> snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: null,
                  );
                } else {
                  for (int i = 0; i < snapshot.data.length; i++) {
                    if (widget.produit.image1 ==
                        snapshot.data[i].imagePrincipaleProduit) {
                      ProduitsFavorisUser produit = snapshot.data[i];
                      return Container(
                        height: longueurPerCent(253, context),
                        width: largeurPerCent(262, context),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(produit.imageSelect),
                                fit: BoxFit.cover)),
                      );
                    }
                  }
                  return null;
                }
              }),
        ),
        Positioned(
          top: longueurPerCent(120, context),
          left: largeurPerCent(320, context),
          child: Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _db
                      .collection("Utilisateurs")
                      .document(widget.currentUserId)
                      .collection("ProduitsFavoirsUser")
                      .document(id_produit)
                      .updateData({"imageSelect": widget.produit.image1});
                  print(widget.produit.selectImage);
                });
              },
              child: Container(
                height: longueurPerCent(61, context),
                width: largeurPerCent(63, context),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: largeurPerCent(2, context),
                        color: HexColor("#707070")),
                    image: DecorationImage(
                        image: NetworkImage(widget.produit.image1),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Positioned(
          top: longueurPerCent(220, context),
          left: largeurPerCent(320, context),
          child: Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print("2");
                  _db
                      .collection("Utilisateurs")
                      .document(widget.currentUserId)
                      .collection("ProduitsFavoirsUser")
                      .document(id_produit)
                      .updateData({"imageSelect": widget.produit.image2});
                  print(widget.produit.selectImage);
                });
              },
              child: Container(
                height: longueurPerCent(61, context),
                width: largeurPerCent(63, context),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: largeurPerCent(2, context),
                        color: HexColor("#707070")),
                    image: DecorationImage(
                        image: NetworkImage(widget.produit.image2),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
      ]);
    } else {
      return ListView(
          children: <Widget>[
        Positioned(
          top: longueurPerCent(120, context),
          left: largeurPerCent(10, context),
          child: StreamBuilder(
              stream: _db
                  .collection("Utilisateurs")
                  .document(widget.currentUserId)
                  .collection("ProduitsFavoirsUser")
                  .snapshots()
                  .map(
                    (snapshot) => snapshot.documents
                        .map(
                          (doc) => ProduitsFavorisUser.fromMap(
                              doc.data, doc.documentID),
                        )
                        .toList(),
                  ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProduitsFavorisUser>> snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: null,
                  );
                } else {
                  for (int i = 0; i < snapshot.data.length; i++) {
                    if (widget.produit.image1 ==
                        snapshot.data[i].imagePrincipaleProduit) {
                      ProduitsFavorisUser produit = snapshot.data[i];
                      return Container(
                        height: longueurPerCent(253, context),
                        width: largeurPerCent(262, context),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(produit.imageSelect),
                                fit: BoxFit.cover)),
                      );
                    }
                  }
                  return null;
                }
              }),
        ),
        Positioned(
          top: longueurPerCent(120, context),
          left: largeurPerCent(320, context),
          child: Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _db
                      .collection("Utilisateurs")
                      .document(widget.currentUserId)
                      .collection("ProduitsFavoirsUser")
                      .document(id_produit)
                      .updateData({"imageSelect": widget.produit.image1});
                  print(widget.produit.selectImage);
                });
              },
              child: Container(
                height: longueurPerCent(61, context),
                width: largeurPerCent(63, context),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: largeurPerCent(2, context),
                        color: HexColor("#707070")),
                    image: DecorationImage(
                        image: NetworkImage(widget.produit.image1),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Positioned(
          top: longueurPerCent(220, context),
          left: largeurPerCent(320, context),
          child: Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print("2");
                  _db
                      .collection("Utilisateurs")
                      .document(widget.currentUserId)
                      .collection("ProduitsFavoirsUser")
                      .document(id_produit)
                      .updateData({"imageSelect": widget.produit.image2});
                  print(widget.produit.selectImage);
                });
              },
              child: Container(
                height: longueurPerCent(61, context),
                width: largeurPerCent(63, context),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: largeurPerCent(2, context),
                        color: HexColor("#707070")),
                    image: DecorationImage(
                        image: NetworkImage(widget.produit.image2),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
        Positioned(
          top: longueurPerCent(310, context),
          left: largeurPerCent(320, context),
          child: Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print("3");
                  _db
                      .collection("Utilisateurs")
                      .document(widget.currentUserId)
                      .collection("ProduitsFavoirsUser")
                      .document(id_produit)
                      .updateData({"imageSelect": widget.produit.image3});
                  print(widget.produit.selectImage);
                });
              },
              child: Container(
                height: longueurPerCent(61, context),
                width: largeurPerCent(63, context),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: largeurPerCent(2, context),
                        color: HexColor("#707070")),
                    image: DecorationImage(
                        image: NetworkImage(widget.produit.image3),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ),
      ]);
    }
  }
}

/*Fin de la fonction */
