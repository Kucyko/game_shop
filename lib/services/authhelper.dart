import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:online_shop/models/login_res_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';
import 'config.dart';

class AuthHelper {
  static var client = https.Client();

  Future<bool> login(LoginModel model) async {
    Map<String, String> requsetHeaders = {
      'Content-Type': 'application/jason'
    };
    var url = Uri.http(Config.apiUrl, Config.loginUrl);

    var response = await client.post(url, headers: requsetHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;
      return female.toList();
    } else {
      throw Exception("Failed get games list");
    }
  }
}