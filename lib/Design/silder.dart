import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Design/Decision.dart';
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
        description: "Commendez vos vêtements et faites-vous livrer ",
        styleDescription:
        TextStyle(
          color: HexColor("#FFFFFF"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 18,
        ),
        pathImage: 'assets/images/images-03.png',
        heightImage: 280,
        backgroundColor: HexColor("#001c36"),



      ),
    );


    slides.add(
      new Slide(
        description: "Faites retoucher vos achats sur mesure ",
        //marginDescription: EdgeInsets.only( right: 47, top: 216),
        styleDescription:
        TextStyle(
          color: HexColor("#FFFFFF"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 18,
        ),
        pathImage: 'assets/images/images-04.png',
        heightImage: 280,
        backgroundColor: HexColor("#001c36"),



      ),
    );


    slides.add(
      new Slide(
        description: "Recommander un produit à un ami ",
        //marginDescription: EdgeInsets.only( right: 47, top: 216),
        styleDescription:
        TextStyle(
          color: HexColor("#FFFFFF"),
          fontFamily: "Helvetica Neue, Regulart",
          fontSize: 18,
        ),
        pathImage: 'assets/images/images-02.png',
        heightImage: 280,
        backgroundColor: HexColor("#001c36"),



      ),
    );

  }

  void onDonePress() {
    Navigator.pushNamed(context, Decision.id);
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
          color: HexColor("#FFFFFF"),
          fontFamily: " Regular",
          fontSize: 14
      ),

      // Render done button
      nameDoneBtn: "OK" ,
      styleNameDoneBtn:
      TextStyle(
          color: HexColor("#FFFFFF"),
          fontFamily: " Regular",
          fontSize: 14
      ),

      // Render done button
      namePrevBtn: "PRÉCEDENT" ,
      nameNextBtn: "SUIVANT",
      styleNamePrevBtn:
      TextStyle(
          color: HexColor("#FFFFFF"),
          fontFamily: " Regular",
          fontSize: 14
      ),

      // Show or hide status bar
      shouldHideStatusBar: false,
      

    );

  }

}
