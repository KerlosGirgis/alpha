import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/http_sevice.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier{
  List<CartItem> cart = [];
  String total="";

  Future<void> getCart() async {
    double totalTempt=0;
    try{
      Map<String, dynamic> cartT = await getUserCart();
      List<String> ids=cartT.keys.toList();
      List<CartItem>cartT2=[];
      for(int i=0; i<cartT.length;i++){
        cartT2.add(CartItem(book: await HttpService().fetchBookByISBN(ids[i]),quantity: cartT[ids[i]]!));
      }
      cart=cartT2;
      notifyListeners();
    }
    catch(e){
      print(e.toString());
      return;
    }
    for(int i=0;i<cart.length;i++){
      totalTempt += cart[i].quantity*double.parse(cart[i].book.price.substring(1));
    }
    total=totalTempt.toStringAsFixed(2);
    notifyListeners();
  }

  // Add a book to user's cart
  Future<void> addBookToCart(String bookId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    await userDoc.update({
      'cart.$bookId': FieldValue.increment(1)
    });
  }

  //Remove a book from user's cart
  Future<void> removeBookFromCart(String bookId) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    await userDoc.update({
      'cart.$bookId': FieldValue.delete(),
    });
  }

  Future<void> decrementBookFromCart(String bookId) async {
    final firestore = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final userDoc = await firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data()?['cart'] != null) {
        final cart = userDoc.data()?['cart'] as Map<String, dynamic>;

        if (cart.containsKey(bookId)) {
          final currentQuantity = cart[bookId] as int;

          if (currentQuantity > 1) {
            // Decrement the quantity
            await firestore.collection('users').doc(userId).update({
              'cart.$bookId': FieldValue.increment(-1),
            });
            print('Book quantity decremented!');
          } else {
            // Remove the book from the cart
            await firestore.collection('users').doc(userId).update({
              'cart.$bookId': FieldValue.delete(),
            });
            print('Book removed from cart!');
          }
        } else {
          print('Book is not in the cart!');
        }
      } else {
        print('Cart does not exist!');
      }
    } catch (e) {
      print('Error decrementing book quantity: $e');
    }
  }

  // Get user's cart
  Future<Map<String, dynamic>> getUserCart() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final cart = userDoc['cart'] as Map<String, dynamic>;
    return cart;
  }
}