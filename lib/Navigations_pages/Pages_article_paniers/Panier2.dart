import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:premierchoixapp/Authentification/components/button_form.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Models/produit.dart';
import 'package:premierchoixapp/Navigations_pages/Pages_article_paniers/commande_send.dart';

class Panier2 extends StatefulWidget {
  static String id = 'Panier2';
  String nomComplet;
  String telephone;
  String lieuDeLivraison;
  String quartier;
  String indication;
  String dateHeureDeLivraison;
  int total;
  int prixLivraison;
  Produit unSeulProduit;
  List<Map<String, dynamic>> produitsCommander;
 String moyenDePayement;
  Panier2(
      {this.unSeulProduit,
      this.prixLivraison,
      this.nomComplet,
      this.total,
      this.telephone,
      this.lieuDeLivraison,
      this.quartier,
      this.indication,
      this.dateHeureDeLivraison,
      this.moyenDePayement,
      this.produitsCommander});

  @override
  _Panier2State createState() => _Panier2State();
}

class _Panier2State extends State<Panier2> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldControllerNumero = TextEditingController();

  bool _isEnabled = true;
  bool _isEnabledPayement = true;


  String numeroDePayement;
  bool chargement = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.moyenDePayement=="Mobile Money"){
      setState(() {
        _isEnabledPayement=false;
      });
    } else {
      setState(() {
        numeroDePayement="61861183";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chargement == false) {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: HexColor("#001c36"),
            title: Text(
              "Panier",
              style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),
            ),
          ),
          body: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: longueurPerCent(20, context),),
                    (widget.lieuDeLivraison=="A domicile")? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(30.0, context)),
                          child: Text(
                            "Adresse de Livraison",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 18,
                                fontFamily: "MonseraBold"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(20.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(30.0, context)),
                          child: Text(
                            widget.quartier + ", " + widget.indication,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 18,
                              fontFamily: "Montserrat_Light",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(30.0, context)),
                          child: Text(
                            "Adresse de l'entreprise",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 18,
                                fontFamily: "Montserrat_Light"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(10.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(25.0, context)),
                          child: Text(
                           "Joncquet en face de la pharmacie. Immeuble à étage, 2ème étage.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 18,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  /*  Container(
                      margin: EdgeInsets.only(
                          top: longueurPerCent(0.0, context),
                          right: longueurPerCent(0.0, context),
                          left: longueurPerCent(25.0, context)),
                      child: Text(
                        " Cotonou",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: HexColor("#001C36"),
                          fontSize: 18,
                          fontFamily: "MontserratBold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),*/
                    SizedBox(height: longueurPerCent(20, context),),
                    Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.1,
                          ),
                        ],
                      ),
                      height: longueurPerCent(5, context),
                      width: largeurPerCent(MediaQuery.of(context).size.width, context),
                    ),
                    SizedBox(height: longueurPerCent(20, context),),
                    Container(
                      margin: EdgeInsets.only(
                          top: longueurPerCent(0.0, context),
                          right: longueurPerCent(0.0, context),
                          left: longueurPerCent(30.0, context)),
                      child: Text(
                        "Moyen de payement",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: HexColor("#001C36"),
                            fontSize: 18,
                            fontFamily: "MonseraBold"),
                      ),
                    ),
                    SizedBox(height: longueurPerCent(15, context),),
                 Container(
                  margin: EdgeInsets.only(
                    left: longueurPerCent(20, context),
                    right: longueurPerCent(20, context),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.0),
                    ),color: HexColor("F5F5F5"),),
                  child: TextField(
                    controller: _textFieldController,
                    //Set this field to enable or disable (true or flase)
                    enabled: !_isEnabled,
                    style: TextStyle(
                        fontSize: 18,
                          fontFamily: "MonseraBold"
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            top: longueurPerCent(5, context),
                            bottom: longueurPerCent(5, context),
                            right: largeurPerCent(10, context),
                            left: largeurPerCent(10, context)),
                        child: Card(
                          child: Container(
                            height: longueurPerCent(40, context),
                              child: Image.asset("assets/images/images-03.png")),
                        ),
                      ),
                      suffixIcon: (widget.moyenDePayement!="Mobile Money")?Padding(
                        padding: EdgeInsets.only(
                            top: longueurPerCent(5, context),
                            bottom: longueurPerCent(5, context),
                            right: largeurPerCent(10, context),
                            left: largeurPerCent(10, context)),
                        child: Container(
                          child: Icon(
                            Icons.check_circle,
                            color: HexColor("#001C36"),
                            size: 30,
                          ),
                        ),
                      ):Text(""),
                      hintText: "Espèce",
                      hintStyle: TextStyle(
                          color:  HexColor("#909090"),
                          fontSize: 16.0,
                          fontFamily: 'MonseraBold'),
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
                      border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(7.0) ),
                          borderSide: BorderSide(width: 0, style: BorderStyle.none)
                      ),
                    ),
                    onChanged: (value){

                    }

                  ),
                ),

                    SizedBox(height: longueurPerCent(10, context),),
                    Container(
                      margin: EdgeInsets.only(
                        left: longueurPerCent(20, context),
                        right: longueurPerCent(20, context),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        ),color: HexColor("F5F5F5"),),
                      child: TextFormField(
                        controller: _textFieldControllerNumero,
                        //Set this field to enable or disable (true or flase)
                        enabled: !_isEnabledPayement,
                        style: TextStyle(
                            fontSize: 16,
                            color: HexColor("#909090"),
                            fontFamily: "MonseraBold"
                        ),
                        decoration: InputDecoration(
                          hintText: "Numéro Mobile Money",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                top: longueurPerCent(5, context),
                                bottom: longueurPerCent(5, context),
                                right: largeurPerCent(10, context),
                                left: largeurPerCent(17, context)),
                            child: Card(
                              child: Container(
                                  height: longueurPerCent(40, context),
                                  child: Image.asset("assets/images/new_logo_mtn_momo1.jpg")),
                            ),
                          ),
                          suffixIcon: (widget.moyenDePayement=="Mobile Money")?Padding(
                            padding: EdgeInsets.only(
                                top: longueurPerCent(5, context),
                                bottom: longueurPerCent(5, context),
                                right: largeurPerCent(10, context),
                                left: largeurPerCent(10, context)),
                            child: Container(
                              child: Icon(
                                Icons.check_circle,
                                color: HexColor("#001C36"),
                                size: 30,
                              ),
                            ),
                          ):Text(""),
                          hintStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                              fontFamily: 'MonseraLight'),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 30, bottom: 5, left:30),
                          border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(7.0) ),
                              borderSide: BorderSide(width: 0, style: BorderStyle.none)
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            numeroDePayement=value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: longueurPerCent(20, context),),
                    Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.1,
                          ),
                        ],
                      ),
                      height: longueurPerCent(5, context),
                      width: largeurPerCent(MediaQuery.of(context).size.width, context),
                    ),
                    SizedBox(height: longueurPerCent(20, context),),
                    Container(
                      margin: EdgeInsets.only(
                          top: longueurPerCent(0.0, context),
                          right: longueurPerCent(0.0, context),
                          left: longueurPerCent(30.0, context)),
                      child: Text(
                        "Résumé",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: HexColor("#001C36"),
                          fontSize: 18,
                          fontFamily: "MonseraBold",
                        ),
                      ),
                    ),
                    SizedBox(height: longueurPerCent(20, context),),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(30.0, context)),
                          child: Text(
                            "SOUS TOTAL",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 18,
                                fontFamily: "Montserrat_Light"),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: largeurPerCent(0, context)),
                            child: Text(
                              "${widget.total}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 16,
                                fontFamily: "MontserratBold",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            " FCFA",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 16,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: longueurPerCent(10, context),),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(30.0, context)),
                          child: Text(
                            "LIVRAISON",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 18,
                                fontFamily: "Montserrat_Light"),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(
                            "${widget.prixLivraison}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: HexColor("#909090"),
                              fontSize: 16,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: longueurPerCent(0.0, context),
                                right: longueurPerCent(0.0, context),
                                left: longueurPerCent(2.0, context)),
                            child: Text(
                              " FCFA",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 16,
                                fontFamily: "MontserratBold",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: longueurPerCent(20, context),),
                    Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.1,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: longueurPerCent(30, context),right: longueurPerCent(10, context)),
                      height: longueurPerCent(1, context),
                    ),
                    SizedBox(height: longueurPerCent(10, context),),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: longueurPerCent(0.0, context),
                              right: longueurPerCent(0.0, context),
                              left: longueurPerCent(30.0, context)),
                          child: Text(
                            "TOTAL",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#909090"),
                                fontSize: 18,
                                fontFamily: "Montserrat_Light",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            "${widget.total}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: HexColor("#001C36"),
                              fontSize: 17,
                              fontFamily: "MontserratBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: longueurPerCent(0.0, context),
                                right: longueurPerCent(0.0, context),
                                left: longueurPerCent(3.0, context)),
                            child: Text(
                              " FCFA",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: HexColor("#001C36"),
                                fontSize: 17,
                                fontFamily: "MontserratBold",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: longueurPerCent(25, context),
                    ),
                    SizedBox(height: longueurPerCent(20, context)),
                    button(HexColor("#FFFFFF"), HexColor("#001C36"), context,
                        'COMMANDER', () {
                      if(widget.moyenDePayement=="Mobile Money"){
                        if ( numeroDePayement.length==8 ) {
                          try {
                            /* FirestoreService().addCommande(
                              Commandes(
                                  nomComplet: widget.nomComplet,
                                  telephone: widget.telephone,
                                  quartier: widget.quartier,
                                  indication: widget.indication,
                                  dateHeureDeLivraison:
                                      widget.dateHeureDeLivraison,
                                  total: widget.total,
                                  moyenDePayement: moyenDePayement,
                                  numeroDePayement: numeroDePayement,
                                  produitsCommander: widget.produitsCommander,
                                  prixLivraison: widget.prixLivraison,
                                  lieuDeLivraison: widget.lieuDeLivraison,
                                  livrer: false,
                                  unSeulProduit: widget.unSeulProduit,
                                  created: DateTime.now().toString()),
                              Renseignements.emailUser);
                          FirestoreService().addCommandeToAdmin(
                              Commandes(
                                  nomComplet: widget.nomComplet,
                                  telephone: widget.telephone,
                                  quartier: widget.quartier,
                                  indication: widget.indication,
                                  dateHeureDeLivraison:
                                  widget.dateHeureDeLivraison,
                                  total: widget.total,
                                  unSeulProduit: widget.unSeulProduit,
                                  moyenDePayement: moyenDePayement,
                                  numeroDePayement: numeroDePayement,
                                  produitsCommander: widget.produitsCommander,
                                  prixLivraison: widget.prixLivraison,
                                  lieuDeLivraison: widget.lieuDeLivraison,
                                  created: DateTime.now().toString(),
                                  livrer: false),
                              Renseignements.emailUser);*/
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommandeSend()));
                          } catch (e) {
                            print(e);
                          }

                        } else {
                          displaySnackBarNom(context,
                              "Veuillez entrer votre numéro de payement", Colors.red);
                        }
                      } else {
                        try {
                          /* FirestoreService().addCommande(
                              Commandes(
                                  nomComplet: widget.nomComplet,
                                  telephone: widget.telephone,
                                  quartier: widget.quartier,
                                  indication: widget.indication,
                                  dateHeureDeLivraison:
                                      widget.dateHeureDeLivraison,
                                  total: widget.total,
                                  moyenDePayement: moyenDePayement,
                                  numeroDePayement: numeroDePayement,
                                  produitsCommander: widget.produitsCommander,
                                  prixLivraison: widget.prixLivraison,
                                  lieuDeLivraison: widget.lieuDeLivraison,
                                  livrer: false,
                                  unSeulProduit: widget.unSeulProduit,
                                  created: DateTime.now().toString()),
                              Renseignements.emailUser);
                          FirestoreService().addCommandeToAdmin(
                              Commandes(
                                  nomComplet: widget.nomComplet,
                                  telephone: widget.telephone,
                                  quartier: widget.quartier,
                                  indication: widget.indication,
                                  dateHeureDeLivraison:
                                  widget.dateHeureDeLivraison,
                                  total: widget.total,
                                  unSeulProduit: widget.unSeulProduit,
                                  moyenDePayement: moyenDePayement,
                                  numeroDePayement: numeroDePayement,
                                  produitsCommander: widget.produitsCommander,
                                  prixLivraison: widget.prixLivraison,
                                  lieuDeLivraison: widget.lieuDeLivraison,
                                  created: DateTime.now().toString(),
                                  livrer: false),
                              Renseignements.emailUser);*/
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommandeSend()));
                        } catch (e) {
                          print(e);
                        }
                      }

                    }),
                    Container(height: longueurPerCent(40, context),)
                  ],
                ),
              ),
            ),
          ));
    } else {
      return Scaffold(
        backgroundColor: HexColor("#001C36"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 197,
                width: 278,
              ),
              SizedBox(
                height: 50.0,
              ),
              SpinKitThreeBounce(
                color: HexColor('#FFFFFF'),
                size: 60,
              )
            ],
          ),
        ),
      );
    }
  }

  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 15)),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
