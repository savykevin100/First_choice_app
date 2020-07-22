import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class Decision extends StatefulWidget {
  static String id="Decision";
  @override
  _DecisionState createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              margin:EdgeInsets.only(top:MediaQuery.of(context).size.height/4),
              child: Center(
                child: ClipPath(
                  clipper: BackgroundClipper(),
                  child:Container(
                    margin:EdgeInsets.only(),
                    width: MediaQuery.of(context).size.width ,
                    height: MediaQuery.of(context).size.height ,
                    decoration: BoxDecoration(
                      color: HexColor("#001C36"),
                    ),

                    child: Container(
                       // margin: EdgeInsets.only(top: longueurPerCent(40.0, context),left: longueurPerCent(105.0, context),right: longueurPerCent(105.0, context)),
                        child:Center(
                        )
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Column(
                children: <Widget>[
                  SizedBox(height:longueurPerCent(486.4, context)),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(right: longueurPerCent(18.0, context),left: longueurPerCent(18.0, context),),
                      height: longueurPerCent(50.0, context),
                      width: largeurPerCent(339.0, context),
                      child: Material(
                        borderRadius: BorderRadius.circular(7.0),
                        //shadowColor: Colors.greenAccent,
                        color: HexColor("#FFC30D"),
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'SE CONNECTER',
                              style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:longueurPerCent(35.0, context)),
                  Container(
                    margin: EdgeInsets.only(right: longueurPerCent(18.0, context),left: longueurPerCent(18.0, context),),
                    height: longueurPerCent(50.0, context),
                    width: largeurPerCent(339.0, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(color: HexColor("#FFC30D"))
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "S'INSCRIRE",
                          style: TextStyle(color: HexColor("#FFFFFF"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: longueurPerCent(50.0, context),),
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

class BackgroundClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;

    var path = Path();

    path.moveTo(0, size.height *0.3);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width  , roundnessFactor *2.3 );
    path.quadraticBezierTo(size.width -10, roundnessFactor, size.width -roundnessFactor * 1.5, roundnessFactor*1.5);

    path.lineTo(roundnessFactor * 0.6 ,  size.height * 0.32-roundnessFactor*0.3  );
    path.quadraticBezierTo(0, size.height*0.32 , 0, size.height * 0.33 +roundnessFactor);




    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}

