import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';

class UserProfil extends StatefulWidget{
  static String id='Userprofil';
  String userCurrent;
  String firstLetter;
  UserProfil({this.userCurrent, this.firstLetter});

  @override
  _UserProfilState createState() => new _UserProfilState();

}

class _UserProfilState extends State<UserProfil>{
  @override
  Widget build(BuildContext context ){

    return new Scaffold(
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
                             margin: EdgeInsets.only(left: longueurPerCent(19.9, context)),
                               child: Center(
                                 child: IconButton(
                                   icon: Icon(Icons.arrow_back_ios),
                                   color: Colors.white,
                                   onPressed: (){
                                     setState(() {
                                       // A toi de jouer
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
                               margin: EdgeInsets.only(left:longueurPerCent(100.0, context)),
                             child: Center(
                               child: IconButton(
                                 icon: Icon(Icons.search),
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
                               margin: EdgeInsets.only(left: longueurPerCent(0.5, context)),
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
                              margin: EdgeInsets.only(right: longueurPerCent(148.0, context),left: longueurPerCent(148.0, context)),
                              width: largeurPerCent(95.0, context),
                              height: longueurPerCent(95.0, context),
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.all(Radius.circular(79.0)),
                                  boxShadow: [
                                    BoxShadow(blurRadius:7.0, color: Colors.black )
                                  ]
                              ),
                            ),
                            Positioned(
                              child:Container(
                                margin: EdgeInsets.only(right: longueurPerCent(148.0, context),left: longueurPerCent(224.0, context),top: longueurPerCent(65.0, context)),
                                width: largeurPerCent(25.0, context),
                                height: longueurPerCent(25.0, context),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                                ),
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    color: HexColor("#001C36"),
                                    padding: EdgeInsets.all(2.0),
                                    iconSize: longueurPerCent(22.0, context),

                                    onPressed: (){
                                      setState(() {
                                        // A toi de jouer
                                      });
                                    },
                                  )
                              ) ,
                            )
                          ],
                        ),


                        SizedBox(height: 24.0),
                        Text(
                          'Jean de Dieu HOUEGBELO',
                          style:TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratBold',
                            color: HexColor("#FFFFFF"),
                          ),
                        ),
                        SizedBox(height: longueurPerCent(10.0, context)),
                        Text(
                          'amourhouegbelo@gmail.com',
                          style:TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Montserrat_Light',
                            color: HexColor("#FFFFFF"),
                          ),
                        ),
                        SizedBox(height:longueurPerCent(19.0, context)),
                        Container(
                          height: longueurPerCent(30.0, context),
                          width: largeurPerCent(161.0, context),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            //shadowColor: Colors.greenAccent,
                            color: Colors.white,
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'Client',
                                style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 20.0, fontWeight: FontWeight.bold ),
                              ),
                            ),
                          ),
                        ),
                        new Column(
                          children: <Widget>[
                            SizedBox(height: longueurPerCent(50, context)),
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
                                        "Nom"+ " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " " + " HOUEGBELO",
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
                                      "Tableau de bord",
                                      style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 20.0, fontWeight: FontWeight.bold ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(40.0, context),),
                                new Container(
                                  height: longueurPerCent(19.0, context),
                                  width: largeurPerCent(300, context),
                                  child: Text(
                                    "Badge Client",
                                    style: TextStyle(
                                      color: HexColor("#001C36"), fontFamily: 'MontserratBold',fontSize: 17.0,fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(23.0, context),),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(46.0, context)),
                                        width: largeurPerCent(18.0, context),
                                        height: longueurPerCent(18.0, context),
                                        decoration: BoxDecoration(
                                          color: HexColor("#FFC30D"),
                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(0, context)),
                                        width: largeurPerCent(65.0, context),
                                        height: longueurPerCent(10.0, context),
                                        color: HexColor("#AFAFAF").withOpacity(0.24),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(0.0, context)),
                                        width: largeurPerCent(18.0, context),
                                        height: longueurPerCent(18.0, context),
                                        decoration: BoxDecoration(
                                          color: HexColor("#001C36"),
                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(0, context)),
                                        width: largeurPerCent(65.0, context),
                                        height: longueurPerCent(10.0, context),
                                        color: HexColor("#AFAFAF").withOpacity(0.24),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(0.0, context)),
                                        width: largeurPerCent(18.0, context),
                                        height: longueurPerCent(18.0, context),
                                        decoration: BoxDecoration(
                                          color: HexColor("#001C36"),
                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(0, context)),
                                        width: largeurPerCent(65.0, context),
                                        height: longueurPerCent(10.0, context),
                                        color: HexColor("#AFAFAF").withOpacity(0.24),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(0.0, context)),
                                        width: largeurPerCent(18.0, context),
                                        height: longueurPerCent(18.0, context),
                                        decoration: BoxDecoration(
                                          color: HexColor("#001C36"),
                                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(11.0, context),),
                                new Container(
                                  height: largeurPerCent(19.0, context),
                                  child: new Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(33.0, context)),
                                        width: largeurPerCent(65.0, context),
                                        height: longueurPerCent(20.0, context),
                                        child: Center(
                                          child: Text(
                                            "Nouveau",
                                            style: TextStyle(
                                              color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(10.0, context)),
                                        width: largeurPerCent(65.0, context),
                                        height: longueurPerCent(20.0, context),
                                        child: Center(
                                          child: Text(
                                            "Régulier",
                                            style: TextStyle(
                                              color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(10.0, context)),
                                        width: largeurPerCent(100.0, context),
                                        height: longueurPerCent(16.0, context),
                                        child: Center(
                                          child: Text(
                                            "Ambassadeur",
                                            style: TextStyle(
                                              color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: longueurPerCent(10.0, context)),
                                        width: largeurPerCent(25.0, context),
                                        height: longueurPerCent(16.0, context),
                                        child: Center(
                                          child: Text(
                                            "VIP",
                                            style: TextStyle(
                                              color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(60.0, context),),
                                new Container(
                                  height: longueurPerCent(20.0, context),
                                  width: largeurPerCent(300, context),
                                  child: Text(
                                    "Statistiques",
                                    style: TextStyle(
                                      color: HexColor("#001C36"), fontFamily: 'MontserratBold',fontSize: 17.0,fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(24.0, context),),
                                new Container(
                                  child: Text(
                                    "Commande en cours",
                                    style: TextStyle(
                                      color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(10.0, context),),
                                new Container(
                                  child: Text(
                                    "00",
                                    style: TextStyle(
                                      color: HexColor("#001C36"), fontFamily: 'MontserratBold',fontSize: 16.0,fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(30.0, context),),
                                new Container(
                                  child: Text(
                                    "Nombre de commande",
                                    style: TextStyle(
                                      color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: longueurPerCent(10.0, context),),
                                new Container(
                                  child: Text(
                                    "02",
                                    style: TextStyle(
                                      color: HexColor("#001C36"), fontFamily: 'MontserratBold',fontSize: 16.0,fontWeight: FontWeight.bold,
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
    path.lineTo(0, size.height);
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