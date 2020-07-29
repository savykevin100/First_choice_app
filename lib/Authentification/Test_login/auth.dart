import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
}


class Auth {

  Future<String> signInWithEmailAndPassword(String email, String password) async{
    final user = await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return user.user.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return user.user.uid;
  }

  Future<String> currentUser() async{
    final user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

}