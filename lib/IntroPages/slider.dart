import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/IntroPages/ConditionsGenerales1.dart';




class IntroScreen extends StatefulWidget {
  static String id = "introScreen";
  IntroScreen({Key key}) : super(key: key);



  @override
  IntroScreenState createState() => new IntroScreenState();
}



class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  Function goToTab;

  @override
  void initState() {
    super.initState();



    slides.add(
      new Slide(
        title: "Bienvenue",
        styleTitle:
        TextStyle(color: HexColor("#001C36"), fontSize: 25.0, fontFamily: 'MonseraBold'),
        description:
        "Découvrer de la fripperies de bonnes qualité en fonction de votre bourse",
        styleDescription:
        TextStyle(color: HexColor("#001C36"), fontSize: 18.0, fontFamily: 'MonseraRegular'),
        pathImage: "assets/images/images-05.png",
      ),
    );
    slides.add(
      new Slide(
        title: "Achat-Livraison",
        styleTitle:
        TextStyle(color: HexColor("#001C36"), fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'MonseraBold'),
        description: "Commandez vos produits et faites-vous livrez",
        styleDescription:
        TextStyle(color:HexColor("#001C36"), fontSize: 18.0,  fontFamily: 'MonseraRegular'),
        pathImage: "assets/images/images-04.png",

      ),
    );
    slides.add(
      new Slide(
        title: "Partage",
        styleTitle:
        TextStyle(color: HexColor("#001C36"), fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'MonseraBold'),
        description:
        "Recommandez un produit à un ami",
        styleDescription:
        TextStyle(color:HexColor("#001C36"), fontSize: 18.0,  fontFamily: 'MonseraRegular'),
        pathImage: "assets/images/images-06.png",

      ),
    );
  }

  void onDonePress() {
    Navigator.pushNamed(context, ConditionGenerales1.id);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Container(
      child: CircleAvatar(
        backgroundColor: HexColor("#FFC30D"),
        child: Icon(
          Icons.navigate_next,
          color:HexColor("#001c36"),
          size: 40.0,
        ),
        radius: 70,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Container(
      child: CircleAvatar(
        backgroundColor: HexColor("#FFC30D"),
        child: Icon(
          Icons.done,
          color:HexColor("#001c36"),
          size: 40.0,
        ),
        radius: 70,
      ),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }


  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              SizedBox(height: 20,),
              Container(
                child: GestureDetector(
                    child: Image.asset(
                      currentSlide.pathImage,
                      width: 300.0,
                      height: 300.0,
                      fit: BoxFit.contain,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: longueurPerCent((50), context),right: longueurPerCent(50, context)),
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 40.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }


  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,


      // Render skip button
      nameSkipBtn: "Passer" ,
      styleNameSkipBtn:
      TextStyle(
          color: HexColor("#001C36"),
          fontFamily: " Regular",
          fontSize: 15
      ),


      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,



      // Dot indicator
      colorDot: HexColor("#001C36"),
      sizeDot: 10.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: HexColor("#FFFFFF"),
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: false,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,


    );

  }
}