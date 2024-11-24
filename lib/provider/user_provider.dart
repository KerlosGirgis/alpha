import 'package:alpha/controller/auth_service.dart';
import 'package:alpha/models/address.dart';
import 'package:alpha/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User user = User(name: "", token: "", email: '',address: Address(street: "", city: "", state: "", postalCode: "", country: ""));

  Future<void> getUserData() async {
    user = User(
      name: await AuthService().getUserName(),
      token: await AuthService().getUserToken(),
      email: await AuthService().getUserEmail(),
      address: await AuthService().getAddress(),
    );
    print(user.address);
    //await getCart();
    notifyListeners();
  }
  Future<void> addAddress({
    required String userId,
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
  }) async {
    try {
      // Reference to the user's document in Firestore
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // New address data
      final addressData = {
        'street': street,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
      };

      // Update the user's address in Firestore
      await userDoc.update({'address': addressData});

      print('Address updated successfully!');
    } catch (e) {
      print('Failed to update address: $e');
    }
  }
}
