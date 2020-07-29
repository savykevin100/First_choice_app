import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/firebase_auth_services.dart';
import 'login.dart';


class RootPage extends StatefulWidget {
RootPage({this.auth});
final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

 enum AuthStatus{
  notSignedIn,
   signedIn
 }

Future<FirebaseUser> getUser() async {
  return await FirebaseAuth.instance.currentUser();
}
class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      getUser().then((userId){
        setState(() {
         /// _authStatus=userId == null ? AuthStatus.notSignedIn:AuthStatus.signedIn;
        });
      });

  }

 void signedIn(){
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
 }
  @override
  Widget build(BuildContext context) {
    switch(_authStatus){
      case AuthStatus.notSignedIn:
      return LoginPage(auth: widget.auth, onSignedIn: signedIn,);
      case AuthStatus.signedIn:
        return Scaffold(
           body: Container(
              child: Text("Welcome"),
            )
        );
    }

  }
}
