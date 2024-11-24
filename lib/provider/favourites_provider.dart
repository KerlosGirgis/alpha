import 'package:alpha/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controller/http_sevice.dart';

class FavouritesProvider with ChangeNotifier{
  List<Book> saved=[];

  bool checkIfSaved(String bookId){
    if(saved.isNotEmpty){
      for(int i=0;i<saved.length;i++){
        if(saved[i].id.compareTo(bookId)==0){
          return true;
        }
      }
      return false;
    }
    return false;
  }

  Future<void> getSaved() async {
    List<Book> temp=[];
    try {
      List cartIds = await getUserSavedBooks();
      for(int i=0; i<cartIds.length;i++){
        temp.add(await HttpService().fetchBookByISBN(cartIds[i]));
      }
      print(saved);
      saved = temp;
    } catch (e) {
      print(e.toString());
      return;
    }
    notifyListeners();
  }

  // Save a book to user's savedBooks list
  Future<void> saveBookToUser(String bookId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    await userDoc.update({
      'savedBooks': FieldValue.arrayUnion([bookId])
    });
  }

  //Remove a book from user's saved
  Future<void> removeBookFromSaved(String bookId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    await userDoc.update({
      'savedBooks': FieldValue.arrayRemove([bookId])
    });
  }

  // Get user's saved books
  Future<List<String>> getUserSavedBooks() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    List<String> savedBooks = List<String>.from(userDoc['savedBooks']);
    return savedBooks;
  }


}