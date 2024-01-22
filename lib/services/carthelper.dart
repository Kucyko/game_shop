
import 'dart:convert';

import 'package:online_shop/controllers/add_to_cart.dart';
import 'package:online_shop/controllers/get_products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class CartHelper {
  static var client = http.Client();

  Future<bool> addToCart(AddToCart model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.https(Config.apiUrl, Config.addCartUrl);

    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.https(Config.apiUrl, Config.getCartUrl);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {

      var jsonData = json.decode(response.body);
      List<Product> cart = [];
      var products = jsonData[0]['products'];
      cart = List<Product>.from(products.map((product) => Product.fromJson(product)));
      return cart;
    } else {
      throw Exception("Failed to get cart items");
    }
  }
  Future<bool> deleteItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.https(Config.apiUrl, "${Config.addCartUrl}/$id");

    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}