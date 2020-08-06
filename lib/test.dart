import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id="HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime date;
  int temps;
  int lenght;
  int seconds=8;


  void initState() {
    super.initState();
    date = DateTime.now();
    Timer(Duration(seconds: seconds), () {
     setState(() {
       temps=1;
     });
      print("Yeah, this line is printed after 3 second");
    });
    print('This line is printed first');
  setState(() {
    temps=0;
  });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: (temps==0)?Text("Ça va disparaître dans 2 min"):Text("Initialisation de l'état")
      ),
    );
  }
}
