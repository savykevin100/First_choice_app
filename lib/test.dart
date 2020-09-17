import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  static String id="Test";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 150.0,
          width: 300.0,
          child: Carousel(
            boxFit: BoxFit.cover,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(seconds: 1),
            dotSize: 6.0,
            dotIncreasedColor: Color(0xFFFF335C),
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 10.0,
            indicatorBgPadding: 7.0,
            images: [
              Image.asset( 'assets/images/gadgets-336635_1920.jpg',),
              Image.asset(  'assets/images/make-up-1209798_1920.jpg',),
              Image.asset(   'assets/images/sketchbook-156775_1280.png',),
            ],
          ),
        ),
      ),
    );
  }
}