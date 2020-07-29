import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:premierchoixapp/Composants/calcul.dart';
import 'package:premierchoixapp/Composants/hexadecimal.dart';
import 'package:premierchoixapp/Authentification/Decision.dart';




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
        title: "ACHAT",
        styleTitle:
        TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'MontserratBold'),
        description:
        "Commander vos produits et faites vous livrez",
        styleDescription:
        TextStyle(color: HexColor("#909090"), fontSize: 18.0, fontFamily: 'Regular'),
        pathImage: "assets/images/images-03.png",
      ),
    );
    slides.add(
      new Slide(
        title: "SUR MESURE",
        styleTitle:
        TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'MontserratBold'),
        description: "Faites retoucher vos achats sur mesure",
        styleDescription:
        TextStyle(color:HexColor("#909090"), fontSize: 18.0,  fontFamily: 'Regular'),
        pathImage: "assets/images/images-01.png",

      ),
    );
    slides.add(
      new Slide(
        title: "PARTAGE",
        styleTitle:
        TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'MontserratBold'),
        description:
        "Recommander un produit à un ami",
        styleDescription:
        TextStyle(color:HexColor("#909090"), fontSize: 18.0,  fontFamily: 'Regular'),
        pathImage: "assets/images/images-02.png",

      ),
    );
  }

  void onDonePress() {
    Navigator.pushNamed(context, Decision.id);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Container(
      width: largeurPerCent(50.0, context),
      height: longueurPerCent(50.0, context),
      decoration: BoxDecoration(
        color:HexColor("#FFC30D"),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: Icon(
        Icons.navigate_next,
        color:HexColor("#001c36"),
        size: 35.0,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Container(
      width: largeurPerCent(50.0, context),
      height: longueurPerCent(50.0, context),
      decoration: BoxDecoration(
        color: HexColor("#FFC30D"),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: Icon(
        Icons.done,
        color: HexColor("#001c36"),
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

              Container(
                padding: EdgeInsets.only(left: longueurPerCent(50, context),right: longueurPerCent(50, context)),
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 40.0),
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
          color: HexColor("#FFFFFF"),
          fontFamily: " Regular",
          fontSize: 16
      ),


      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,



      // Dot indicator
      colorDot: Colors.white,
      sizeDot: 10.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: HexColor("#001c36"),
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