import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createInWithEmailAndPassword(String email, String password);


  }
class Auth extends BaseAuth{

   Future<String> signInWithEmailAndPassword(String email, String password) async{
     final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
     return user.user.uid;
   }

   Future<String> createInWithEmailAndPassword(String email, String password) async{
     final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
     return user.user.uid;
   }
}