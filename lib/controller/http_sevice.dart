import 'dart:convert';
import 'package:alpha/values/end_points.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';


class HttpService {


  Future<List<Book>> fetchBooks(String baseUrl,String endPont) async {
    final response = await http.get(Uri.parse(baseUrl+endPont));

    if (response.statusCode == 200) {
      // Parse the JSON data
      final List<dynamic> data = jsonDecode(response.body)['books'];
      print(data);
      // Convert the list of dynamic data into a list of Book objects
      return data.map((bookJson) => Book.fromJson(bookJson)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
  Future<Book> fetchBookByISBN(String isbn) async {
    final response = await http.get(Uri.parse('${EndPoints.baseUrl}/books/$isbn'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Book.fromJson(data);
    } else {
      throw Exception('Failed to load book');
    }
  }
}