import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

class Article extends StatefulWidget{
  static String id="Article";
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      appBar: AppBar
        (
        backgroundColor: HexColor("#001c36"),

        title: Text("Sneekers", style: TextStyle(color: Colors.white, fontFamily: "MonseraBold"),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: (){
            setState(() {
              // A toi de jouer
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket),
            color: Colors.white,
            onPressed: (){
              setState(() {
                // A toi de jouer
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: longueurPerCent(26.0, context),left: longueurPerCent(9.0, context)),
                  child: Center(
                    child: Text(
                      "Sneek",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Montserrat_Light",
                        fontSize: 20.0,
                        color: HexColor("#909090"),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:longueurPerCent(24.0, context),right: longueurPerCent(8.0, context),left: longueurPerCent(137.0, context),),
                  height: longueurPerCent(38.0, context),
                  width: largeurPerCent(170.0, context),
                  child: Material(
                    //shadowColor: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(7.0),
                    color: HexColor("#001c36"),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'AJOUTER AU PANIER',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 11.0, fontWeight: FontWeight.bold ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: longueurPerCent(8.0, context),left: longueurPerCent(9.0, context),right: longueurPerCent(287.0, context)),
              child: Text(
                "5.000 F CFA",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "MontserratBold",
                  fontSize: 20.0,
                  color: HexColor("#001c36"),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: longueurPerCent(8.0, context),left: longueurPerCent(2.0, context),right: longueurPerCent(280.0, context)),
              child:StarRating(
                  rating: 2,
                starConfig: StarConfig(
                  size: 15,
                  fillColor: HexColor("#FFC30D"),
                  strokeColor: HexColor("#FFC30D"),
                  raysCount:5,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: longueurPerCent(10.5, context),left: longueurPerCent(10.0, context),right: longueurPerCent(287.0, context)),
              height: longueurPerCent(31.0, context),
              width: largeurPerCent(130.0, context),
              child: Material(
                borderRadius: BorderRadius.circular(13.0),
                color: HexColor("#F5F5F5"),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.only(top: longueurPerCent(0.0, context),left: longueurPerCent(0.0, context),),
                        onPressed: (){
                        },
                        icon: Icon(Icons.remove, color: HexColor("#001C36"),
                          size: 20,),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),left: longueurPerCent(2.0, context)),
                      child: Center(
                        child: Text(
                          "1",style: TextStyle(
                            fontFamily: "MontserratBold",
                            fontSize: 20.0,
                            color: HexColor("#001c36"),
                            fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: longueurPerCent(0.0, context),left: longueurPerCent(12.0, context),),
                      height: longueurPerCent(31.0, context),
                      width: largeurPerCent(38.0, context),
                      child: Material(
                        borderRadius: BorderRadius.circular(13.0),
                        color: HexColor("#001c36"),
                        child: IconButton(
                          padding: EdgeInsets.only(top: longueurPerCent(0.0, context),left: longueurPerCent(0.0, context),),
                          onPressed: (){
                          },
                          icon: Icon(Icons.add, color: HexColor("#FFFFFF"),size: 20,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: longueurPerCent(9.64, context),top: longueurPerCent(25.62, context),),
                    height: longueurPerCent(252.4, context),
                    width: largeurPerCent(260.43, context),
                    child: Card(
                      child: Container(
                        child: Image.asset("assets/images/gadgets-336635_1920.jpg",
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: longueurPerCent(43.17, context),top: longueurPerCent(25.62, context),),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: longueurPerCent(0.0, context),top: longueurPerCent(0.0, context),),
                          height: longueurPerCent(65.19, context),
                          width: largeurPerCent(61.0, context),
                          child: Card(
                            child: Container(
                              child: Image.asset("assets/images/gadgets-336635_1920.jpg",
                                fit: BoxFit.cover,),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: longueurPerCent(.0, context),top: longueurPerCent(29.0, context),),
                          height: longueurPerCent(65.19, context),
                          width: largeurPerCent(61.0, context),
                          child: Card(
                            child: Container(
                              child: Image.asset("assets/images/gadgets-336635_1920.jpg",
                                fit: BoxFit.cover,),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: longueurPerCent(0.0, context),top: longueurPerCent(29.0, context),),
                          height: longueurPerCent(65.19, context),
                          width: largeurPerCent(61.0, context),
                          child: Card(
                            child: Container(
                              child: Image.asset("assets/images/gadgets-336635_1920.jpg",
                                fit: BoxFit.cover,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(10.33, context),left: longueurPerCent(15.0, context)),
                    child: Center(
                      child: Text(
                        "Taille:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Regular",
                          fontSize: 14.0,
                          color: HexColor("#909090"),
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(10.33, context),left: longueurPerCent(9.0, context)),
                    child: Center(
                      child: Text(
                        "43",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "MontserratBold",
                            fontSize: 14.0,
                            color: HexColor("#001c36"),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(10.33, context),left: longueurPerCent(70.0, context)),
                    child: Center(
                      child: Text(
                        "Couleur:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Regular",
                          fontSize: 14.0,
                          color: HexColor("#909090"),
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: longueurPerCent(10.33, context),left: longueurPerCent(9.0, context)),
                    child: Center(
                      child: Text(
                        "Rouge",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "MontserratBold",
                            fontSize: 14.0,
                            color: HexColor("#001c36"),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: longueurPerCent(34.0, context),left: longueurPerCent(0.0, context),right: longueurPerCent(315.0, context)),
              child: Center(
                child: Text(
                  "Descriptif",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "MontserratBold",
                      fontSize: 14.0,
                      color: HexColor("#001c36"),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: longueurPerCent(6.0, context),left: longueurPerCent(17.0, context),right: longueurPerCent(30.0, context)),
              child: Container(
                height: longueurPerCent(200.0, context),
                width: largeurPerCent(332.0, context),
                child: Text(
                 "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Montserrat_Light",
                      fontSize: 14.0,
                      color: HexColor("#001c36"),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                 Container(
                  margin: EdgeInsets.only(top: longueurPerCent(40.0, context),left: longueurPerCent(20.0, context),),
                  height: longueurPerCent(50.0, context),
                  width: largeurPerCent(170.0, context),

                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    //shadowColor: Colors.greenAccent,
                    color: HexColor("#FFC30D"),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'ACHETER',
                          style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 14.0, fontWeight: FontWeight.bold ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: longueurPerCent(40.0, context),left: longueurPerCent(30.0, context),),
                  height: longueurPerCent(50.0, context),
                  width: largeurPerCent(170.0, context),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    //shadowColor: Colors.greenAccent,
                    color: HexColor("#001C36"),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'RECOMMANDER',
                          style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 14.0, fontWeight: FontWeight.bold ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: longueurPerCent(63.0, context),),
            new Container(),
          ],
        ),
      ),
    );
  }
}