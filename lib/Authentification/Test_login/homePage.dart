import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/firebase_auth_services.dart';


class HomePage1 extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  HomePage1({this.auth, this.onSignedOut});
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {

  Future<void> deconnexion() async {
    return await FirebaseAuth.instance.signOut();
  }
  void signOut() async {
    try {
       await deconnexion();
    }
    catch (e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Center(
          child: Text("Welcome"),
        ),
      ),
    );
  }
}
