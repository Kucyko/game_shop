import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_shop/models/login_res_model.dart';
import 'package:online_shop/models/profile_model.dart';
import 'package:online_shop/models/signup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';
import 'config.dart';

class AuthHelper {
  static var client = http.Client();

  Future<bool> login(LoginModel model) async {
    Map<String, String> requsetHeaders = {
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiUrl, Config.loginUrl);

    var response = await client.post(
        url, headers: requsetHeaders, body: jsonEncode(model.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;
      await prefs.setString('token', userToken);
      await prefs.setString('userId', userId);
      await prefs.setBool('isLogged', true);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(SignupModel model) async {
    Map<String, String> requsetHeaders = {
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiUrl, Config.signupUrl);

    var response = await client.post(
        url, headers: requsetHeaders, body: jsonEncode(model.toJson()));
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requsetHeaders = {
      'Content-Type': 'application/jason',
      'token': 'Bearer $userToken'
    };
    var url = Uri.https(Config.apiUrl, Config.getUserUrl);

    var response = await client.post(url, headers: requsetHeaders);

    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception("Failed to get the profile");
    }
  }
}