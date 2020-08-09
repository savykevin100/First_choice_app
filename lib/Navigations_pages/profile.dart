import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

class UserProfil extends StatefulWidget{
  static String id='Userprofil';
  @override
  _UserProfilState createState() => new _UserProfilState();

}

class _UserProfilState extends State<UserProfil>{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context ){


    return Scaffold(
      body: new SingleChildScrollView(
              child: new Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(color: HexColor("#001C36"),height: MediaQuery.of(context).size.height,),
                    clipper: getClipper(),
                  ),
                  Positioned(
                    //width: MediaQuery.of(context).size.width,
                    //top: MediaQuery.of(context).size.height/5,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: longueurPerCent(31.1, context),),
                       Row(
                         children: <Widget>[
                           Container(
                             margin: EdgeInsets.only(left: longueurPerCent(0.9, context)),
                               child: Center(
                                 child: IconButton(
                                   icon: Icon(Icons.arrow_back),
                                   color: Colors.white,
                                   onPressed: (){
                                     setState(() {
                                       Navigator.pop(context);
                                     });
                                   },
                                 ),
                               )
                           ),
                           Center(
                             child: Text(
                               "Mon compte",
                               style: TextStyle(color: Colors.white, fontFamily: "MontserratBold",fontSize: 24.0,fontWeight: FontWeight.bold),
                             ),
                           ),
                           Container(
                               margin: EdgeInsets.only(left:longueurPerCent(120.0, context),top: longueurPerCent(0, context)),
                             child: Center(
                               child: IconButton(
                                 icon: Icon(Icons.favorite_border),
                                 color: Colors.white,
                                 onPressed: (){
                                   setState(() {
                                     // A toi de jouer
                                   });
                                 },
                               ),
                             )
                           ),
                           Container(
                               margin: EdgeInsets.only(left: longueurPerCent(0.0, context)),
                               child: Center(
                                 child: IconButton(
                                   icon: Icon(Icons.shopping_basket),
                                   color: Colors.white,
                                   onPressed: (){
                                     setState(() {
                                       // A toi de jouer
                                     });
                                   },
                                 ),
                               )
                           ),
                         ],
                       ),
                        SizedBox(height: longueurPerCent(30.0, context) ,),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/images/user33312571280.png"),
                                radius: 70,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        Text(
                       "SAVY Kevin",
                          style:TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratBold',
                            color: HexColor("#FFFFFF"),
                          ),
                        ),

                        SizedBox(height: longueurPerCent(10.0, context)),
                        Text(
                          "savykevin100@gmail.com",
                          style:TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Montserrat_Light',
                            color: HexColor("#FFFFFF"),
                          ),
                        ),
                        new Column(
                          children: <Widget>[
                            SizedBox(height: longueurPerCent(20, context)),
                            Container(
                              height: longueurPerCent(320.0, context),
                              width: largeurPerCent(348.0, context),
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                elevation: 7.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: longueurPerCent(10.0, context),),
                                    Container(
                                      //padding: EdgeInsets.only(top: longueurPerCent(10.0, context), right: longueurPerCent(65.0, context), left:longueurPerCent(62.0, context),),
                                      child: Center(
                                        child: Text(
                                          "Informations personnelles",
                                          style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 20.0, fontWeight: FontWeight.bold ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: longueurPerCent(40.0, context),),
                                    new Container(
                                      height: longueurPerCent(19.0, context),
                                      width: largeurPerCent(300, context),
                                      child: Text(
                                        "Nom"+ " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " +  "SAVY Kevin",
                                        style: TextStyle(
                                          color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: longueurPerCent(15.0, context),),
                                    new Container(
                                      height: longueurPerCent(19.0, context),
                                      width: largeurPerCent(300, context),
                                      child: Text(
                                        "Prénoms"+ " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " +  "Jean de Dieu  Amour",
                                        style: TextStyle(
                                          color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: longueurPerCent(15.0, context),),
                                    new Container(
                                      height: longueurPerCent(19.0, context),
                                      width: largeurPerCent(300, context),
                                      child: Text(
                                        "Numéro"+ " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + "69063800",
                                        style: TextStyle(
                                          color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: longueurPerCent(15.0, context),),
                                    new Container(
                                      height: longueurPerCent(19.0, context),
                                      width: largeurPerCent(300, context),
                                      child: Text(
                                        "Anniversaire"+ " " + " " + " " + " " + " " + "08 Mars 2000",
                                        style: TextStyle(
                                          color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: longueurPerCent(15.0, context),),
                                    new Container(
                                      height: longueurPerCent(19.0, context),
                                      width: largeurPerCent(300, context),
                                      child: Text(
                                        "Ville"+ " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + "  Cotonou",
                                        style: TextStyle(
                                          color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:longueurPerCent(35.0, context)),
                                    Container(
                                      padding: EdgeInsets.only(right: longueurPerCent(16.0, context),left: longueurPerCent(16.0, context),top: largeurPerCent(6.0, context),),
                                      height: longueurPerCent(40.0, context),
                                      width: largeurPerCent(160.0, context),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(3.0),
                                        //shadowColor: Colors.greenAccent,
                                        color: HexColor("#001C36"),
                                        elevation: 7.0,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Center(
                                            child: Text(
                                              'ACTUALISER',
                                              style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 12.0, fontWeight: FontWeight.bold ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: longueurPerCent(16.0, context),),
                        Container(
                          height: longueurPerCent(420.0, context),
                          width: largeurPerCent(348.0, context),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            //shadowColor: Colors.greenAccent,
                            color: Colors.white,
                            elevation: 7.0,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: longueurPerCent(10.0, context),),
                                Container(
                                  //padding: EdgeInsets.only(top: longueurPerCent(10.0, context), right: longueurPerCent(65.0, context), left:longueurPerCent(62.0, context),),
                                  child: Center(
                                    child: Text(
                                      "Mensurations",
                                      style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 20.0, fontWeight: FontWeight.bold ),
                                    ),
                                  ),
                                ),



                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: longueurPerCent(75.0, context),),
                        new Container(),
                      ],
                    ),
                  )
                ],
              ),
                ),
            );

  }
}

// ignore: camel_case_types
class getClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = new Path();
    path.lineTo(0, size.height/1.6);
    path.lineTo(size.width + 110000 , 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}