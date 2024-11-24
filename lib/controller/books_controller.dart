import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BooksController{
  Future<void> saveBookToUser(String bookId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    await userDoc.update({
      'savedBooks': FieldValue.arrayUnion([bookId])
    });
  }

  Future<void> removeBookFromUser(String bookId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    await userDoc.update({
      'savedBooks': FieldValue.arrayRemove([bookId])
    });
  }
  Future<List<String>> getUserSavedBooks() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    List<String> savedBooks = List<String>.from(userDoc['savedBooks']);
    return savedBooks;
  }

}