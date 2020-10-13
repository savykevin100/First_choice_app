import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/appBar.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/connexion_state.dart';
import 'package:premierchoixapp/Composants/firestore_service.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/priceWithDot.dart';
import 'package:premierchoixapp/Composants/databaseClient.dart';
import 'package:premierchoixapp/Models/panier_classe_sqflite.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Models/produits_favoris_user.dart';
import 'package:photo_view/photo_view.dart';
import 'Panier1.dart';


// ignore: must_be_immutable
class ArticleSansTaille extends StatefulWidget {
  Produit produit;
  String currentUserId;




  ArticleSansTaille(this.produit, this.currentUserId,);


  @override
  _ArticleSansTailleState createState() => _ArticleSansTailleState();
}

class _ArticleSansTailleState extends State<ArticleSansTaille> {

  int index = 1;
  Firestore _db = Firestore.instance;
  // ignore: non_constant_identifier_names
  String id_produit;
  int quantite;
  bool etatIconeFavoris;
  String idFavorisProduit;
  int ajoutPanier=0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool chargement=false;
  String imageSelect;
  bool imageSelector1=true;
  bool imageSelector2=false;
  bool imageSelector3=false;
  bool existInCard = false ;


  // Table qui contient les éléments du panier
  List<PanierClasseSqflite> panierItems = [];

  void fetchDataInPanier(){
    DatabaseClient().readPanierData().then((value) {
      setState(() {
        panierItems=value;
      });
    });
  }




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
          if (snapshot.documents[i].data["image1"] ==widget.produit.image1) {
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
    setState(() {
      imageSelect = widget.produit.image1;
    });
    getNombreProduitPanier();
    fetchDataInPanier();

  }

  ScrollController controller = ScrollController();




  @override
  Widget build(BuildContext context) {

    AppBarClasse _appBar = AppBarClasse(
      titre: "Article", context: context, controller: controller,);
    getIdFavoris();
    getIdProduitFavorisUser();
    return  Scaffold(
        backgroundColor: HexColor("#F5F5F5"),
        key: _scaffoldKey,
        appBar: _appBar.appBarFunctionStream(),
        body: ConnexionState(body: (panierItems!=null)?ListView(
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
                            child: PriceWithDot(price: widget.produit.prix, couleur: HexColor("#00CC7b"), police: "MonseraBold", size: 20,)),
                        Padding(
                          padding:  EdgeInsets.only(left: largeurPerCent(5, context), bottom: longueurPerCent(5, context)),
                          child: RatingBar(
                            initialRating: widget.produit.numberStar.ceilToDouble(),
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
                  child: InkWell(
                    onTap: (){
                      /////////////// Test .........................................
                      print(panierItems.length);
                      panierItems.forEach((element) {
                        if(element.image1 == widget.produit.image1){
                          setState(() {
                            print("trouvé");
                            existInCard = true;
                          });
                        }
                      });

                      if(existInCard==true)
                        displaySnackBarNom(context, "Le produit est déjà ajouté au panier", Colors.white);
                      else {


                        setState(() {
                          ajoutPanier=ajoutPanier+1;
                        });

                        _db
                            .collection("Utilisateurs")
                            .document(Renseignements.emailUser)
                            .updateData({"nbAjoutPanier": ajoutPanier});

                        Map<String, dynamic> map = {
                          "nomDuProduit": widget.produit.nomDuProduit,
                          "image1": widget.produit.image1,
                          "prix": widget.produit.prix,
                          "reference": widget.produit.reference,
                          "numberStar": widget.produit.numberStar,
                          "categorie": widget.produit.categorie,
                          "sousCategorie": widget.produit.sousCategorie,
                          "taille": widget.produit.taille,
                          "idProduitCategorie": widget.produit.idProduitCategorie,
                          "description": widget.produit.description,
                        };

                        PanierClasseSqflite panierClasseSqflite = PanierClasseSqflite();
                        panierClasseSqflite.fromMap(map);
                        DatabaseClient().insertPanier(panierClasseSqflite);
                        fetchDataInPanier();


                        displaySnackBarNom(context, "Produit ajouté au panier", Colors.white);
                      }

                      ////////////////////////////////////////////////
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
              ],
            ),
            (id_produit!=null && etatIconeFavoris!=null)? mainImage():Center(child: CircularProgressIndicator()),
            SizedBox(height: longueurPerCent(20, context),),
            Padding(
              padding:  EdgeInsets.only(left: largeurPerCent(10, context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Taille :", style: TextStyle(color: HexColor("#001c36"), fontSize: 15,fontFamily: "MonseraBold")),
                      SizedBox(width: largeurPerCent(4, context),),
                      (widget.produit.taille!=null)?Expanded(flex:0,child: Text("${widget.produit.taille}", style: TextStyle(color: HexColor("#001c36"), fontSize: 15,fontFamily: "MonseraLight"))):
                      Expanded(flex:0,child: Text("Par défaut", style: TextStyle(color: HexColor("#001c36"), fontSize: 15,fontFamily: "MonseraLight"), ))

                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        if(id_produit!=null && etatIconeFavoris!=null){
                          if(etatIconeFavoris == false){
                            setState(() {
                              displaySnackBarNom(context, "Produit ajouté aux favoris", Colors.white);
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
                              displaySnackBarNom(context, "Produit supprimé des favoris", Colors.white);
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
                      child: (id_produit!=null && etatIconeFavoris!=null)?Padding(
                        padding: EdgeInsets.only(right: largeurPerCent(50, context)),
                        child: (Icon((etatIconeFavoris == false)?Icons.favorite_border:Icons.favorite, color: Colors.red, size:30,)),
                      ):CircularProgressIndicator())
                ],
              ),
            ),
            SizedBox(height: longueurPerCent(10, context),),
            Padding(
              padding:  EdgeInsets.only(left: largeurPerCent(10, context), bottom: longueurPerCent(10, context)),
              child: Text("Descriptif :",
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
                    color: HexColor("#001C36"),
                    fontFamily: "MonseraLight",
                    fontSize: 15) ),
              ),
            ),

          ],
        ): Center(child: CircularProgressIndicator())),

        floatingActionButton: Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height - 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: largeurPerCent(20, context),),
                InkWell(
                  onTap: () async => await _shareImageFromUrl(),
                  child: Padding(
                    padding:  EdgeInsets.only(left: largeurPerCent(15, context),right: largeurPerCent(5, context),),
                    child: Container(
                      height: longueurPerCent(38, context),
                      width: largeurPerCent(160, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: HexColor('#001C36'),
                      ),
                      child: Center(
                          child: (chargement==false)?Text(
                            "RECOMMANDER",
                            style: TextStyle(
                                color: HexColor('#FFFFFF'),
                                fontFamily: "MonseraBold",
                                fontSize: 11),
                          ):CircularProgressIndicator(backgroundColor: Colors.white,)
                      ),
                    ),
                  ),
                ),
                SizedBox(width: largeurPerCent(20, context),),
                InkWell(
                  onTap: () {
                    _db.collection("ProduitsIndisponibles").where("image1", isEqualTo: widget.produit.image1).getDocuments().then((value){
                      if(value.documents.isNotEmpty){
                        displaySnackBarNom(context, "Ce produit est indiponible pour le moment", Colors.white);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Panier1(total: widget.produit.prix , produitsPanier: [widget.produit.toMap()],)));
                      }
                    });
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(left: largeurPerCent(10, context),right: largeurPerCent(15, context)),
                    child: Container(
                      height: longueurPerCent(38, context),
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
              ],
            ),
          ),
        )
    );

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

  Widget pressImage(String image, bool indexSelector){
    return  (indexSelector)?Container(
      height: longueurPerCent(70, context),
      width: largeurPerCent(83, context),
      decoration: BoxDecoration(
        border: Border.all(
            width: largeurPerCent(5, context),
            color:  HexColor('#FFC30D')),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => LinearProgressIndicator(backgroundColor:HexColor("EFD807"),
        ),
      ),
    ):Container(
      height: longueurPerCent(70, context),
      width: largeurPerCent(83, context),
      decoration: BoxDecoration(
        border: Border.all(
            width: largeurPerCent(1, context),
            color: Colors.black),
      ),
      child:CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => LinearProgressIndicator(backgroundColor:HexColor("EFD807"),
        ),
      ),
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
      child: Center(child: Image.asset("assets/images/no_image_icon.png", fit: BoxFit.cover,)),
    );
  }



  // ignore: missing_return
  Widget affichageImagesSecondaires(){
    if(widget.produit!=null){
      if(widget.produit.numberImages==1){
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                setState(() {
                  imageSelector1=true;
                  imageSelect = widget.produit.image1;
                });
              },
              child: pressImage(widget.produit.image1,imageSelector1),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            notImage(),
            SizedBox(height: longueurPerCent(20, context),),
            notImage()
          ],
        );
      } else if(widget.produit.numberImages==2 ){
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                setState(() {
                  imageSelector1=true;
                  imageSelector2=false;
                  imageSelect = widget.produit.image1;
                });
              },
              child: pressImage(widget.produit.image1, imageSelector1),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            GestureDetector(
              onTap: (){
                setState(() {
                  imageSelector2=true;
                  imageSelector1=false;
                  imageSelect = widget.produit.image2;
                });
              },
              child: pressImage(widget.produit.image2, imageSelector2),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            notImage()
          ],
        );
        // ignore: unrelated_type_equality_checks
      } else if(widget.produit.numberImages==3){
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                setState(() {
                  imageSelector1=true;
                  imageSelector2=false;
                  imageSelector3=false;
                  imageSelect = widget.produit.image1;
                });
              },
              child: pressImage(widget.produit.image1, imageSelector1),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            GestureDetector(
              onTap: (){
                setState(() {
                  imageSelector2=true;
                  imageSelector1=false;
                  imageSelector3=false;
                  imageSelect = widget.produit.image2;
                });
              },
              child: pressImage(widget.produit.image2, imageSelector2),
            ),
            SizedBox(height: longueurPerCent(20, context),),
            GestureDetector(
              onTap: (){
                setState(() {
                  imageSelector3=true;
                  imageSelector1=false;
                  imageSelector2=false;
                  imageSelect = widget.produit.image3;
                });
              },
              child: pressImage(widget.produit.image3, imageSelector3),
            ),
          ],
        );
      }
    } else Center(child: CircularProgressIndicator());
  }

  Widget mainImage(){
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
                      return Hero(
                        tag: "customBackground",
                        child: Container(
                          height: longueurPerCent(253, context),
                          width: largeurPerCent(262, context),
                          child:GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HeroPhotoViewRouteWrapper(imageProvider:NetworkImage(imageSelect) ,),),);
                            },
                            child: Image.network(
                             imageSelect,
                              fit: BoxFit.cover,
                              loadingBuilder: (context,child, progress){
                                return progress == null?child:LinearProgressIndicator(backgroundColor:HexColor("EFD807"), );
                              },
                            )
                            /*CachedNetworkImage(
                              imageUrl: imageSelect,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => LinearProgressIndicator(backgroundColor:HexColor("EFD807"),
                              ),
                            ),*/
                          ) ,

                        ),
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
      setState(() {
        chargement=true;
      });
      var request = await HttpClient().getUrl(Uri.parse(
          widget.produit.image1));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Partager', 'amlog.jpg', bytes, 'image/jpg', text: 'My optional text.');
      setState(() {
        chargement=false;
      });
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

}
// ignore: must_be_immutable
class HeroPhotoViewRouteWrapper extends StatelessWidget {
  HeroPhotoViewRouteWrapper({
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  Produit produit;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        loadingBuilder: loadingBuilder,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
      ),
    );
  }
}

/*Fin de la fonction */
