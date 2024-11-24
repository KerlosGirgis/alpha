import 'package:alpha/provider/books_provider.dart';
import 'package:alpha/view/pages/navbar.dart';
import 'package:alpha/view/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';

class AuthService {
  // Handle authentication state
  Widget handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future:
                Provider.of<BooksProvider>(context, listen: false).getBooks(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return const Navbar();
            },
          );
        } else {
          return const WelcomePage();
        }
      },
    );
  }

  bool isSignedIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  // Sign up user with email, password, and name
  Future<void> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save the user name in Firestore
      String userId = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,
        'savedBooks': [],
        'cart': {},
        'address': Address(street: "", city: "", state: "", postalCode: "", country: ""),
        'avatar': 1,
      });
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

  // Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Get the current user's name
  Future<String> getUserName() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc['name'] as String;
  }

  Future<String> getUserToken() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> getUserEmail() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String? email = FirebaseAuth.instance.currentUser!.email;
    return email!;
  }

  Future<Address> getAddress() async {

      String userId = FirebaseAuth.instance.currentUser!.uid;
      // Reference to the user's document in Firestore
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch the document snapshot
      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        // Extract address field
        final address = docSnapshot.data()?['address'] as Map<String, dynamic>?;

          return Address.fromMap(address!);

      }
      return Address(street: "", city: "", state: "", postalCode: "", country: "");
  }
}
