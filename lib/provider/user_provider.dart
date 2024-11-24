import 'package:alpha/controller/auth_service.dart';
import 'package:alpha/models/book.dart';
import 'package:alpha/models/user.dart';
import 'package:flutter/material.dart';

import '../controller/http_sevice.dart';
import '../models/cart_item.dart';
import '../values/end_points.dart';

class UserProvider with ChangeNotifier{
  User user=User(name: "", token: "");

    Future<void> getUserData() async {
    user = User(name: await AuthService().getUserName(), token: await AuthService().getUserToken(),);
    //await getCart();
    notifyListeners();
  }
}