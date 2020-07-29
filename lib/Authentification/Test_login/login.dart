import 'package:flutter/material.dart';
import 'package:premierchoixapp/Authentification/components/firebase_auth_services.dart';


class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  LoginPage({this.auth, this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormeType{
  login,
  register
}
class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  FormeType _formeType = FormeType.login;


  bool validateAndSave(){
   final form= _formKey.currentState;
   if(form.validate()){
     form.save();
     return true;
   }
   return false;
  }

  void validateAndSubmit() async{
    if(validateAndSave()){
      try {
        if(_formeType == FormeType.login) {
          String userId= await widget.auth.signInWithEmailAndPassword(email, password);
          print("Connexion $userId");
        } else {
          String userId = await widget.auth.createInWithEmailAndPassword(email, password);
          print("Registered $userId");
        }
        widget.onSignedIn();
       }
       catch (e){
        print(e);
       }
      }
  }

  void moveToRegister(){
    _formKey.currentState.reset();
    setState(() {
      _formeType = FormeType.register;
    });
  }

  void moveToLogin(){
    _formKey.currentState.reset();
    setState(() {
      _formeType = FormeType.login;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: builInputs()+buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> builInputs(){
    return [
      TextFormField(
        decoration: InputDecoration(
            labelText: "Email"
        ),
        validator: (value)=>value.isEmpty?"Email ne doit pas etre null":null,
        onSaved: (value) => email=value,
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: "Password",
        ),
        validator: (value)=>value.isEmpty?"Mot de passe ne doit pas etre null":null,
        obscureText: true,
        onSaved: (value)=> password=value,
      ),
    ];
  }
  List<Widget>  buildSubmitButtons(){
    if(_formeType == FormeType.login){
      return [
        RaisedButton(onPressed: validateAndSubmit, child: Text("Login"),),
        FlatButton(
          child: Text("Creez un compte"),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        RaisedButton(onPressed: validateAndSubmit, child: Text("Creez un compte"),),
        FlatButton(
          child: Text("Vous avez un compte? Connectez-vous"),
          onPressed: moveToLogin,
        )
      ];
    }

  }
}
