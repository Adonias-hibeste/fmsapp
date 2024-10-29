import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:membermanagementsystem/models/category.dart';
import 'package:membermanagementsystem/models/product.dart';

class ApiService {
  Future<List<dynamic>> fetchMemberships() async {
    final response = await http.get(Uri.parse(url + 'memberships'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load memberships');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(url + 'categories'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Category.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url + 'products'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print('Fetched products: $jsonResponse'); // Debug print
      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
