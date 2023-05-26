import 'dart:convert';

import 'package:http/http.dart' as http;

class HomeService {

  Future<List<dynamic>> getCategory() async {
    final response = await http.get(Uri.parse('https://us-central1-shope-2c566.cloudfunctions.net/getCategories'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> getBestSelling() async {
    final response = await http.get(Uri.parse('https://us-central1-shope-2c566.cloudfunctions.net/getBestSellingProducts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load best-selling products');
    }
  }
}