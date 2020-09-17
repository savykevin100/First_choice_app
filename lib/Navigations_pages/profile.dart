import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/renseignements.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Models/utilisateurs.dart';

class UserProfil extends StatefulWidget{
  static String id='Userprofil';

  String userCurrent;
  String firstLetter;
  UserProfil({this.userCurrent, this.firstLetter});

  @override
  _UserProfilState createState() => new _UserProfilState();

}

class _UserProfilState extends State<UserProfil>{
  final _auth = FirebaseAuth.instance;
  Utilisateur donneesUtilisateurConnecte;
  Firestore _db = Firestore.instance;
  String name;

  Future<void> fetchDataUser() async {
    await _db
        .collection("Utilisateurs")
        .document(Renseignements.emailUser)
        .get()
        .then((value) {
      if (this.mounted) {
        setState(() {
          name = value.data["nomComplet"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataUser();
  }
  @override
  Widget build(BuildContext context ){

if(name!=null){
  TextEditingController _userNameController;
  bool userNameControllerEnable =false;
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
                  ],
                ),
                SizedBox(height: longueurPerCent(30.0, context) ,),
                Stack(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Text(
                            name[0],
                            style: TextStyle(color: HexColor("#001c36"), fontSize: 70,fontWeight: FontWeight.bold),
                          ),
                        ),
                        radius: 70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                Text(
                  name,
                  style:TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MontserratBold',
                    color: HexColor("#FFFFFF"),
                  ),
                ),

                SizedBox(height: longueurPerCent(10.0, context)),
                Text(
                  Renseignements.emailUser,
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
                                  "Paramètre du compte",
                                  style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 20.0, fontWeight: FontWeight.bold ),
                                ),
                              ),
                            ),
                            SizedBox(height: longueurPerCent(20,context),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: new Container(
                                    height: longueurPerCent(20.0, context),
                                    width: largeurPerCent(300, context),
                                    color: Colors.grey,
                                    child: Center(
                                      child: TextField(
                                          controller:
                                          _userNameController,
                                          //Set this field to enable or disable (true or flase)
                                          enabled: userNameControllerEnable,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "MonseraBold"),
                                          decoration: InputDecoration(
                                            hintText: name,
                                            hintStyle: TextStyle(
                                                color:
                                                Colors.white,
                                                fontSize: 16.0,
                                                fontFamily:
                                                'MonseraBold'),
                                            contentPadding: EdgeInsets.only(
                                              top: longueurPerCent(5, context),
                                            ),
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(

                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        7.0)),
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle
                                                        .none)),
                                          ),
                                          onChanged: (value) {}),
                                    ),
                                  ),
                                ),
                                IconButton(icon: Icon(Icons.auto_fix_high), onPressed: null)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Container(
                                      color: Colors.red,
                                      margin: EdgeInsets.only(top: longueurPerCent(10.0, context), right: longueurPerCent(30.0, context), left: longueurPerCent(30.0, context), ),
                                      child: TextField(
                                        //controller: _textFieldController,
                                        //enabled: !_isEnabled,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: HexColor("#909090"),
                                          fontFamily: "MonseraBold",
                                        ),
                                        decoration: InputDecoration(
                                          hintText:
                                          "HOUEGBELO Jean de Dieu Amour",
                                          hintStyle: TextStyle(
                                            color: HexColor("#909090"), fontFamily: 'Montserrat_Light',fontSize: 17.0,
                                          ),
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.only(
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      7.0)),
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  style:
                                                  BorderStyle.none)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: longueurPerCent(15.0, context),),

                            SizedBox(height: longueurPerCent(15.0, context),),

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
               /* Container(
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
                              "Tableau Mensurations",
                              style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 20.0, fontWeight: FontWeight.bold ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                ),*/
                SizedBox(height: longueurPerCent(75.0, context),),
                new Container(),
              ],
            ),
          )
        ],
      ),
    ),
  );

} else {
  return Scaffold(
    appBar: AppBar(
      title: Text("Mon compte", style: TextStyle(color: Colors.white, fontFamily: "MontserratBold",fontSize: 24.0,fontWeight: FontWeight.bold),),
    ),
    body: Center(child: CircularProgressIndicator(),),
  );
}

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