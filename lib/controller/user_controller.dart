import 'package:firebase_auth/firebase_auth.dart';

class UserController{
  // Sign up user
  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e); // Handle errors
    }
  }

// Sign in user
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e); // Handle errors
    }
  }

}