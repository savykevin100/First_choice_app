import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Composants/calcul.dart';
import '../Composants/hexadecimal.dart';


class Page1 extends StatefulWidget {
static String id="Page1";
@override
_Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation carouselAnimation;


/* Liste de photos qui contient les images à defiler dans le carousel */
  int photoIndex = 0;
  List<String> photos = [
    "Commendez vos vêtements et faites-vous livrer",
    "Faites retoucher vos achats sur mesure",
    "Recommander un produit à un ami",
  ];

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 18), vsync: this);

    carouselAnimation =
    IntTween(begin: 0, end: photos.length - 1).animate(animationController)
      ..addListener(() {
        setState(() {
          photoIndex = carouselAnimation.value;
        });
      });

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  /*Fin de l'initialisation de la page*/

  Widget carousel(){
    return  Stack(
      children: <Widget>[
        Center(
          //margin: EdgeInsets.only(top: longueurPerCent(0, context)),
          child: Text(
              photos[photoIndex],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold,fontFamily: "MontserratBold"
            ),
          ),
        ),
        Positioned(
          top: longueurPerCent(250.0, context),
          left: largeurPerCent(57, context),
          child: SelectedPhoto(
              photoIndex: photoIndex, numberOfDots: photos.length),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F5F5F5"),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: BackgroundClipper(),
              child:Column(
                children: <Widget>[
                   Container(
                      width: MediaQuery.of(context).size.width ,
                      height: longueurPerCent(400.6, context),
                      decoration: BoxDecoration(
                        color: HexColor("#001C36"),
                      ),

                       child: Container(
                         margin: EdgeInsets.only(top: longueurPerCent(40.0, context),left: longueurPerCent(105.0, context),right: longueurPerCent(105.0, context)),
                           child:Center(
                             child:carousel(),
                           )
                       ),
                  ),
                ],
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: HexColor("#FFC30D")),
                      ),
                      child: Material(
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
                        border: Border.all(color: HexColor("#001C36"))
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "S'INSCRIRE",
                          style: TextStyle(color: HexColor("#001C36"), fontFamily: 'MontserratBold', fontSize: 16.0, fontWeight: FontWeight.bold ),
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
    var roundnessFactor = 55.0;

      var path = Path();

path.lineTo(0, size.height);
path.lineTo(0, size.height - size.height * 0.20 );
path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
path.lineTo(size.width - 355, size.height);
path.quadraticBezierTo(size.width, size.height -60, size.width, size.height -120);
path.lineTo(size.width + 1000,0);
return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}


class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return Center(
      child: new Container(
          child: new Padding(
            padding: const EdgeInsets.only(left: 9.0, right: 9.0),
            child: Container(
              height: 12.0,
              width: 12.0,
              decoration: BoxDecoration(
                  color:  HexColor('#ffffff'), borderRadius: BorderRadius.circular(10.0)),
            ),
          )),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 9.0, right: 9.0),
        child: Container(
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
              color:  Colors.yellow,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white, spreadRadius: 0.0, blurRadius: 10.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}


