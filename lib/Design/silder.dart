import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Design/Page1.dart';



class IntroScreen extends StatefulWidget {
  static String id = "introScreen";
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}



class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();



    slides.add(
      new Slide(
        description: "Rechercher les produits de votre choix ",
        //marginDescription: EdgeInsets.only( right: 47, top: 216),
        styleDescription:
        TextStyle(
          color: HexColor("#001B36"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 20,
        ),
        pathImage: 'assets/images/marketeurLogo.jpeg',
        widthImage: 3275,
        heightImage: 232,
        backgroundColor: Colors.red,



      ),
    );
    slides.add(
      new Slide(

        description: "Ajoutez-les au panier",
        //marginDescription: EdgeInsets.only( right: 47, top: 216),
        styleDescription:
        TextStyle(
          color: HexColor("#001B36"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 20,
        ),
        pathImage: 'assets/images/marketeurLogo.jpeg',
        widthImage: 3275,
        heightImage: 232,
        backgroundColor: HexColor("#FFFFFF"),

      ),
    );

    slides.add(
      new Slide(

        description: "Commandez et Faites-vous livrez",
        //marginDescription: EdgeInsets.only( right: 47, top: 216),
        styleDescription:
        TextStyle(
          color: HexColor("#001B36"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 20,
        ),
        pathImage: 'assets/images/marketeurLogo.jpeg',
        widthImage: 3275,
        heightImage: 232,
        backgroundColor: HexColor("#FFFFFF"),

      ),
    );

    slides.add(
      new Slide(

        description: "Recommander des produits à vos proche ",
       // marginDescription: EdgeInsets.only( right: 47, top: 216),
        styleDescription:
        TextStyle(
          color: HexColor("#001B36"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 20,
        ),
        pathImage: 'assets/images/marketeurLogo.jpeg',
        widthImage: 3275,
        heightImage: 232,
        backgroundColor: HexColor("#FFFFFF"),

      ),
    );
  }

  void onDonePress() {
    Navigator.pushNamed(context, Page1.id);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,

      // Render skip button
      nameSkipBtn: "SAUTÉ" ,
      styleNameSkipBtn:
      TextStyle(
          color: HexColor("#001B36"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 15
      ),

      // Render done button
      nameDoneBtn: "OK" ,
      styleNameDoneBtn:
      TextStyle(
          color: HexColor("#001B36"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 15
      ),

      // Render done button
      namePrevBtn: "PRÉCEDENT" ,
      nameNextBtn: "SUIVANT",
      styleNamePrevBtn:
      TextStyle(
          color: HexColor("#001B36"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 15
      ),

      // Show or hide status bar
      shouldHideStatusBar: false,
      

    );

  }

}
