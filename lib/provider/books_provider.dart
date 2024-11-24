import 'package:alpha/models/book.dart';
import 'package:flutter/material.dart';

import '../controller/http_sevice.dart';
import '../values/end_points.dart';

class BooksProvider with ChangeNotifier{
  List<Book> books = [];
  Future<void> getBooks() async {
    try {
      books= await HttpService().fetchBooks(EndPoints.baseUrl,EndPoints.newEndPoint);
      print(books);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }

  }
}